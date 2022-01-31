import 'package:budget/db/models/graphics/WalletSum.dart';
import 'package:budget/db/tables/wallet_table.dart';
import 'package:budget/widgets/graphics/group_categories.dart';
import 'package:budget/widgets/graphics/pie_this_month.dart';
import 'package:budget/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Graphics extends StatefulWidget {
  const Graphics({Key? key}) : super(key: key);

  @override
  State<Graphics> createState() => _GraphicsState();
}

class _GraphicsState extends State<Graphics> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    WalletTable.instance.groupExpenses();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Grafikleriniz"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: const [
            PieThisMonth(),
            SizedBox(height: 20),
            GroupCategories()
          ],
        ),
      ),
    );
  }
}
