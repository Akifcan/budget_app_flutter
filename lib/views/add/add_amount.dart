import 'package:budget/core/navigator_service.dart';
import 'package:budget/db/tables/amout_table.dart';
import 'package:budget/style.dart';
import 'package:budget/views/home.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddAmount extends StatefulWidget {
  const AddAmount({Key? key}) : super(key: key);

  @override
  State<AddAmount> createState() => _AddAmountState();
}

class _AddAmountState extends State<AddAmount> {
  final amountFormKey = GlobalKey<FormState>();
  final date = DateTime.now();
  late double amount;

  updateAmount() async {
    if (amountFormKey.currentState!.validate()) {
      amountFormKey.currentState!.save();
      await AmountTable.instance.addNewAmount(amount);
      NavigationService.push(const Home());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Aylık Harcama Limitiniz"),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Tamamlayın',
        backgroundColor: primaryColor,
        child: const Icon(FontAwesomeIcons.wallet),
        onPressed: updateAmount,
      ),
      body: Form(
        key: amountFormKey,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                  text: TextSpan(
                      style: const TextStyle(color: Colors.black),
                      children: [
                    TextSpan(
                      text: "${date.month} ",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const TextSpan(text: "ayı "),
                    TextSpan(
                      text: "${date.year} yılı için:",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ])),
              const SizedBox(height: 10),
              TextFormField(
                onSaved: (val) => setState(() => amount = double.parse(val!)),
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Lütfen bu alanı boş bırakmayın';
                  }
                  if (double.parse(val) <= 0) {
                    return "Lütfen 0'ın üstünde bir değer girin";
                  }
                  return null;
                },
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    labelText: 'Miktar',
                    labelStyle: const TextStyle(color: primaryColor),
                    suffixIcon: IconButton(
                      tooltip: 'Ekleme İşlemini Tamamlayın',
                      onPressed: () {},
                      icon: const Icon(Icons.wallet_membership,
                          color: primaryColor),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
