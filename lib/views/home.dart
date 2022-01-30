import 'package:budget/core/navigator_service.dart';
import 'package:budget/db/db_provider.dart';
import 'package:budget/db/models/category.dart';
import 'package:budget/db/provider/header_provider.dart';
import 'package:budget/db/tables/category_table.dart';
import 'package:budget/style.dart';
import 'package:budget/views/add/add_landing.dart';
import 'package:budget/widgets/category_card.dart';
import 'package:budget/widgets/header.dart';
import 'package:budget/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// ignore: implementation_imports
import 'package:provider/src/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  list() async {
    final db = await DatabaseProvider.instance.database();
    final List<Map<String, dynamic>> categoryMaps =
        await db.rawQuery('select * from categories');
    final List<Map<String, dynamic>> amountMaps =
        await db.rawQuery('select * from amountsPerMonth');
    print(categoryMaps);
  }

  @override
  void initState() {
    super.initState();
    list();
    context.read<HeaderProvider>().getHeaderInformations();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          tooltip: 'Yeni Ekleme Yapın',
          backgroundColor: primaryColor,
          onPressed: () => NavigationService.push(const AddLanding()),
          child: const Icon(FontAwesomeIcons.wallet),
        ),
        body: Column(
          children: [
            const Header(),
            Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: FutureBuilder<List<Category>>(
                    future: CategoryTable.instance.getCategories(1),
                    builder: (_, AsyncSnapshot snapshot) {
                      return snapshot.hasData
                          ? ListView.separated(
                              itemCount: snapshot.data.length,
                              separatorBuilder: (_, __) =>
                                  const SizedBox(height: 10),
                              itemBuilder: (_, index) =>
                                  CategoryCard(category: snapshot.data[index]),
                            )
                          : const Loader();
                    },
                  )),
            )
          ],
        ),
      ),
    );
  }
}
