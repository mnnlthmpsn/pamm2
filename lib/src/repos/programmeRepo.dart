import 'dart:convert';
import 'package:http/http.dart' as http;

class ProgrammeRepo {
  Future<dynamic> getProgrammes() async {
    try {
      Uri url = Uri.parse('http://198.199.87.131:7018/prog');
      dynamic res = await http.get(url);
      dynamic resBody = jsonDecode(res.body);

      return resBody['programmes'];
    } catch (e) {
      rethrow;
    }
  }
}
