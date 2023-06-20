import 'dart:convert';

import 'package:http/http.dart' as http;

class MiscRepo {
  Future submitRequest(dynamic payload) async {
    try {
      Uri url = Uri.parse("https://cogairadio.com/cama-api/requests");
      var res = await http.post(url, body: payload);
      return res;
    } catch (e) {
      rethrow;
    }
  }
}
