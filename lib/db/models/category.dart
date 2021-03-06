class Category {
  late int id;
  late String name;
  late String icon;
  late bool active;
  late num amount;

  Category(
      {required this.id,
      required this.name,
      required this.amount,
      required this.icon,
      required this.active});

  Category.fromJson(Map json) {
    id = json['id'];
    name = json['name'];
    icon = json['icon'];
    active = json['active'] == 0 ? false : true;
    amount = json['amount'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'icon': icon,
      'active': active,
      'amount': amount
    };
  }
}
