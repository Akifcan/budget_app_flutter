class CollectionCard {
  late num id;
  late String name;

  CollectionCard({required this.id, required this.name});

  CollectionCard.fromJson(Map json) {
    id = json['id'];
    name = json['name'];
  }

  toMap() {
    return {"id": id, "name": name};
  }
}
