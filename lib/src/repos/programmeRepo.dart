import 'dart:convert';
import 'package:http/http.dart' as http;

class ProgrammeRepo {
  Future<dynamic> getProgrammes() async {
    try {
      Uri url = Uri.parse('https://pama-api.herokuapp.com/api/days?fields=title&populate[programmes][fields][0]=title,time');
      dynamic res = await http.get(url);
      dynamic resBody = jsonDecode(res.body);
      print(resBody['data']);

      return resBody['data'];
    } catch (e) {
      rethrow;
    }
  }
}
