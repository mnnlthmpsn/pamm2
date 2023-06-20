class CategoryModel {
  final int id;
  final String title;
  final String description;

  const CategoryModel(
      {required this.id, required this.title, required this.description});
}

class CategoryModelFactory {
  static fromJson(dynamic json) {
    return CategoryModel(
      id: json["id"],
      title: json["title"],
      description: json["description"],
    );
  }
}
