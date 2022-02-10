class CreditCardImages {
  late num id;
  late String path;
  late String name;

  CreditCardImages({required this.id, required this.path, required this.name});

  CreditCardImages.fromJson(Map json) {
    id = json['id'];
    path = json['path'];
    name = json['name'];
  }

  toMap() {
    return {"id": id, "path": path, "name": name};
  }
}
