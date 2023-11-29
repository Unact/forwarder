import 'dart:async';

import 'package:u_app_utils/u_app_utils.dart';

import '/app/entities/entities.dart';

extension RenewApiX on RenewApi {
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

  Future<void> deliverOrder(int orderId, List<Map<String, dynamic>> codes, bool delivered, Location location) async {
    await post(
      'v1/forwarder/confirm_delivery',
      dataGenerator: () => {
        'sale_order_id': orderId,
        'codes': codes,
        'delivered': delivered,
        'location': {
          'latitude': location.latitude,
          'longitude': location.longitude,
          'accuracy': location.accuracy,
          'altitude': location.altitude,
          'speed': location.speed,
          'heading': location.heading,
          'point_ts': location.pointTs?.toIso8601String()
        },
        'local_ts': DateTime.now().toIso8601String()
      }
    );
  }

  Future<void> cancelOrderDelivery(int orderId) async {
    await post(
      'v1/forwarder/cancel_delivery',
      dataGenerator: () => {
        'sale_order_id': orderId
      }
    );
  }

  Future<void> acceptPayment(
    List<Map<String, dynamic>> payments,
    Map<String, dynamic>? transaction,
    Location location
  ) async {
    await post(
      'v1/forwarder/save',
      dataGenerator: () => {
        'payments': payments,
        'payment_transaction': transaction,
        'location': {
          'latitude': location.latitude,
          'longitude': location.longitude,
          'accuracy': location.accuracy,
          'altitude': location.altitude,
          'speed': location.speed,
          'heading': location.heading,
          'point_ts': location.pointTs?.toIso8601String()
        },
        'local_ts': DateTime.now().toIso8601String()
      }
    );
  }

  Future<void> cancelCardPayment(int paymentId, Map<String, dynamic> transaction) async {
    await post(
      'v1/forwarder/cancel',
      dataGenerator: () => {
        'id': paymentId,
        'payment_transaction': transaction,
        'local_ts': DateTime.now().toIso8601String()
      }
    );
  }

  Future<ApiPaymentCredentials> getPaymentCredentials() async {
    final result = await get('v1/forwarder/credentials');

    return ApiPaymentCredentials.fromJson(result);
  }
}
