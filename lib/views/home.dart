import 'package:budget/db/db_provider.dart';
import 'package:budget/db/models/dog.dart';
import 'package:budget/style.dart';
import 'package:budget/widgets/category_card.dart';
import 'package:budget/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<void> insertDog(Dog dog) async {
    final db = await DatabaseProvider.instance.database();

    await db.insert(
      'dogs',
      dog.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> getAll() async {
    final db = await DatabaseProvider.instance.database();
    // final List<Map<String, dynamic>> maps =
    //     await db.query('dogs', where: "id = ?", whereArgs: [5]);
    final List<Map<String, dynamic>> maps = await db.query('categories');
    print(maps);
  }

  @override
  void initState() {
    super.initState();
    getAll();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          tooltip: 'Yeni Ekleme Yapın',
          backgroundColor: primaryColor,
          onPressed: () {},
          child: const Icon(FontAwesomeIcons.wallet),
        ),
        body: Column(
          children: [
            const Header(),
            Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: ListView.separated(
                    itemCount: 15,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (_, __) => const CategoryCard(),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
