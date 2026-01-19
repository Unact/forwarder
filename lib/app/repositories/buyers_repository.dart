import 'dart:io';
import 'dart:async';
import 'dart:convert';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:cross_file/cross_file.dart';
import 'package:crypto/crypto.dart';
import 'package:drift/drift.dart' show Value;
import 'package:geolocator/geolocator.dart';
import 'package:u_app_utils/u_app_utils.dart';

import '/app/constants/strings.dart';
import '/app/data/database.dart';
import '/app/entities/entities.dart';
import '/app/repositories/base_repository.dart';
import '/app/services/forwarder_api.dart';

class BuyersRepository extends BaseRepository {
  static const _kBuyerDeliveryPointPhotosFileFolder = 'buyer_delivery_point_photos';
  static final _buyerDeliveryPointPhotosCacheRepo = JsonCacheInfoRepository(
    databaseName: _kBuyerDeliveryPointPhotosFileFolder
  );
  static final buyerDeliveryPointPhotosCacheManager = CacheManager(
    Config(
      _kBuyerDeliveryPointPhotosFileFolder,
      stalePeriod: const Duration(days: 365),
      maxNrOfCacheObjects: 10000,
      repo: _buyerDeliveryPointPhotosCacheRepo,
      fileSystem: IOFileSystem(_kBuyerDeliveryPointPhotosFileFolder),
      fileService: HttpFileService(),
    ),
  );
  BuyersRepository(super.dataStore, super.api);

  Stream<List<BuyerEx>> watchBuyers() {
    return dataStore.buyersDao.watchBuyerExList();
  }

  Stream<List<Delivery>> watchDeliveries() {
    return dataStore.buyersDao.watchDeliveries();
  }

  Stream<BuyerDeliveryPointEx> watchBuyerDeliveryPointById(int id) {
    return dataStore.buyersDao.watchBuyerDeliveryPointExById(id);
  }

  Stream<BuyerEx> watchBuyerById(int buyerId, int deliveryId) {
    return dataStore.buyersDao.watchBuyerExById(buyerId, deliveryId);
  }

  Future<BuyerDeliveryPointEx?> getBuyerDeliveryPointByBuyerId(int buyerId) {
    return dataStore.buyersDao.getBuyerDeliveryPointExByBuyerId(buyerId);
  }

  Future<BuyerDeliveryPointEx> addBuyerDeliveryPoint(int buyerId) async {
    return await dataStore.transaction(() async {
      final newId = await dataStore.buyersDao.generateBuyerDeliveryPointId();
      await dataStore.buyersDao.addBuyerDeliveryPoint(
        BuyerDeliveryPointsCompanion.insert(
          id: Value(newId),
          buyerId: buyerId
        )
      );

      final point = await dataStore.buyersDao.getBuyerDeliveryPointEx(newId);

      return point;
    });
  }

  Future<void> addBuyerDeliveryPointPhoto(BuyerDeliveryPoint point, {
    required XFile file
  }) async {
    final fileData = await file.readAsBytes();
    final key = md5.convert(fileData);

    await dataStore.transaction(() async {
      final newId = await dataStore.buyersDao.generateBuyerDeliveryPointPhotoId();
      await dataStore.buyersDao.addBuyerDeliveryPointPhoto(
        BuyerDeliveryPointPhotosCompanion.insert(
          id: Value(newId),
          buyerDeliveryPointId: point.id,
          url: '',
          key: key.toString()
        )
      );
      await buyerDeliveryPointPhotosCacheManager.putFile('', fileData, key: key.toString());
    });
  }

  Future<void> updateBuyerDeliveryPoint(BuyerDeliveryPoint point, {
    ({ String? value })? info,
    ({ String? value })? phone,
    bool restoreDeleted = true
  }) async {
    final newPoint = BuyerDeliveryPointsCompanion(
      info: info == null ? const Value.absent() : Value(info.value),
      phone: phone == null ? const Value.absent() : Value(phone.value),
      isDeleted: restoreDeleted ? const Value(false) : const Value.absent()
    );

    await dataStore.buyersDao.updateBuyerDeliveryPoint(point.id, newPoint);
  }

  Future<void> deleteBuyerDeliveryPoint(BuyerDeliveryPoint point) async {
    await dataStore.buyersDao.updateBuyerDeliveryPoint(
      point.id,
      const BuyerDeliveryPointsCompanion(isDeleted: Value(true))
    );
  }

  Future<void> deleteBuyerDeliveryPointPhoto(BuyerDeliveryPointPhoto pointPhoto) async {
    await buyerDeliveryPointPhotosCacheManager.removeFile(pointPhoto.key);
    await dataStore.buyersDao.updateBuyerDeliveryPointPhoto(
      pointPhoto.id,
      const BuyerDeliveryPointPhotosCompanion(isDeleted: Value(true))
    );
  }

  Future<BuyerDeliveryPointEx?> save(BuyerDeliveryPointEx pointEx) async {
    final Map<BuyerDeliveryPointPhoto, String?> photos = {};
    for (var photo in pointEx.photos) {
      final file = await buyerDeliveryPointPhotosCacheManager.getFileFromCache(photo.key);
      if (file == null) continue;

      photos.putIfAbsent(photo, () => base64Encode(file.file.readAsBytesSync()));
    }

    Map<String, dynamic> point = {
      'id': pointEx.point.id,
      'is_new': pointEx.point.isNew,
      'is_deleted': pointEx.point.isDeleted,
      'buyer_id': pointEx.point.buyerId,
      'info': pointEx.point.info,
      'phone': pointEx.point.phone,
    };
    List<Map<String, dynamic>> pointPhotos = pointEx.photos.where((e) => e.needSync).map((e) => {
      'id': e.id,
      'is_new': e.isNew,
      'is_deleted': e.isDeleted,
      'file_data': photos[e]
    }).toList();

    try {
      final data = await api.saveBuyerDeliveryPoint(point, pointPhotos);
      final lastLoadTime = DateTime.now();
      final oldPoint = pointEx.point;
      final newPoint = data.buyerDeliveryPoint;

      await dataStore.transaction(() async {
        await dataStore.buyersDao.deleteBuyerDeliveryPoint(oldPoint.id);

        for (var oldPointPhoto in pointEx.photos) {
          await dataStore.buyersDao.deleteBuyerDeliveryPointPhoto(oldPointPhoto.id);
        }

        if (newPoint == null) return;

        await dataStore.buyersDao.addBuyerDeliveryPoint(
          newPoint.toDatabaseEnt(lastLoadTime).toCompanion(false)
        );

        for (var newPointPhoto in data.buyerDeliveryPointPhotos) {
          await dataStore.buyersDao.addBuyerDeliveryPointPhoto(
            newPointPhoto.toDatabaseEnt(lastLoadTime).toCompanion(false)
          );
        }
      });

      return newPoint != null ? await dataStore.buyersDao.getBuyerDeliveryPointEx(newPoint.id) : null;
    } on ApiException catch(e) {
      throw AppError(e.errorMsg);
    } catch(e, trace) {
      await Misc.reportError(e, trace);
      throw AppError(Strings.genericErrorMsg);
    }
  }

  Future<void> missed(Buyer buyer, Position position) async {
    Map<String, dynamic> location = {
      'latitude': position.latitude,
      'longitude': position.longitude,
      'accuracy': position.accuracy,
      'altitude': position.altitude,
      'speed': position.speed,
      'heading': position.heading,
      'point_ts': position.timestamp.toIso8601String()
    };

    try {
      final ApiBuyerOrderData data = await api.missed(buyer.buyerId, buyer.deliveryId, location);

      await dataStore.transaction(() async {
        final orders = data.orders.map((e) => e.toDatabaseEnt()).toList();
        final orderLines = data.orderLines.map((e) => e.toDatabaseEnt()).toList();
        final orderLineCodes = data.orderLineCodes.map((e) => e.toDatabaseEnt()).toList();
        final orderLinePackErrors = data.orderLinePackErrors.map((e) => e.toDatabaseEnt()).toList();
        final buyerDeliveryMarks = data.buyerDeliveryMarks.map((e) => e.toDatabaseEnt()).toList();
        final tasks = data.tasks.map((e) => e.toDatabaseEnt()).toList();
        final debts = data.debts.map((e) => e.toDatabaseEnt()).toList();

        await dataStore.buyersDao.loadBuyerDeliveryMarks(buyerDeliveryMarks, false);
        await dataStore.buyersDao.loadBuyerDeliveryMarks(buyerDeliveryMarks, false);
        await dataStore.buyersDao.loadBuyerDeliveryMarks(buyerDeliveryMarks, false);
        await dataStore.ordersDao.loadOrders(orders, false);
        await dataStore.ordersDao.loadOrderLines(orderLines, false);
        await dataStore.ordersDao.loadOrderLineCodes(orderLineCodes, false);
        await dataStore.ordersDao.loadOrderLinePackErrors(orderLinePackErrors, false);
        await dataStore.tasksDao.loadTasks(tasks, false);
        await dataStore.paymentsDao.loadDebts(debts, false);
      });
    } on ApiException catch(e) {
      throw AppError(e.errorMsg);
    } catch(e, trace) {
      await Misc.reportError(e, trace);
      throw AppError(Strings.genericErrorMsg);
    }
  }

  Future<void> arrive(Buyer buyer, Position position) async {
    BuyerDeliveryMarksCompanion buyerDeliveryMark = BuyerDeliveryMarksCompanion(
      type: Value(BuyerDeliveryMarkType.arrival),
      buyerId: Value(buyer.buyerId),
      deliveryId: Value(buyer.deliveryId),
      latitude: Value(position.latitude),
      longitude: Value(position.longitude),
      accuracy: Value(position.accuracy),
      altitude: Value(position.altitude),
      speed: Value(position.speed),
      heading: Value(position.heading),
      pointTs: Value(position.timestamp)
    );

    await dataStore.buyersDao.upsertBuyerDeliveryMark(buyerDeliveryMark);
  }

  Future<void> depart(Buyer buyer, Position position) async {
    BuyerDeliveryMarksCompanion buyerDeliveryMark = BuyerDeliveryMarksCompanion(
      type: Value(BuyerDeliveryMarkType.departure),
      buyerId: Value(buyer.buyerId),
      deliveryId: Value(buyer.deliveryId),
      latitude: Value(position.latitude),
      longitude: Value(position.longitude),
      accuracy: Value(position.accuracy),
      altitude: Value(position.altitude),
      speed: Value(position.speed),
      heading: Value(position.heading),
      pointTs: Value(position.timestamp)
    );

    await dataStore.buyersDao.upsertBuyerDeliveryMark(buyerDeliveryMark);
  }

  Future<void> clearFiles([Set<String> newKeys = const <String>{}]) async {
    final cacheObjects = await _buyerDeliveryPointPhotosCacheRepo.getAllObjects();
    final oldCacheObjects = cacheObjects.where((e) => !newKeys.contains(e.key));

    for (var oldCacheObject in oldCacheObjects) {
      try {
        await buyerDeliveryPointPhotosCacheManager.removeFile(oldCacheObject.key);
      } on PathNotFoundException {
        continue;
      }
    }
  }
}
