import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pamm2/src/models/product_detail.dart';

class ShopRepo {
  Future makePayment(payload) async {
    try {
      Uri url = Uri.parse(
          'https://pama-api.herokuapp.com/api/makePayment');
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(payload),
      );

      if (response.statusCode == 200) {
        print(response);
        return response.body;
      }
      else {
        throw Exception("Error making payment");
      }
    } catch (e) {
      rethrow;
    }
  }
}
