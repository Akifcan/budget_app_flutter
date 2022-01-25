import 'package:budget/db/models/category.dart';
import 'package:budget/db/tables/category_table.dart';
import 'package:budget/helpers/helpers.dart';
import 'package:budget/style.dart';
import 'package:budget/widgets/icon_container.dart';
import 'package:budget/widgets/loader.dart';
import 'package:flutter/material.dart';

class NewCategory extends StatefulWidget {
  NewCategory({Key? key}) : super(key: key);

  @override
  State<NewCategory> createState() => _NewCategoryState();
}

class _NewCategoryState extends State<NewCategory> {
  final newCategoryFormKey = GlobalKey<FormState>();

  late String categoryName;
  late double amount;

  void createNewCategory() async {
    if (newCategoryFormKey.currentState!.validate()) {
      newCategoryFormKey.currentState!.save();
      if (!await CategoryTable.instance.isCategoryExists(categoryName)) {
        await CategoryTable.instance.addNewCategory(categoryName);
      } else {
        showWarningDialog('Hata',
            'Bu kategori daha önceden oluşturulmuş isterseniz aktif edebilirsiniz');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    CategoryTable.instance.getCategories(0);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Yeni Kategori"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              key: newCategoryFormKey,
              child: Column(
                children: [
                  TextFormField(
                    onSaved: (val) => setState(() => categoryName = val!),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Lütfen bu alanı boş bırakmayın';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: 'Kategori Adı',
                        labelStyle: const TextStyle(color: primaryColor),
                        suffixIcon: IconButton(
                          tooltip: 'Ekleme İşlemini Tamamlayın',
                          onPressed: () {},
                          icon: const Icon(Icons.add, color: primaryColor),
                        )),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    onSaved: (val) =>
                        setState(() => amount = double.parse(val!)),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Lütfen bu alanı boş bırakmayın';
                      }
                      if (double.parse(val) < 0) {
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
                  const SizedBox(height: 10),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: primaryColor),
                        onPressed: createNewCategory,
                        child: const Text("Kayıt Et")),
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Divider(
              color: primaryColor,
              thickness: 3,
            ),
            const SizedBox(height: 10),
            Text(
              "Tavsiyeler",
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(height: 10),
            Expanded(
                child: FutureBuilder<List<Category>>(
              future: CategoryTable.instance.getCategories(0),
              builder: (_, AsyncSnapshot snapshot) {
                return snapshot.hasData
                    ? ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (_, index) {
                          Category category = snapshot.data[index];
                          return ListTile(
                            leading: IconContainer(
                                iconName: category.icon.replaceAll('.png', '')),
                            title: Text(category.name),
                          );
                        },
                      )
                    : const Loader();
              },
            ))
          ],
        ),
      ),
    );
  }
}
