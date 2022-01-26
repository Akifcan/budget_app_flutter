import 'package:budget/db/models/category.dart';
import 'package:budget/widgets/budget_card.dart';
import 'package:flutter/material.dart';

class CategoryDetail extends StatefulWidget {
  final Category category;
  const CategoryDetail({Key? key, required this.category}) : super(key: key);

  @override
  State<CategoryDetail> createState() => _CategoryDetailState();
}

class _CategoryDetailState extends State<CategoryDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                const BudgetCard(
                  title: 'Harcadığınız Tutar',
                  amount: 0,
                  backgroundColor: Colors.white,
                  textColor: Colors.black87,
                ),
                const SizedBox(width: 15),
                BudgetCard(
                  title: 'Belirlediğiniz Tutar',
                  amount: widget.category.amount,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                )
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
