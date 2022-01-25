import 'package:budget/db/db_provider.dart';
import 'package:budget/db/models/category.dart';

class CategoryTable {
  CategoryTable._privateConstructor();
  static final CategoryTable _instance = CategoryTable._privateConstructor();
  static CategoryTable get instance => _instance;

  String categoryTableName = 'categories';

  Future<bool> isCategoryExists(String categoryName) async {
    final db = await DatabaseProvider.instance.database();
    final List<Map<String, dynamic>> maps = await db.rawQuery(
        'select * from $categoryTableName where name=?', [categoryName]);
    return maps.isNotEmpty ? true : false;
  }

  Future<bool> addNewCategory(String categoryName, double amount) async {
    final db = await DatabaseProvider.instance.database();
    await db.rawQuery(
        'insert into $categoryTableName (name, active, amount) values (?, ?, ?)',
        [categoryName, 1, amount]);
    return true;
  }

  Future<bool> activeCategory(int categoryId, double amount) async {
    final db = await DatabaseProvider.instance.database();
    await db
        .rawQuery('UPDATE $categoryTableName SET active=1, amount=?', [amount]);
    return true;
  }

  Future<List<Category>> getCategories(int active) async {
    List<Category> categories = [];
    final db = await DatabaseProvider.instance.database();
    final List<Map<String, dynamic>> maps = await db
        .rawQuery('select * from $categoryTableName where active=?', [0]);
    categories = maps.map((category) => Category.fromJson(category)).toList();
    return categories;
  }
}
