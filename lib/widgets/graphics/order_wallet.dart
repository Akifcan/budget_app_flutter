import 'package:budget/db/models/wallet.dart';
import 'package:budget/db/tables/wallet_table.dart';
import 'package:budget/widgets/loader.dart';
import 'package:flutter/material.dart';

class OrderWallet extends StatelessWidget {
  final String title;
  final String type;
  final String order;
  const OrderWallet(
      {Key? key, required this.title, required this.type, required this.order})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Wallet>>(
      future: WalletTable.instance.orderWallet(3, type, order),
      builder: (BuildContext context, AsyncSnapshot<List<Wallet>> snapshot) {
        return snapshot.hasData
            ? Column(
                children: [
                  Text(title, style: Theme.of(context).textTheme.headline6),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (_, index) {
                          Wallet wallet = snapshot.data![index];
                          return ListTile(
                            title: Text(wallet.description),
                            trailing: Text(wallet.amount.toString() + '₺',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500)),
                          );
                        }),
                  ),
                ],
              )
            : const Loader();
      },
    );
  }
}
