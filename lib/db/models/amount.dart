class Amount {
  late int id;
  late int month;
  late int day;
  late int year;
  late num amount;
  late num current;

  Amount(
      {required this.id,
      required this.month,
      required this.current,
      required this.day,
      required this.year,
      required this.amount});

  Amount.fromJson(Map json) {
    id = json['id'];
    month = json['month'];
    current = json['current'];
    day = json['day'];
    year = json['year'];
    amount = json['amount'];
  }

  toMap() {
    return {
      "id": id,
      "month": month,
      "current": current,
      "day": day,
      "year": year,
      "amount": amount
    };
  }
}
