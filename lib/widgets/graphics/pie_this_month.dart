import 'package:budget/db/models/graphics/WalletSum.dart';
import 'package:budget/db/tables/wallet_table.dart';
import 'package:budget/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class InfoColor extends StatelessWidget {
  final Color color;
  const InfoColor({Key? key, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 20,
      height: 20,
      child: DecoratedBox(decoration: BoxDecoration(color: color)),
    );
  }
}

class PieThisMonth extends StatelessWidget {
  const PieThisMonth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<WalletSum>>(
      future: WalletTable.instance.sumOfExpensesAndEarns(),
      builder: (_, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return const Loader();
        }
        return Column(
          children: [
            Text(
              "Bu Ayki Harcamalarınız/Geliriniz",
              style: Theme.of(context).textTheme.headline6,
            ),
            SfCircularChart(series: <CircularSeries>[
              PieSeries<WalletSum, String>(
                  dataSource: snapshot.data,
                  pointColorMapper: (WalletSum data, _) => data.color,
                  xValueMapper: (WalletSum data, _) => data.label,
                  yValueMapper: (WalletSum data, _) => data.value,
                  // Radius of pie
                  radius: '90%')
            ]),
            Wrap(
              spacing: 15,
              children: const [
                InfoColor(color: Colors.red),
                Text("Harcamalarınız"),
                InfoColor(color: Colors.green),
                Text("Kazançalarınız")
              ],
            )
          ],
        );
      },
    );
  }
}
