import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiCaller {
  String baseApiUrl = "http://192.168.0.104:3000";
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

  getEvents() async {
    var res = await http.get(Uri.parse(baseApiUrl + "/events"));
    return json.decode(res.body)['data'];
  }

  getUser(id) async {
    var res = await http.get(Uri.parse(baseApiUrl + "/user" + "/$id"));
    return json.decode(res.body)['data'];
  }

  addAttendee(eventId, id) async {
    var res = await http.patch(Uri.parse(
        baseApiUrl + '/events' + '/$eventId' + '/addAttendee' + '/$id'));
    return json.decode(res.body);
  }

  createEvent(Map eventData) async {
    var res = await http.post(Uri.parse(baseApiUrl + "/event"),
        body: json.encode(eventData), headers: headers);
    return res.body;
  }
}
