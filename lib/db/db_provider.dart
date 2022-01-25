import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  DatabaseProvider._privateConstructor();
  static final DatabaseProvider _instance =
      DatabaseProvider._privateConstructor();
  static DatabaseProvider get instance => _instance;

  database() async {
    return openDatabase(
      join(await getDatabasesPath(), 'budget9.db'),
      onCreate: (db, version) async {
        await db.execute(
            "CREATE TABLE categories(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, icon TEXT default 'default.png', active INTEGER, amount INTEGER default 0);");
        await db.execute(
            "insert into categories (name, icon, active) VALUES('sport', 'sport.png', 0);");
        await db.execute(
            "insert into categories (name, icon, active) VALUES('car', 'car.png', 0);");
        await db.execute(
            "insert into categories (name, icon, active) VALUES('fun', 'confetti.png', 0);");
        await db.execute(
            "insert into categories (name, icon, active) VALUES('food', 'diet.png', 0);");
        await db.execute(
            "insert into categories (name, icon, active) VALUES('house', 'house.png', 0);");
        // ignore: avoid_print
        print("ok!");
      },
      version: 1,
    );
  }
}
