import 'package:budget/db/models/graphics/WalletSum.dart';
import 'package:budget/db/tables/wallet_table.dart';
import 'package:budget/widgets/graphics/pie_this_month.dart';
import 'package:budget/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Graphics extends StatefulWidget {
  const Graphics({Key? key}) : super(key: key);

  @override
  State<Graphics> createState() => _GraphicsState();
}

class ChartData {
  ChartData(this.x, this.y, this.color);
  final String x;
  final double y;
  final Color color;
}

class _GraphicsState extends State<Graphics> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    WalletTable.instance.sumOfExpensesAndEarns();
    WalletTable.instance.orderWallet(1, 'expense');
    WalletTable.instance.orderWallet(1, 'income');

    return Scaffold(
      appBar: AppBar(
        title: const Text("Grafikleriniz"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [PieThisMonth()],
        ),
      ),
    );
  }
}
