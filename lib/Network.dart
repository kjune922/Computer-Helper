import 'package:http/http.dart' as http;
import 'dart:convert';

class Network {
  final String url;
  Network(this.url);

  Future<dynamic> getJsonData() async {
    //get요청보내고 받는다
    // var url = Uri.parse('http://localhost:3000/');
    http.Response response = await http.get(Uri.parse(url));
    var userJson = response.body;
    var parsingData = jsonDecode(userJson);
    return parsingData;
  }

  Future<dynamic> updatedb(String user, String product) async {
    //post로 2개의 string을 보내고 받지않는다
    final uri = Uri.parse(url); // 서버의 엔드포인트 URL
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      'username': user,
      'product': product,
    });

    try {
      // POST 요청 보내기
      final response = await http.post(uri, headers: headers, body: body);

      if (response.statusCode == 200) {
        print("데이터 업데이트됨");
        return [];
      }
    } catch (e) {
      print('Error occurred: $e');
      return [];
    }
  }

  Future<dynamic> createuser(String user, String password, String level) async {
    //post로 3개의 string을 보내고 받지는 않는다
    if (level.isEmpty) {
      level = '구매자';
    }
    final uri = Uri.parse(url); // 서버의 엔드포인트 URL
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      'username': user,
      'password': password,
      'userlevel': level,
    });

    try {
      // POST 요청 보내기
      final response = await http.post(uri, headers: headers, body: body);
      if (response.statusCode == 200) {
        print("유저추가됨");
        return [];
      }
    } catch (e) {
      print('유저추가실패: $e');
      return [];
    }
  }

  Future<List<dynamic>> sendCredentials(
      String username, String userpassword, bool isBeginner) async {
    //2개의 데이터를 보내고 받는다
    int isbegin;
    if (isBeginner) {
      isbegin = 1;
    } else {
      isbegin = 0;
    }
    final uri = Uri.parse(url); // 서버의 엔드포인트 URL
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      'username': username,
      'userpassword': userpassword,
      'isBeginner': isbegin,
    });

    try {
      // POST 요청 보내기
      final response = await http.post(uri, headers: headers, body: body);

      if (response.statusCode == 200) {
        // 응답이 성공적인 경우 JSON 데이터를 파싱
        var userJson = response.body;
        var parsedData = jsonDecode(userJson) as List<dynamic>; // 리스트로 변환
        return parsedData;
      } else if (response.statusCode == 201) {
        //회원가입 성공
        return [1];
      } else if (response.statusCode == 404) {
        print('아이디 혹은 비밀번호가 틀렸습니다');
        return [0]; //로그인때 틀림
      } else if (response.statusCode == 409) {
        return [-1]; //회원가입때 아이디 중복임
      } else {
        print('Failed to load data. Status code: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error occurred: $e');
      return [];
    }
  }

  Future<List<dynamic>> productDetail(String productname) async {
    //post로 한개 요청보내고 받는다
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
        var parsedData = jsonDecode(userJson); // 리스트로 변환

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

  Future<List<dynamic>> scoreserch(int lowscore, int highscore) async {//int 2개 보내고 받는다
    final uri = Uri.parse(url); // 서버의 엔드포인트 URL
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      'lowscore': lowscore,
      'highscore': highscore,
    });
    try {
      // POST 요청 보내기
      final response = await http.post(uri, headers: headers, body: body);

      if (response.statusCode == 200) {
        // 응답이 성공적인 경우 JSON 데이터를 파싱
        var userJson = response.body;
        var parsedData = jsonDecode(userJson); // 리스트로 변환

        return parsedData;
      } else {
        print('serch하다가 실패: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('serch하다가 에러 $e');
      return [];
    }
  }
}
