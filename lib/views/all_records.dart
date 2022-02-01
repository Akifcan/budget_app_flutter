import 'package:budget/db/models/wallet.dart';
import 'package:budget/widgets/loader.dart';
import 'package:flutter/material.dart';

class AllRecords extends StatelessWidget {
  final String title;
  final Future<List<Wallet>> orderWallet;
  const AllRecords({Key? key, required this.title, required this.orderWallet})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Wallet>>(
        future: orderWallet,
        builder: (BuildContext context, AsyncSnapshot<List<Wallet>> snapshot) {
          return snapshot.hasData
              ? Padding(
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
                              style:
                                  const TextStyle(fontWeight: FontWeight.w500)),
                        );
                      }),
                )
              : const Loader();
        },
      ),
    );
  }
}
