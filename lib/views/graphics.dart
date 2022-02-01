import 'package:budget/core/constants.dart';
import 'package:budget/db/tables/wallet_table.dart';
import 'package:budget/widgets/graphics/group_categories.dart';
import 'package:budget/widgets/graphics/order_wallet.dart';
import 'package:budget/widgets/graphics/pie_this_month.dart';
import 'package:flutter/material.dart';

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
            GroupCategories(),
            SizedBox(height: 20),
            OrderWallet(
                title: 'En Yüksek Harcamalarınız',
                type: 'expense',
                order: OrderBy.desc),
            SizedBox(height: 20),
            OrderWallet(
                title: 'En Az Harcamalarınız',
                type: 'expense',
                order: OrderBy.asc),
            SizedBox(height: 20),
            OrderWallet(
                title: 'Kazançlarınız', type: 'income', order: OrderBy.desc),
          ],
        ),
      ),
    );
  }
}
