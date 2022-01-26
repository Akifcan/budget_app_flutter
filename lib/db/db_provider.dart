import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  DatabaseProvider._privateConstructor();
  static final DatabaseProvider _instance =
      DatabaseProvider._privateConstructor();
  static DatabaseProvider get instance => _instance;

  database() async {
    return openDatabase(
      join(await getDatabasesPath(), 'budget17.db'),
      onCreate: (db, version) async {
        await db.execute(
            "CREATE TABLE categories(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, icon TEXT default 'default.png', active INTEGER, amount INTEGER default 0);");
        await db.execute(
            'CREATE TABLE amountsPerMonth (id INTEGER PRIMARY KEY AUTOINCREMENT, month INTEGER NOT NULL, day INTEGER NOT NULL, year INTEGER NOT NULL, amount INTEGER NOT NULL);');
        await db.execute(
            'CREATE TABLE wallet (id INTEGER PRIMARY KEY AUTOINCREMENT, categoryId INTEGER NOT NULL, description TEXT NOT NULL, amount INTEGER NOT NULL, type TEXT NOT NULL, month INTEGER NOT NULL, day INTEGER NOT NULL, year INTEGER NOT NULL, FOREIGN KEY(categoryId) REFERENCES categories(id));');
        await db.execute(
            "INSERT INTO categories (name, icon, active, amount) VALUES('sport', 'sport.png', 1, 500);");
        await db.execute(
            "INSERT INTO categories (name, icon, active) VALUES('car', 'car.png', 0);");
        await db.execute(
            "INSERT INTO categories (name, icon, active) VALUES('fun', 'confetti.png', 0);");
        await db.execute(
            "INSERT INTO categories (name, icon, active) VALUES('food', 'diet.png', 0);");
        await db.execute(
            "INSERT INTO categories (name, icon, active) VALUES('house', 'house.png', 0);");
        // ignore: avoid_print
        print("ok!");
      },
      version: 1,
    );
  }
}
