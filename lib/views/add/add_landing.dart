import 'package:budget/core/navigator_service.dart';
import 'package:budget/views/add/new_category.dart';
import 'package:budget/views/category_list.dart';
import 'package:budget/views/graphics.dart';
import 'package:budget/widgets/new_record_card.dart';
import 'package:flutter/material.dart';

class AddLanding extends StatelessWidget {
  const AddLanding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Yeni Kayıt"),
      ),
      body: Column(
        children: [
          NewRecordCard(
              onTap: () => NavigationService.push(const NewCategory()),
              icon: 'plus',
              title: "Yeni Kategori",
              description: "Yeni Kategori Kaydı Oluşturun"),
          const SizedBox(height: 10),
          NewRecordCard(
              onTap: () => NavigationService.push(const CategoryList()),
              icon: 'menu',
              title: "Kategoriler",
              description: "Kategorilerinizi Yönetin"),
          const SizedBox(height: 10),
          NewRecordCard(
              onTap: () => NavigationService.push(const Graphics()),
              icon: 'graphic',
              title: "Grafikleriniz",
              description: "Grafikleri Takip Edin"),
        ],
      ),
    );
  }
}
