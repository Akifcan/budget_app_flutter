import 'package:budget/core/constants.dart';
import 'package:budget/core/navigator_service.dart';
import 'package:budget/db/models/wallet.dart';
import 'package:budget/db/tables/wallet_table.dart';
import 'package:budget/style.dart';
import 'package:budget/views/all_records.dart';
import 'package:budget/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OrderWallet extends StatelessWidget {
  final String title;
  final String type;
  final OrderBy order;
  const OrderWallet(
      {Key? key, required this.title, required this.type, required this.order})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Future<List<Wallet>> query =
        WalletTable.instance.orderWallet(3, type, order);

    return FutureBuilder<List<Wallet>>(
      future: query,
      builder: (BuildContext context, AsyncSnapshot<List<Wallet>> snapshot) {
        return snapshot.hasData
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                      child: Text(title,
                          style: Theme.of(context).textTheme.headline6)),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: snapshot.data!.isNotEmpty
                        ? ListView.builder(
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
                            })
                        : Center(child: Text("empty!")),
                  ),
                  TextButton.icon(
                      onPressed: () => NavigationService.push(
                          AllRecords(title: title, orderWallet: query)),
                      icon:
                          const Icon(FontAwesomeIcons.eye, color: primaryColor),
                      label: const Text("Tüm Kayıtlar",
                          style: TextStyle(color: primaryColor)))
                ],
              )
            : const Loader();
      },
    );
  }
}
