import 'package:budget/db/models/category.dart';
import 'package:budget/db/tables/category_table.dart';
import 'package:budget/style.dart';
import 'package:budget/widgets/icon_container.dart';
import 'package:flutter/material.dart';

class NewCategory extends StatelessWidget {
  const NewCategory({Key? key}) : super(key: key);

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
            TextField(
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
                    : const Center(child: CircularProgressIndicator());
              },
            ))
          ],
        ),
      ),
    );
  }
}
