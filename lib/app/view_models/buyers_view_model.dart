import 'dart:math';

import 'package:flutter/material.dart';

import 'package:forwarder/app/entities/entities.dart';
import 'package:forwarder/app/view_models/base_view_model.dart';

class BuyersViewModel extends BaseViewModel {
  BuyersViewModel({required BuildContext context}) : super(context: context);

  List<Buyer> get buyers => appState.buyers..sort((buyer1, buyer2) {
    int ord1 = _ordersForBuyer(buyer1).map<int>((e) => e.ord).fold(0, max);
    int ord2 = _ordersForBuyer(buyer2).map<int>((e) => e.ord).fold(0, max);
    int ordCompare = ord1.compareTo(ord2);

    return ordCompare == 0 ? buyer1.name.toLowerCase().compareTo(buyer2.name.toLowerCase()) : ordCompare;
  });

  List<Order> _ordersForBuyer(Buyer buyer) => appState.orders.where((e) => e.buyerId == buyer.id).toList();
  List<Buyer> get buyersWithoutDelivery =>
    buyers.where((e) => _ordersForBuyer(e).any((e) => !e.didDelivery)).toList();
  List<Buyer> get buyersWithDelivery =>
    buyers.where((e) => _ordersForBuyer(e).every((e) => e.didDelivery)).toList();

  int ordersCntForBuyer(Buyer buyer) => _ordersForBuyer(buyer).length;
  bool buyerIsInc(Buyer buyer) => appState.orders.any((e) => e.buyerId == buyer.id && e.isInc) ||
    ordersCntForBuyer(buyer) == 0;
}
