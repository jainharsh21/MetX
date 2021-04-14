import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiCaller {
  String baseApiUrl = "http://192.168.0.107:3000";
  Map<String, String> headers = {"Content-type": "application/json"};

  login(Map userData) async {
    var res = await http.post(Uri.parse(baseApiUrl + "/login"),
        body: json.encode(userData), headers: headers);
    return res.body;
  }

  register(Map userData) async {
    var res = await http.post(Uri.parse(baseApiUrl + "/user"),
        body: json.encode(userData), headers: headers);
    return res.body;
  }
}
