import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/app/constants/strings.dart';
import '/app/data/database.dart';
import '/app/pages/buyers/buyer/buyer_page.dart';
import '/app/pages/shared/page_view_model.dart';
import '/app/repositories/app_repository.dart';
import '/app/repositories/orders_repository.dart';
import '/app/repositories/payments_repository.dart';

part 'buyers_state.dart';
part 'buyers_view_model.dart';

class BuyersPage extends StatelessWidget {
  BuyersPage({
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BuyersViewModel>(
      create: (context) => BuyersViewModel(
        RepositoryProvider.of<AppRepository>(context),
        RepositoryProvider.of<OrdersRepository>(context),
        RepositoryProvider.of<PaymentsRepository>(context),
      ),
      child: _BuyersView(),
    );
  }
}

class _BuyersView extends StatefulWidget {
  @override
  _BuyersViewState createState() => _BuyersViewState();
}

class _BuyersViewState extends State<_BuyersView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.buyersPageName)
      ),
      body: BlocBuilder<BuyersViewModel, BuyersState>(
        builder: (context, state) {
          BuyersViewModel vm = context.read<BuyersViewModel>();

          return ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.only(top: 24, left: 8, right: 8, bottom: 24),
            children: [
              ExpansionTile(
                initiallyExpanded: false,
                tilePadding: const EdgeInsets.all(0),
                childrenPadding: const EdgeInsets.only(left: 8),
                title: const Text('Выполнено'),
                children: vm.finishedBuyers.map((e) => _buyerTile(context, e)).toList()
              ),
              ExpansionTile(
                initiallyExpanded: true,
                tilePadding: const EdgeInsets.all(0),
                childrenPadding: const EdgeInsets.only(left: 8),
                title: const Text('Активно'),
                children: vm.notFinishedBuyers.map((e) => _buyerTile(context, e)).toList()
              ),
            ]
          );
        }
      )
    );
  }

  Widget _buyerTile(BuildContext context, Buyer buyer) {
    BuyersViewModel vm = context.read<BuyersViewModel>();
    bool isInc = vm.buyerIsInc(buyer);

    return ListTile(
      dense: true,
      contentPadding: const EdgeInsets.all(0),
      title: Text(buyer.name, style: const TextStyle(fontSize: 14.0)),
      onTap: () async {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (BuildContext context) => BuyerPage(buyer: buyer, isInc: isInc))
        );
      },
      subtitle: RichText(
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(
              text: '${buyer.address}\n',
              style: const TextStyle(color: Colors.grey, fontSize: 12.0)
            ),
            TextSpan(
              text: 'Заказов: ${vm.buyerOrders(buyer).length}\n',
              style: const TextStyle(color: Colors.blue, fontSize: 12.0)
              ),
            TextSpan(
              text: isInc ? 'Требуется инкассация' : '',
              style: const TextStyle(color: Colors.blue, fontSize: 12.0)
            )
          ]
        )
      )
    );
  }
}
