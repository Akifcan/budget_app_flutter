class Amount {
  late int id;
  late int month;
  late int day;
  late int year;
  late num amount;

  Amount(
      {required this.id,
      required this.month,
      required this.day,
      required this.year,
      required this.amount});

  Amount.fromJson(Map json) {
    id = json['id'];
    month = json['month'];
    day = json['day'];
    year = json['year'];
    amount = json['amount'];
  }

  toMap() {
    return {
      "id": id,
      "month": month,
      "day": day,
      "year": year,
      "amount": amount
    };
  }
}
