import 'package:budget/db/models/category.dart';
import 'package:budget/form/validations.dart';
import 'package:budget/style.dart';
import 'package:budget/widgets/budget_card.dart';
import 'package:flutter/material.dart';

class CategoryDetail extends StatefulWidget {
  final Category category;
  const CategoryDetail({Key? key, required this.category}) : super(key: key);

  @override
  State<CategoryDetail> createState() => _CategoryDetailState();
}

class _CategoryDetailState extends State<CategoryDetail> {
  final newExpenseFormKey = GlobalKey<FormState>();

  String expenseType = 'income';
  late String description;
  late num amount;

  createExpense() {
    if (newExpenseFormKey.currentState!.validate()) {
      newExpenseFormKey.currentState!.save();
      print(description);
      print(amount);
      print(expenseType);
    }
  }

  newExpense() {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: const Text("Yeni Harcama Ekleyin"),
              content: StatefulBuilder(
                builder: (_, StateSetter setState) {
                  return Form(
                    key: newExpenseFormKey,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            onSaved: (val) =>
                                setState(() => description = val!),
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Lütfen bu alanı boş bırakmayın";
                              }
                              return null;
                            },
                            decoration:
                                const InputDecoration(labelText: 'Açıklamanız'),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            onSaved: (val) =>
                                setState(() => amount = double.parse(val!)),
                            validator: (val) => amountValidation(val!),
                            decoration:
                                const InputDecoration(labelText: 'Miktar'),
                          ),
                          const SizedBox(height: 10),
                          Column(
                            children: [
                              RadioListTile(
                                groupValue: expenseType,
                                value: "expense",
                                onChanged: (val) {
                                  setState(() {
                                    expenseType = val.toString();
                                    print(expenseType);
                                  });
                                },
                                title: const Text("Kazanç"),
                              ),
                              RadioListTile(
                                groupValue: expenseType,
                                value: "income",
                                onChanged: (val) {
                                  setState(() {
                                    expenseType = val.toString();
                                    print(expenseType);
                                  });
                                },
                                title: const Text("Gider"),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  );
                },
              ),
              actions: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: primaryColor),
                    onPressed: createExpense,
                    child: const Text("Kayıt Et"))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.name),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Yeni Harcama Ekleyin',
        backgroundColor: primaryColor,
        onPressed: newExpense,
        child: const Icon(Icons.monetization_on),
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
