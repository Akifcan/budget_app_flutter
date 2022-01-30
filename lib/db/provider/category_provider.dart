import 'package:budget/core/navigator_service.dart';
import 'package:budget/db/models/category.dart';
import 'package:budget/db/tables/category_table.dart';
import 'package:budget/helpers/helpers.dart';
import 'package:budget/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CategoryProvider extends ChangeNotifier {
  List<Category> categories = [];
  bool isLoading = true;

  listAllCategories() async {
    categories = await CategoryTable.instance.getAllCategories();
    isLoading = false;
    notifyListeners();
  }

  activeCategory(Category category, bool setActive, {bool pop = false}) {
    if (setActive) {
      activeCategoryDialog(category, (double amount) {
        CategoryTable.instance
            .activeCategory(category.id, amount)
            .then((updated) {
          if (pop) {
            NavigationService.pop();
          }
          Fluttertoast.showToast(
              msg: "Bu kategori aktif edildi",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: primaryColor,
              textColor: Colors.white,
              fontSize: 16.0);
        });
      });
    } else {
      CategoryTable.instance.deActiveCategory(category.id).then((deactivated) {
        Fluttertoast.showToast(
            msg:
                "Bu kategori kaldırıldı. İsterseniz tekrardan aktif edebilirsiniz",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: primaryColor,
            textColor: Colors.white,
            fontSize: 16.0);
      });
    }
    category.active = !category.active;
    notifyListeners();
  }
}
