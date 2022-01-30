import 'package:budget/core/navigator_service.dart';
import 'package:budget/db/db_provider.dart';
import 'package:budget/db/models/amount.dart';
import 'package:budget/db/models/header_informations.dart';
import 'package:budget/db/provider/header_provider.dart';
import 'package:budget/db/tables/wallet_table.dart';
// ignore: implementation_imports
import 'package:provider/src/provider.dart';

class AmountTable {
  AmountTable._privateConstructor();
  static final AmountTable _instance = AmountTable._privateConstructor();
  static AmountTable get instance => _instance;

  String amountTableName = 'amountsPerMonth';

  Future<bool> updateAmount(String type, num amount) async {
    final db = await DatabaseProvider.instance.database();
    final date = DateTime.now();
    final List<Map<String, dynamic>> currentAmountMaps = await db.rawQuery(
        'SELECT * FROM $amountTableName where month=? and year=?',
        [date.month, date.year]);
    int currentAmount = currentAmountMaps[0]['amount'];
    num newCurrentAmount =
        type == 'expense' ? currentAmount - amount : currentAmount + amount;
    await db.rawQuery(
        'UPDATE $amountTableName SET amount=? where month=? and year=?',
        [newCurrentAmount, date.month, date.year]);
    NavigationService.navigatorKey.currentContext!
        .read<HeaderProvider>()
        .getHeaderInformations();
    return true;
  }

  Future<bool> isAmountExists() async {
    final db = await DatabaseProvider.instance.database();
    final date = DateTime.now();
    final List<Map<String, dynamic>> amountIsExists = await db.rawQuery(
        'SELECT * FROM $amountTableName where month=? and year=?',
        [date.month, date.year]);
    return amountIsExists.isNotEmpty ? true : false;
  }

  Future<bool> addNewAmount(double amount) async {
    final db = await DatabaseProvider.instance.database();
    final date = DateTime.now();

    final List<Map<String, dynamic>> amountIsExists = await db.rawQuery(
        'SELECT * FROM $amountTableName where month=? and year=?',
        [date.month, date.year]);
    if (amountIsExists.isEmpty) {
      // ignore: avoid_print
      print("NEW RECORD ADDED!");
      await db.rawQuery(
          'INSERT INTO $amountTableName (month, day, year, amount, current) VALUES(?, ?, ?, ?, ?)',
          [date.month, date.day, date.year, amount, amount]);
    } else {
      // ignore: avoid_print
      print("UPDATE RECORD!");
      await db.rawQuery(
          'UPDATE $amountTableName SET current=? where month=? and year=?',
          [amount, date.month, date.year]);
    }
    return true;
  }

  Future<num> currentAmount() async {
    final db = await DatabaseProvider.instance.database();
    final date = DateTime.now();
    final List<Map<String, dynamic>> amount = await db.rawQuery(
        'SELECT * FROM $amountTableName where month=? and year=?',
        [date.month, date.year]);
    return amount[0]['current'];
  }

  Future<num> leftAmount() async {
    final db = await DatabaseProvider.instance.database();
    final date = DateTime.now();
    final List<Map<String, dynamic>> amount = await db.rawQuery(
        'SELECT * FROM $amountTableName where month=? and year=?',
        [date.month, date.year]);
    return amount[0]['amount'];
  }

  Future<HeaderInformations> headerInformations() async {
    final db = await DatabaseProvider.instance.database();
    final date = DateTime.now();
    final List<Map<String, dynamic>> amountMaps = await db.rawQuery(
        'select * from $amountTableName where month=? and year=?',
        [date.month, date.year]);
    Amount amount = Amount.fromJson(amountMaps[0]);
    return HeaderInformations(amount: amount.amount, current: amount.current);
  }

  Future<bool> editExpense(
      num walletId, String description, num newAmount, num oldAmount) async {
    num amount = await leftAmount() - oldAmount;
    final date = DateTime.now();
    final db = await DatabaseProvider.instance.database();
    await db.rawQuery(
        'UPDATE $amountTableName SET amount=? where month=? and year=?',
        [amount + newAmount, date.month, date.year]);
    await WalletTable.instance.updateWallet(walletId, description, newAmount);
    NavigationService.navigatorKey.currentContext!
        .read<HeaderProvider>()
        .getHeaderInformations();
    return true;
  }
}
