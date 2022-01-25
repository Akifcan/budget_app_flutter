import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  DatabaseProvider._privateConstructor();
  static final DatabaseProvider _instance =
      DatabaseProvider._privateConstructor();
  static DatabaseProvider get instance => _instance;

  database() async {
    return openDatabase(
      join(await getDatabasesPath(), 'budget2.db'),
      onCreate: (db, version) async {
        await db.execute(
            "CREATE TABLE categories(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, icon TEXT, active INTEGER);");
        await db.execute(
            "insert into categories VALUES(1, 'sport', 'sport.png', 0);");
        await db
            .execute("insert into categories VALUES(2, 'car', 'car.png', 0);");
        await db.execute(
            "insert into categories VALUES(3, 'fun', 'confetti.png', 0);");
        await db.execute(
            "insert into categories VALUES(4, 'food', 'diet.png', 0);");
        await db.execute(
            "insert into categories VALUES(5, 'house', 'home.png', 0);");
        print("ok!");
      },
      version: 1,
    );
  }
}
