// ignore: unused_import
import 'package:budget/db/db_provider.dart';
import 'package:budget/db/models/header_informations.dart';
import 'package:budget/db/tables/amout_table.dart';
import 'package:flutter/cupertino.dart';

class HeaderProvider extends ChangeNotifier {
  late HeaderInformations headerInformations;
  late bool isLoading = true;
  late bool isDanger = false;

  Future getHeaderInformations() async {
    isLoading = true;
    headerInformations = await AmountTable.instance.headerInformations();
    if (headerInformations.amount < 0) {
      isDanger = true;
    } else {
      isDanger = false;
    }
    isLoading = false;
    notifyListeners();
  }
}
