import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pamm2/src/models/product.dart';
import 'dart:developer' as developer;

class ShopRepo {
  Future<List<ProductModel>> getProducts() async {
    try {
      Uri url = Uri.parse("https://cogairadio.com/cama-api/products");
      dynamic res = await http.get(url);
      var temp = jsonDecode(res.body);
      return (temp as List).map((e) => ProductModelFactory.fromJson(e)).toList();
    } catch (e) {
      developer.log(e.toString());
      rethrow;
    }
  }

  Future createOrder(payload) async {
    try {
      Uri url = Uri.parse("https://cogairadio.com/cama-api/orders");
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(payload),
      );

      if (response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        throw Exception("Error making payment");
      }
    } catch (e) {
      rethrow;
    }
  }
}
