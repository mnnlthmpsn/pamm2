import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pamm2/src/models/programme.dart';

class ProgrammeRepo {
  Future<List<DayModel>> getProgrammes() async {
    try {
      Uri url = Uri.parse("https://cogairadio.com/cama-api/programmes");
      dynamic res = await http.get(url);
      var temp = jsonDecode(res.body);
      return (temp as List).map((e) => DayModelFactory.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }
}
