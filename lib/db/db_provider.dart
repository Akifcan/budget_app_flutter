import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  DatabaseProvider._privateConstructor();
  static final DatabaseProvider _instance =
      DatabaseProvider._privateConstructor();
  static DatabaseProvider get instance => _instance;

  database() async {
    return openDatabase(
      join(await getDatabasesPath(), 'budget1.db'),
      onCreate: (db, version) async {
        await db.execute(
            "CREATE TABLE categories(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, icon TEXT);");
        await db
            .execute("insert into categories VALUES(1, 'sport', 'sport.png');");
        await db.execute("insert into categories VALUES(2, 'car', 'car.png');");
        await db.execute(
            "insert into categories VALUES(3, 'fun', 'confetti.png');");
        await db
            .execute("insert into categories VALUES(4, 'food', 'diet.png');");
        await db
            .execute("insert into categories VALUES(5, 'house', 'home.png');");
        print("ok!");
      },
      version: 1,
    );
  }
}
