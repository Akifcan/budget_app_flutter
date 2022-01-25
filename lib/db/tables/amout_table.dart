import 'package:budget/db/db_provider.dart';

class AmountTable {
  AmountTable._privateConstructor();
  static final AmountTable _instance = AmountTable._privateConstructor();
  static AmountTable get instance => _instance;

  String amountTableName = 'amountsPerMonth';

  addNewAmount(double amount) async {
    final db = await DatabaseProvider.instance.database();
    final date = DateTime.now();
    await db.rawQuery(
        'INSERT INTO $amountTableName (month, day, year, amount) VALUES(?, ?, ?, ?)',
        [date.month, date.day, date.year, amount]);
    return true;
  }
}
