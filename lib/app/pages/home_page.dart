import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:forwarder/app/constants/strings.dart';
import 'package:forwarder/app/pages/buyers_page.dart';
import 'package:forwarder/app/pages/history_page.dart';
import 'package:forwarder/app/pages/info_page.dart';
import 'package:forwarder/app/pages/payments_page.dart';
import 'package:forwarder/app/view_models/buyers_view_model.dart';
import 'package:forwarder/app/view_models/history_view_model.dart';
import 'package:forwarder/app/view_models/home_view_model.dart';
import 'package:forwarder/app/view_models/info_view_model.dart';
import 'package:forwarder/app/view_models/payments_view_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, vm, _) {
        return Scaffold(
          bottomNavigationBar: _buildBottomNavigationBar(context, vm),
          body: MultiProvider(
            providers: [
              ChangeNotifierProvider<InfoViewModel>(create: (context) => InfoViewModel(context: context)),
              ChangeNotifierProvider<BuyersViewModel>(create: (context) => BuyersViewModel(context: context)),
              ChangeNotifierProvider<PaymentsViewModel>(create: (context) => PaymentsViewModel(context: context)),
              ChangeNotifierProvider<HistoryViewModel>(create: (context) => HistoryViewModel(context: context))
            ],
            child: [
              InfoPage(),
              BuyersPage(),
              PaymentsPage(),
              HistoryPage()
            ][vm.currentIndex]
          )
        );
      }
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context, HomeViewModel vm) {
    return BottomNavigationBar(
      currentIndex: vm.currentIndex,
      onTap: vm.setCurrentIndex,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: Strings.infoPageName
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.local_grocery_store),
          label: Strings.buyersPageName
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.payment),
          label: Strings.paymentsPageName
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.history),
          label: Strings.historyPageName
        )
      ],
    );
  }
}
