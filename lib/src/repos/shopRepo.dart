import 'dart:convert';

import 'package:pamm2/src/models/product.dart';
import 'package:http/http.dart' as http;
import 'package:pamm2/src/models/product_detail.dart';

class ShopRepo {
  Future<List<Product>> getProducts() async {
    try {
      Uri url = Uri.parse('http://198.199.87.131:7018/products');
      dynamic res = await http.get(url);
      dynamic resBody = jsonDecode(res.body);

      return (resBody['products'] as List)
          .map((prod) => Product.fromJson(prod))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<ProductDetail> getProduct(String productId) async {
    try {
      Uri url = Uri.parse('http://198.199.87.131:7018/products/$productId');
      dynamic res = await http.get(url);
      dynamic resBody = jsonDecode(res.body);

      return ProductDetail.fromJson(resBody['product']);
    } catch (e) {
      rethrow;
    }
  }
}
