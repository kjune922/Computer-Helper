import 'package:flutter/material.dart';
import '../globals.dart';
import 'package:com_recipe/Network.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  List<dynamic> data = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF8E2DE2), Color(0xFF4A00E0)], // 그라디언트 배경색
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 프로필 아이콘
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.person,
                    size: 40,
                    color: Color(0xFF4A00E0),
                  ),
                ),
                SizedBox(height: 20),
                // 로그인 카드
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // ID 입력 필드
                      TextField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          labelText: "ID", // 수정된 필드명
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      // 비밀번호 입력 필드
                      TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          labelText: "Password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      // "Forgot Password?" 링크
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, '/reset_password'); // 비밀번호 재설정 페이지로 이동
                          },
                          child: Text(
                            "",
                            style: TextStyle(color: Color(0xFF4A00E0)),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      // 로그인 버튼
                      Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            backgroundColor: Color(0xFF4A00E0), // 버튼 색상
                          ),
                          onPressed: () async {
                            Network network = Network(
                                'http://116.124.191.174:15011/login'); //116.124.191.174:15011

                            data = await network.sendCredentials(
                                _usernameController.text,
                                _passwordController.text,
                                true //1은더미데이터
                                );
                            if (data[0] != 0) {
                              registeredUsername = await data[0]['id'];
                              registeredUserLevel = await data[0]['level'];
                              if (await data[0]['isBeginner'] == 1) {
                                isBeginner = true;
                              } else {
                                isBeginner = false;
                              }
                              Navigator.pushReplacementNamed(context, '/');
                            } else {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text('로그인 실패'),
                                  content: Text('아이디 또는 비밀번호가 틀렸습니다.'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(
                                          context), // pop: 가장 상단에 있는 화면을 제거하여 이전 화면으로 돌아가는 방식
                                      child: Text('확인'),
                                    ),
                                  ],
                                ),
                              );
                            }
                          },
                          child: Text(
                            "로그인",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                // 회원가입 버튼
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                  child: Text(
                    "Create an Account",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
