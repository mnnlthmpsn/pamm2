/// _id : "628e763469f266546ce3d499"
/// category : {"_id":"628e6a5b3b167e2adfb4f39f","title":"Books"}
/// title : "Honor your Prophet"
/// images : ["https://images.unsplash.com/photo-1653463174226-76848e041450?crop=entropy&cs=tinysrgb&fm=jpg&ixlib=rb-1.2.1&q=60&raw_url=true&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyfHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=500"]

class Product {
  Product({
      String? id, 
      Category? category, 
      String? title, 
      List<String>? images,}){
    _id = id;
    _category = category;
    _title = title;
    _images = images;
}

  Product.fromJson(dynamic json) {
    _id = json['_id'];
    _category = json['category'] != null ? Category.fromJson(json['category']) : null;
    _title = json['title'];
    _images = json['images'] != null ? json['images'].cast<String>() : [];
  }
  String? _id;
  Category? _category;
  String? _title;
  List<String>? _images;
Product copyWith({  String? id,
  Category? category,
  String? title,
  List<String>? images,
}) => Product(  id: id ?? _id,
  category: category ?? _category,
  title: title ?? _title,
  images: images ?? _images,
);
  String? get id => _id;
  Category? get category => _category;
  String? get title => _title;
  List<String>? get images => _images;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    if (_category != null) {
      map['category'] = _category?.toJson();
    }
    map['title'] = _title;
    map['images'] = _images;
    return map;
  }

}

/// _id : "628e6a5b3b167e2adfb4f39f"
/// title : "Books"

class Category {
  Category({
      String? id, 
      String? title,}){
    _id = id;
    _title = title;
}

  Category.fromJson(dynamic json) {
    _id = json['_id'];
    _title = json['title'];
  }
  String? _id;
  String? _title;
Category copyWith({  String? id,
  String? title,
}) => Category(  id: id ?? _id,
  title: title ?? _title,
);
  String? get id => _id;
  String? get title => _title;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['title'] = _title;
    return map;
  }

}