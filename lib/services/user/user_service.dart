import 'dart:convert';
import '../../helpers/constants.dart';
import 'package:http/http.dart' as http;

import '../../helpers/token_manager.dart';
class UserServices{
  Future<dynamic> getUserProfile() async {
    final uri = Uri.parse('${Constants.baseAPI}/users/me');

    final response = await http.get(
      uri,
      headers: <String, String>{
        'accept': 'application/json',
        "Authorization": 'Bearer ${TokenManager.instance.accessToken}'
      },
    );

    if (response.statusCode == 200) {
      dynamic mp = jsonDecode(response.body);
      return mp;
    }
    return {"Error": "Not found"};
  }
}