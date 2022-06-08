/// _id : "628f28b164a40437f27564bf"
/// title : "The power of giving"
/// description : "Some long description"
/// images : ["https://images.unsplash.com/photo-1638913662252-70efce1e60a7?crop=entropy&cs=tinysrgb&fm=jpg&ixlib=rb-1.2.1&q=60&raw_url=true&ixid=MnwxMjA3fDF8MHxlZGl0b3JpYWwtZmVlZHw2fHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=500","https://images.unsplash.com/photo-1653256221426-67e0b6660056?crop=entropy&cs=tinysrgb&fm=jpg&ixlib=rb-1.2.1&q=60&raw_url=true&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw4fHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=500","https://images.unsplash.com/photo-1653407900555-9c02e5f6b52d?crop=entropy&cs=tinysrgb&fm=jpg&ixlib=rb-1.2.1&q=60&raw_url=true&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyNHx8fGVufDB8fHx8&auto=format&fit=crop&w=500"]
/// amount : 45.5
/// in_stock : true
/// care_guide_info : "Some care guid info here"

class ProductDetail {
  ProductDetail({
      String? id, 
      String? title, 
      String? description, 
      List<String>? images, 
      double? amount, 
      bool? inStock, 
      String? careGuideInfo,}){
    _id = id;
    _title = title;
    _description = description;
    _images = images;
    _amount = amount;
    _inStock = inStock;
    _careGuideInfo = careGuideInfo;
}

  ProductDetail.fromJson(dynamic json) {
    _id = json['_id'];
    _title = json['title'];
    _description = json['description'];
    _images = json['images'] != null ? json['images'].cast<String>() : [];
    _amount = json['amount'];
    _inStock = json['in_stock'];
    _careGuideInfo = json['care_guide_info'];
  }
  String? _id;
  String? _title;
  String? _description;
  List<String>? _images;
  double? _amount;
  bool? _inStock;
  String? _careGuideInfo;
ProductDetail copyWith({  String? id,
  String? title,
  String? description,
  List<String>? images,
  double? amount,
  bool? inStock,
  String? careGuideInfo,
}) => ProductDetail(  id: id ?? _id,
  title: title ?? _title,
  description: description ?? _description,
  images: images ?? _images,
  amount: amount ?? _amount,
  inStock: inStock ?? _inStock,
  careGuideInfo: careGuideInfo ?? _careGuideInfo,
);
  String? get id => _id;
  String? get title => _title;
  String? get description => _description;
  List<String>? get images => _images;
  double? get amount => _amount;
  bool? get inStock => _inStock;
  String? get careGuideInfo => _careGuideInfo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['title'] = _title;
    map['description'] = _description;
    map['images'] = _images;
    map['amount'] = _amount;
    map['in_stock'] = _inStock;
    map['care_guide_info'] = _careGuideInfo;
    return map;
  }

}