import 'dart:convert';

import 'package:pamm2/src/models/category.dart';

class ProductModel {
  final int id;
  final String title;
  final String description;
  final String price;
  final bool inStock;
  final CategoryModel category;
  final List<ImageModel> images;

  const ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.category,
    required this.images,
    this.inStock = true,
  });
}

class ProductModelFactory {
  static ProductModel fromJson(dynamic json) {
    return ProductModel(
      id: json["id"],
      title: json["title"],
      description: json["description"],
      price: json["price"],
      category: CategoryModelFactory.fromJson(json["category"]),
      images: ImageModelFactory.fromJsonArr(json["images"])
    );
  }
}

class ImageModel {
  final int id;
  final String title;
  final String url;

  const ImageModel({required this.id, required this.title, required this.url});
}

class ImageModelFactory {
  static ImageModel fromJson(dynamic json) {
    return ImageModel(
      id: json["id"],
      title: json["title"],
      url: json["url"],
    );
  }

  static List<ImageModel> fromJsonArr(dynamic json) {
    return (json as List).map((e) => ImageModelFactory.fromJson(e)).toList();
  }
}
