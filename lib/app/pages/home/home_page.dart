import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/app/constants/strings.dart';
import '/app/pages/buyers/buyers_page.dart';
import '/app/pages/history/history_page.dart';
import '/app/pages/info/info_page.dart';
import '/app/pages/payments/payments_page.dart';
import '/app/pages/shared/page_view_model.dart';

part 'home_state.dart';
part 'home_view_model.dart';

class HomePage extends StatelessWidget {
  HomePage({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeViewModel>(
      create: (context) => HomeViewModel(),
      child: _HomeView(),
    );
  }
}

class _HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<_HomeView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeViewModel, HomeState>(
      builder: (context, state) {
        return Scaffold(
          bottomNavigationBar: buildBottomNavigationBar(context),
          body: ScaffoldMessenger(
            child: IndexedStack(
              index: state.currentIndex,
              children: <Widget>[
                InfoPage(),
                BuyersPage(),
                PaymentsPage(),
                HistoryPage()
              ]
            )
          )
        );
      }
    );
  }

  Widget buildBottomNavigationBar(BuildContext context) {
    final vm = context.read<HomeViewModel>();

    return BottomNavigationBar(
      currentIndex: vm.state.currentIndex,
      onTap: vm.setCurrentIndex,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: Strings.infoPageName),
        BottomNavigationBarItem(icon: Icon(Icons.local_grocery_store), label: Strings.buyersPageName),
        BottomNavigationBarItem(icon: Icon(Icons.payment), label: Strings.paymentsPageName),
        BottomNavigationBarItem(icon: Icon(Icons.history), label: Strings.historyPageName)
      ],
    );
  }
}
