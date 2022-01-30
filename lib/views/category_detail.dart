import 'package:budget/core/navigator_service.dart';
import 'package:budget/db/models/category.dart';
import 'package:budget/db/models/wallet.dart';
import 'package:budget/db/tables/amout_table.dart';
import 'package:budget/db/tables/wallet_table.dart';
import 'package:budget/form/validations.dart';
import 'package:budget/style.dart';
import 'package:budget/widgets/alert.dart';
import 'package:budget/widgets/budget_card.dart';
import 'package:budget/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CategoryDetail extends StatefulWidget {
  final Category category;
  const CategoryDetail({Key? key, required this.category}) : super(key: key);

  @override
  State<CategoryDetail> createState() => _CategoryDetailState();
}

class _CategoryDetailState extends State<CategoryDetail> {
  final newExpenseFormKey = GlobalKey<FormState>();
  final editExpenseFormKey = GlobalKey<FormState>();
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

  editExpense(
      num walletId, String newDescription, num newAmount, num oldAmount) async {
    await AmountTable.instance
        .editExpense(walletId, newDescription, newAmount, oldAmount);
    Navigator.of(context).pop();
    setState(() {});
  }

  deleteExpense(num walletId, num amount) async {
    await AmountTable.instance.deleteExpense(walletId, amount);
    Navigator.of(context).pop();
    setState(() {});
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

  editDialog(Wallet wallet) {
    num walletId = wallet.id;
    num amount = wallet.amount;
    TextEditingController descriptionController =
        TextEditingController(text: wallet.description);
    TextEditingController amountController =
        TextEditingController(text: wallet.amount.toString());

    showDialog(
        context: context,
        builder: (_) => Form(
              key: editExpenseFormKey,
              child: AlertDialog(
                title: const Text("Harcama Bilgisini Düzenleyin"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: descriptionController,
                      decoration:
                          const InputDecoration(labelText: 'Açıklamanız'),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      validator: (val) => amountValidation(val!),
                      controller: amountController,
                      decoration:
                          const InputDecoration(labelText: 'Yeni Miktar'),
                    ),
                  ],
                ),
                actions: [
                  ElevatedButton.icon(
                      style:
                          ElevatedButton.styleFrom(primary: Colors.yellow[900]),
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.arrow_left),
                      label: const Text("Geri Dön")),
                  ElevatedButton.icon(
                      onPressed: () {
                        Fluttertoast.showToast(
                            msg: "Silmek İçin Lütfen Uzun Basın",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      },
                      style: ElevatedButton.styleFrom(primary: Colors.red[900]),
                      onLongPress: () {
                        deleteExpense(walletId, amount);
                      },
                      icon: const Icon(Icons.delete_forever),
                      label: const Text("Sil")),
                  ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(primary: primaryColor),
                      onPressed: () {
                        if (editExpenseFormKey.currentState!.validate()) {
                          editExpense(
                              wallet.id,
                              descriptionController.text,
                              double.parse(amountController.text),
                              wallet.amount);
                        }
                      },
                      icon: const Icon(Icons.done),
                      label: const Text("Onayla")),
                ],
              ),
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
                                  onTap: () => editDialog(wallet),
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
