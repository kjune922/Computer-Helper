import 'package:http/http.dart' as http;
import 'dart:convert';

class Network {
  final String url;
  Network(this.url);

  Future<dynamic> getJsonData() async {
    // var url = Uri.parse('http://localhost:3000/');
    http.Response response = await http.get(Uri.parse(url));
    var userJson = response.body;
    var parsingData = jsonDecode(userJson);
    return parsingData;
  }
}
