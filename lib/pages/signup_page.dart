import 'package:flutter/material.dart';
import '../globals.dart'; // globals.dart 파일 import

class SignupPage extends StatelessWidget {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  void _register(BuildContext context) {
    // 입력한 사용자 정보를 전역 변수에 저장
    registeredUsername = _usernameController.text;
    registeredPassword = _passwordController.text;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('회원가입 완료'),
        content: Text('회원가입이 성공적으로 완료되었습니다.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context); // 회원가입 후 로그인 페이지로 이동
            },
            child: Text('확인'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('회원가입')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: '아이디'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: '비밀번호'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _register(context),
              child: Text('회원가입'),
            ),
          ],
        ),
      ),
    );
  }
}
