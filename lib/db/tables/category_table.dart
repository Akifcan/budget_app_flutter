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

  addNewCategory(String categoryName) async {
    final db = await DatabaseProvider.instance.database();
    final List<Map<String, dynamic>> maps = await db.rawQuery(
        'insert into categories (name, icon, active) values (?, ?, ?)',
        [categoryName, 'default.png', 1]);
    print(maps);
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
