import 'package:http/http.dart' as http;

class ApiCaller {
  String baseApiUrl = "http://192.168.0.107:3000";
  login() async {
    var res = await http.get(Uri.parse(baseApiUrl + "/users"));
    print(res.body);
  }
}
