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

  Future<List<dynamic>> sendCredentials(String username, String userpassword) async {
    final uri = Uri.parse(url); // 서버의 엔드포인트 URL
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      'username': username,
      'userpassword': userpassword,
    });

    try {
      // POST 요청 보내기
      final response = await http.post(uri, headers: headers, body: body);

      if (response.statusCode == 200) {
        // 응답이 성공적인 경우 JSON 데이터를 파싱
        var userJson = response.body;
        var parsedData = jsonDecode(userJson) as List<dynamic>; // 리스트로 변환
        return parsedData;
      } else if(response.statusCode == 201){//회원가입 성공
        return[1];
      } else if(response.statusCode == 404){
        print('아이디 혹은 비밀번호가 틀렸습니다');
        return [0];//로그인때 틀림
      }else if(response.statusCode == 409){
        return[-1];//회원가입때 아이디 중복임
      }else{
        print('Failed to load data. Status code: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error occurred: $e');
      return [];
    }
  }

  Future<List<dynamic>> productDetail(String productname) async {
    final uri = Uri.parse(url); // 서버의 엔드포인트 URL
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      'productname': productname,

    });

    try {
      // POST 요청 보내기
      final response = await http.post(uri, headers: headers, body: body);

      if (response.statusCode == 200) {
        // 응답이 성공적인 경우 JSON 데이터를 파싱
        var userJson = response.body;
        var parsedData = jsonDecode(userJson) as List<dynamic>; // 리스트로 변환
        return parsedData;
      } else {
        print('Failed to load data. Status code: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error occurred: $e');
      return [];
    }
  }

}


