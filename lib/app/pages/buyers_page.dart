import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:forwarder/app/constants/strings.dart';
import 'package:forwarder/app/entities/entities.dart';
import 'package:forwarder/app/pages/buyer_page.dart';
import 'package:forwarder/app/view_models/buyer_view_model.dart';
import 'package:forwarder/app/view_models/buyers_view_model.dart';

class BuyersPage extends StatelessWidget {
  const BuyersPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.buyersPageName)
      ),
      body: Consumer<BuyersViewModel>(
        builder: (context, vm, _) {
          return ListView(
            physics: AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.only(top: 24, left: 8, right: 8, bottom: 24),
            children: vm.buyers.map((e) => _buyerTile(context, e)).toList()
          );
        }
      )
    );
  }

  Widget _buyerTile(BuildContext context, Buyer buyer) {
    BuyersViewModel vm = Provider.of<BuyersViewModel>(context);
    bool isInc = vm.buyerIsInc(buyer);

    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.all(0),
      title: Text(buyer.name, style: TextStyle(fontSize: 14.0)),
      onTap: () async {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => ChangeNotifierProvider<BuyerViewModel>(
              create: (context) => BuyerViewModel(context: context, buyer: buyer, isInc: isInc),
              child: BuyerPage(),
            )
          )
        );
      },
      subtitle: RichText(
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(
              text: buyer.address + '\n',
              style: TextStyle(color: Colors.grey, fontSize: 12.0)
            ),
            TextSpan(
              text: 'Заказов: ${vm.ordersCntForBuyer(buyer)}\n',
              style: TextStyle(color: Colors.blue, fontSize: 12.0)
              ),
            TextSpan(
              text: isInc ? 'Требуется инкассация' : '',
              style: TextStyle(color: Colors.blue, fontSize: 12.0)
            )
          ]
        )
      )
    );
  }
}
