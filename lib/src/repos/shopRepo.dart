import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pamm2/src/models/product_detail.dart';

class ShopRepo {
  Future<List> getProducts() async {
    try {
      Uri url = Uri.parse(
          'https://pama-api.herokuapp.com/api/products?fields=title,price&populate[category][fields][0]=title&populate[images][fields][0]=url');
      dynamic res = await http.get(url);
      dynamic resBody = jsonDecode(res.body);

      return resBody['data'];
    } catch (e) {
      rethrow;
    }
  }

  Future getProduct(String productId) async {
    try {
      Uri url =
          Uri.parse('https://pama-api.herokuapp.com/api/products/$productId?fields=title,price,in_stock,description&populate[images][fields][0]=url&populate[category][fields][0]=title');
      dynamic res = await http.get(url);
      dynamic resBody = jsonDecode(res.body);
      print(resBody['data']);
      return resBody['data'];
    } catch (e) {
      rethrow;
    }
  }
}
