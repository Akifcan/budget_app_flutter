class WalletDto {
  final num categoryId;
  final String description;
  final String type;
  final num amount;

  WalletDto(
      {required this.categoryId,
      required this.description,
      required this.amount,
      required this.type});
}

class Wallet {
  late num id;
  late num categoryId;
  late String description;
  late String type;
  late num month;
  late num day;
  late num year;
  late num amount;

  Wallet(
      {required this.id,
      required this.categoryId,
      required this.description,
      required this.type,
      required this.month,
      required this.amount,
      required this.day,
      required this.year});

  Wallet.fromJson(Map json) {
    id = json['id'];
    categoryId = json['categoryId'];
    description = json['description'];
    type = json['type'];
    amount = json['amount'];
    month = json['month'];
    day = json['day'];
    year = json['year'];
  }

  toMap() {
    return {
      'id': id,
      'categoryId': categoryId,
      'description': description,
      'type': type,
      'amount': amount,
      'month': month,
      'day': day,
      'year': year
    };
  }
}

// id INTEGER PRIMARY KEY AUTOINCREMENT, categoryId INTEGER NOT NULL, description TEXT NOT NULL, type TEXT NOT NULL, month INTEGER NOT NULL, day INTEGER NOT NULL, year INTEGER NOT NULL, FOREIGN KEY(categoryId) REFERENCES categories(id)