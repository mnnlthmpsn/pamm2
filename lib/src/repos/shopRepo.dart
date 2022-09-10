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

  Future createOrder(payload) async {
    try {
      Uri url = Uri.parse(
          'https://pama-api.herokuapp.com/api/orders');
      Uri url_test = Uri.parse(
          'http://10.0.2.2:1337/api/orders');
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(payload),
      );

      if (response.statusCode == 200) {
        dynamic resBody = jsonDecode(response.body);
        return resBody['data'];
      }
      else {
        print(response.statusCode);
        print(response.body);
        throw Exception("Error making payment");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future makePayment(payload) async {
    try {
      Uri url = Uri.parse(
          'https://pama-api.herokuapp.com/api/payment');
      Uri url_test = Uri.parse(
          'http://10.0.2.2:1337/api/payment');
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(payload),
      );

      if (response.statusCode == 200) {
        dynamic resBody = jsonDecode(response.body);
        return resBody['data'];
      }
      else {
        throw Exception("Error making payment");
      }
    } catch (e) {
      rethrow;
    }
  }
}
