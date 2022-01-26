import 'package:budget/core/navigator_service.dart';
import 'package:budget/db/models/category.dart';
import 'package:budget/db/models/wallet.dart';
import 'package:budget/db/tables/wallet_table.dart';
import 'package:budget/form/validations.dart';
import 'package:budget/style.dart';
import 'package:budget/widgets/alert.dart';
import 'package:budget/widgets/budget_card.dart';
import 'package:budget/widgets/loader.dart';
import 'package:flutter/material.dart';

class CategoryDetail extends StatefulWidget {
  final Category category;
  const CategoryDetail({Key? key, required this.category}) : super(key: key);

  @override
  State<CategoryDetail> createState() => _CategoryDetailState();
}

class _CategoryDetailState extends State<CategoryDetail> {
  final newExpenseFormKey = GlobalKey<FormState>();
  bool isLoading = false;

  String expenseType = 'expense';
  late String description;
  late num amount;

  createExpense() async {
    if (newExpenseFormKey.currentState!.validate()) {
      newExpenseFormKey.currentState!.save();
      setState(() {
        isLoading = true;
      });
      await WalletTable.instance.addWallet(WalletDto(
          categoryId: widget.category.id,
          amount: amount,
          type: expenseType,
          description: description));
      setState(() {
        isLoading = false;
      });
      NavigationService.pop();
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
                                value: "income",
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
                                value: "expense",
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
    print(WalletTable.instance.showTotalExpenseByCategory(widget.category.id));
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
      body: !isLoading
          ? Column(
              children: [
                FutureBuilder<num>(
                  future: WalletTable.instance
                      .showTotalExpenseByCategory(widget.category.id),
                  builder: (_, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return snapshot.data > widget.category.amount
                          ? Alert(
                              background: Colors.red[800]!,
                              label:
                                  'Belirlediğiniz harcama limitini geçtiniz (${snapshot.data - widget.category.amount}₺ fark.)')
                          : const SizedBox.shrink();
                    }
                    return const Loader();
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      FutureBuilder<num>(
                        future: WalletTable.instance
                            .showTotalExpenseByCategory(widget.category.id),
                        builder: (_, AsyncSnapshot snapshot) {
                          return snapshot.hasData
                              ? BudgetCard(
                                  title: 'Harcadığınız Tutar',
                                  amount: snapshot.data,
                                  backgroundColor: Colors.white,
                                  textColor:
                                      snapshot.data < widget.category.amount
                                          ? Colors.black87
                                          : Colors.red,
                                )
                              : const Loader();
                        },
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
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: FutureBuilder<List<Wallet>>(
                    future: WalletTable.instance
                        .walletByCategory(widget.category.id),
                    builder: (_, AsyncSnapshot snapshot) {
                      return snapshot.hasData
                          ? ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (_, index) {
                                Wallet wallet = snapshot.data[index];
                                return ListTile(
                                  title: Text(wallet.description),
                                  subtitle: Text(wallet.type == 'expense'
                                      ? 'Harcama Yaptınız'
                                      : 'Kazandınız'),
                                  trailing: Text("${wallet.amount}₺",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w900,
                                          fontSize: 20)),
                                );
                              },
                            )
                          : const Loader();
                    },
                  ),
                )
              ],
            )
          : const Loader(),
    );
  }
}
