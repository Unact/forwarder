import 'dart:async';

import 'package:u_app_utils/u_app_utils.dart';

import '/app/entities/entities.dart';

extension ForwarderApi on RenewApi {
  Future<ApiUserData> getUserData() async {
    final result = await get('v1/forwarder/user_info');

    return ApiUserData.fromJson(result);
  }

  Future<ApiData> getData() async {
    final result = await get('v1/forwarder');

    return ApiData.fromJson(result);
  }

  Future<void> closeDay(bool closed) async {
    await post(
      'v1/forwarder/close_day',
      dataGenerator: () => {
        'closed': closed
      }
    );
  }

  Future<ApiBuyerOrderData> missed(int buyerId, int deliveryId, Map<String, dynamic> location) async {
    final result = await post(
      'v1/forwarder/buyers/missed',
      dataGenerator: () => {
        'buyer_id': buyerId,
        'delivery_id': deliveryId,
        'location': location,
        'local_ts': DateTime.now().toIso8601String()
      }
    );

    return ApiBuyerOrderData.fromJson(result);
  }

  Future<ApiBuyerDeliveryMarksData> arrive(int buyerId, int deliveryId, Map<String, dynamic> location) async {
    final result = await post(
      'v1/forwarder/buyers/arrive',
      dataGenerator: () => {
        'buyer_id': buyerId,
        'delivery_id': deliveryId,
        'location': location,
        'local_ts': DateTime.now().toIso8601String()
      }
    );

    return ApiBuyerDeliveryMarksData.fromJson(result);
  }

  Future<ApiBuyerDeliveryMarksData> depart(int buyerId, int deliveryId, Map<String, dynamic> location) async {
    final result = await post(
      'v1/forwarder/buyers/depart',
      dataGenerator: () => {
        'buyer_id': buyerId,
        'delivery_id': deliveryId,
        'location': location,
        'local_ts': DateTime.now().toIso8601String()
      }
    );

    return ApiBuyerDeliveryMarksData.fromJson(result);
  }

  Future<ApiBuyerDeliveryPointData> saveBuyerDeliveryPoint(
    Map<String, dynamic> buyerDeliveryPointData,
    List<Map<String, dynamic>> buyerDeliveryPointPhotosData
  ) async {
    final result = await post(
      'v1/forwarder/buyers/save_delivery_point',
      dataGenerator: () => {
        'buyer_delivery_point': buyerDeliveryPointData,
        'buyer_delivery_point_photos': buyerDeliveryPointPhotosData
      }
    );

    return ApiBuyerDeliveryPointData.fromJson(result);
  }

  Future<ApiOrderDeliveryData> deliverOrder(
    int orderId,
    List<Map<String, dynamic>> codes,
    List<Map<String, dynamic>> packErrors,
    bool delivered,
    Map<String, dynamic> location
  ) async {
    final result = await post(
      'v1/forwarder/orders/confirm_delivery',
      dataGenerator: () => {
        'sale_order_id': orderId,
        'codes': codes,
        'pack_errors': packErrors,
        'delivered': delivered,
        'location': location,
        'local_ts': DateTime.now().toIso8601String()
      }
    );

    return ApiOrderDeliveryData.fromJson(result);
  }

  Future<ApiOrderDeliveryData> cancelOrderDelivery(int orderId) async {
    final result = await post(
      'v1/forwarder/orders/cancel_delivery',
      dataGenerator: () => {
        'sale_order_id': orderId
      }
    );

    return ApiOrderDeliveryData.fromJson(result);
  }

  Future<ApiAcceptPaymentData> acceptPayment(
    List<Map<String, dynamic>> payments,
    Map<String, dynamic> location
  ) async {
    final result = await post(
      'v1/forwarder/orders/save',
      dataGenerator: () => {
        'payments': payments,
        'location': location,
        'local_ts': DateTime.now().toIso8601String()
      }
    );

    return ApiAcceptPaymentData.fromJson(result);
  }
}
