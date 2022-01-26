import 'package:budget/db/db_provider.dart';
import 'package:budget/db/models/wallet.dart';

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

  Future<bool> addWallet(WalletDto wallet) async {
    final db = await DatabaseProvider.instance.database();
    final date = DateTime.now();
    final List<Map<String, dynamic>> maps = await db.rawQuery(
        'INSERT INTO wallet (categoryId, description, type, month, day, year, amount) VALUES(?, ?, ?, ?, ?, ?, ?)',
        [
          wallet.categoryId,
          wallet.description,
          wallet.type,
          date.month,
          date.day,
          date.year,
          wallet.amount
        ]);
    return true;
  }
}
