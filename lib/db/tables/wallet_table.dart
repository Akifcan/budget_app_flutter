import 'package:budget/core/constants.dart';
import 'package:budget/db/db_provider.dart';
import 'package:budget/db/models/graphics/wallet_sum.dart';
import 'package:budget/db/models/wallet.dart';
import 'package:budget/db/tables/amout_table.dart';
import 'package:flutter/material.dart';

class WalletTable {
  WalletTable._privateConstructor();
  static final WalletTable _instance = WalletTable._privateConstructor();
  static WalletTable get instance => _instance;

  String walletTableName = 'wallet';

  Future<List<Wallet>> walletByCategory(int categoryId) async {
    List<Wallet> wallets = [];
    final db = await DatabaseProvider.instance.database();
    final List<Map<String, dynamic>> maps = await db.rawQuery(
        'SELECT * FROM $walletTableName where categoryId=?', [categoryId]);
    wallets = maps.map((wallet) => Wallet.fromJson(wallet)).toList();
    return wallets;
  }

  Future<num> showTotalExpenseByCategory(int categoryId) async {
    final db = await DatabaseProvider.instance.database();
    final date = DateTime.now();
    final List<Map<String, dynamic>> maps = await db.rawQuery(
        "SELECT SUM(amount) from $walletTableName where month=? and year=? and categoryId=? and type = 'expense' ",
        [date.month, date.year, categoryId]);
    return maps[0]['SUM(amount)'] ?? 0;
  }

  Future<bool> addWallet(WalletDto wallet) async {
    final db = await DatabaseProvider.instance.database();
    final date = DateTime.now();
    await db.rawQuery(
        'INSERT INTO $walletTableName (categoryId, description, type, month, day, year, amount) VALUES(?, ?, ?, ?, ?, ?, ?)',
        [
          wallet.categoryId,
          wallet.description,
          wallet.type,
          date.month,
          date.day,
          date.year,
          wallet.amount
        ]);
    await AmountTable.instance.updateAmount(wallet.type, wallet.amount);
    return true;
  }

  Future<bool> updateWallet(
      num walletId, String description, num amount) async {
    final db = await DatabaseProvider.instance.database();
    await db.rawQuery(
        'UPDATE $walletTableName SET description=?, amount=? where id=?',
        [description, amount, walletId]);
    return true;
  }

  Future<bool> deleteWallet(num walletId) async {
    final db = await DatabaseProvider.instance.database();
    await db.rawQuery('DELETE FROM $walletTableName WHERE id = $walletId');
    return true;
  }

  Future<List<WalletSum>> sumOfExpensesAndEarns() async {
    final db = await DatabaseProvider.instance.database();
    final date = DateTime.now();
    final List<Map<String, dynamic>> expenses = await db.rawQuery(
        "SELECT SUM(amount) from $walletTableName where month=? and year=? and type = 'expense';",
        [date.month - 1, date.year]);
    final List<Map<String, dynamic>> incomes = await db.rawQuery(
        "SELECT SUM(amount) from $walletTableName where month=? and year=? and type = 'income';",
        [date.month - 1, date.year]);
    return [
      WalletSum('expense', Colors.red, expenses[0]['SUM(amount)']),
      WalletSum('income', Colors.green, incomes[0]['SUM(amount)'])
    ];
  }

  Future<List<WalletGroup>> groupExpenses() async {
    final db = await DatabaseProvider.instance.database();
    final date = DateTime.now();
    final List<Map<String, dynamic>> expenses = await db.rawQuery('''
          SELECT categories.name, SUM($walletTableName.amount) as total FROM $walletTableName 
          INNER JOIN categories
          ON categories.id = $walletTableName.categoryId 
          WHERE $walletTableName.month=? AND $walletTableName.year=? AND type='expense'
          GROUP BY categories.name
          ORDER BY total desc
        ''', [date.month, date.year]);
    return expenses.map((e) => WalletGroup(e['name'], e['total'])).toList();
  }

  Future<List<Wallet>> orderWallet(
      num limit, String type, OrderBy order) async {
    List<Wallet> wallets = [];
    final db = await DatabaseProvider.instance.database();
    final date = DateTime.now();
    final List<Map<String, dynamic>> maps = await db.rawQuery(
        "SELECT * from $walletTableName where month=? and year=? and type = '$type' ORDER BY amount ${order.orderToString} LIMIT $limit;",
        [date.month, date.year]);
    wallets = maps.map((wallet) => Wallet.fromJson(wallet)).toList();
    return wallets;
  }
}
