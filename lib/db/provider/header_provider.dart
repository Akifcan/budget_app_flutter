import 'package:budget/db/db_provider.dart';
import 'package:budget/db/models/amount.dart';
import 'package:budget/db/models/header_informations.dart';
import 'package:flutter/cupertino.dart';

class HeaderProvider extends ChangeNotifier {
  late HeaderInformations headerInformations;
  late bool isLoading = true;
  late bool isDanger = false;

  Future getHeaderInformations() async {
    isLoading = true;
    final db = await DatabaseProvider.instance.database();
    final date = DateTime.now();
    final List<Map<String, dynamic>> amountMaps = await db.rawQuery(
        'select * from amountsPerMonth where month=? and year=?',
        [date.month, date.year]);
    Amount amount = Amount.fromJson(amountMaps[0]);
    headerInformations =
        HeaderInformations(amount: amount.amount, current: amount.current);
    if (headerInformations.amount < 0) {
      isDanger = true;
    }
    isLoading = false;
    notifyListeners();
  }
}
