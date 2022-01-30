import 'package:budget/db/models/category.dart';
import 'package:budget/db/provider/category_provider.dart';
import 'package:budget/db/tables/category_table.dart';
import 'package:budget/widgets/icon_container.dart';
import 'package:budget/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({Key? key}) : super(key: key);

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  @override
  void initState() {
    super.initState();
    context.read<CategoryProvider>().listAllCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Kategorileriniz"),
        ),
        body: Consumer<CategoryProvider>(builder: (_, model, __) {
          return !model.isLoading
              ? ListView.builder(
                  itemCount: model.categories.length,
                  itemBuilder: (_, index) {
                    Category category = model.categories[index];
                    bool active = category.active;
                    return ListTile(
                      leading: IconContainer(
                          iconName: category.icon.replaceAll('.png', '')),
                      title: Text(category.name),
                      trailing: Switch(
                        onChanged: (val) {
                          model.activeCategory(category, val, pop: true);
                        },
                        value: active,
                      ),
                    );
                  },
                )
              : const Loader();
        }));
  }
}
