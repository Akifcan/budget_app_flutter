import 'package:budget/core/navigator_service.dart';
import 'package:budget/db/models/category.dart';
import 'package:budget/style.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void showWarningDialog(String title, String description) {
  showDialog(
      context: NavigationService.navigatorKey.currentContext!,
      builder: (_) => AlertDialog(
            title: Text(title),
            content: Text(description),
            actions: [
              ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(primary: primaryColor),
                  onPressed: () => NavigationService.pop(),
                  icon: const Icon(FontAwesomeIcons.arrowLeft),
                  label: const Text("Geri Dön"))
            ],
          ));
}

void activeCategoryDialog(
    Category category, Function(double category) updateCategory) {
  TextEditingController amountController = TextEditingController();

  showModalBottomSheet(
      context: NavigationService.navigatorKey.currentContext!,
      builder: (_) => SizedBox(
            height:
                MediaQuery.of(NavigationService.navigatorKey.currentContext!)
                        .size
                        .height *
                    .7,
            width: MediaQuery.of(NavigationService.navigatorKey.currentContext!)
                .size
                .width,
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
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            text: category.name + '\t'),
                        const TextSpan(text: 'Kategorisini ekliyorsunuz'),
                      ])),
                  const SizedBox(height: 10),
                  TextField(
                    controller: amountController,
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
                  SizedBox(
                    width: MediaQuery.of(
                            NavigationService.navigatorKey.currentContext!)
                        .size
                        .width,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: primaryColor),
                        onPressed: () {
                          if (amountController.text.isEmpty) {
                            showWarningDialog(
                                'Hata', "Lütfen bir miktar belirtin");
                            return;
                          }
                          if (double.parse(amountController.text) <= 0) {
                            showWarningDialog('Hata',
                                "Lütfen girdiğiniz miktar 0'dan büyük olsun.");
                            return;
                          }
                          updateCategory(double.parse(amountController.text));
                        },
                        child: const Text("Kayıt Et")),
                  )
                ],
              ),
            ),
          ));
}
