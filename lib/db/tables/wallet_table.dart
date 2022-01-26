import 'package:budget/db/db_provider.dart';
import 'package:budget/db/models/wallet.dart';

class WalletTable {
  WalletTable._privateConstructor();
  static final WalletTable _instance = WalletTable._privateConstructor();
  static WalletTable get instance => _instance;

  String amountTableName = 'wallet';

  walletByCategory(int categoryId) async {
    final db = await DatabaseProvider.instance.database();
    final List<Map<String, dynamic>> maps = await db.rawQuery(
        'SELECT * FROM $amountTableName where categoryId=?', [categoryId]);
    print(maps);
  }

  Future<bool> addWallet(Wallet wallet) async {
    final db = await DatabaseProvider.instance.database();
    final date = DateTime.now();
    final List<Map<String, dynamic>> maps = await db.rawQuery(
        'INSERT INTO wallet (categoryId, description, type, month, day, year, amount) VALUES(?, ?, ?, ?, ?, ?)',
        [
          wallet.categoryId,
          wallet.description,
          wallet.type,
          date.month,
          date.day,
          date.year,
          wallet.amount
        ]);
    print(maps);
    return true;
  }
}
