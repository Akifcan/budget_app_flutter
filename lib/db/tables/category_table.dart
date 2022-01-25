import 'package:budget/db/db_provider.dart';
import 'package:budget/db/models/category.dart';

class CategoryTable {
  CategoryTable._privateConstructor();
  static final CategoryTable _instance = CategoryTable._privateConstructor();
  static CategoryTable get instance => _instance;

  Future<List<Category>> getCategories(int active) async {
    List<Category> categories = [];
    final db = await DatabaseProvider.instance.database();
    final List<Map<String, dynamic>> maps =
        await db.rawQuery('select * from categories where active=?', [0]);
    categories = maps.map((category) => Category.fromJson(category)).toList();
    return categories;
  }
}
