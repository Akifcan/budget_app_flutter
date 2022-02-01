enum OrderBy { desc, asc }

extension OrderByExtension on OrderBy {
  String get orderToString {
    switch (this) {
      case OrderBy.desc:
        return 'desc';
      case OrderBy.asc:
        return 'asc';
      default:
        return 'asc';
    }
  }
}
