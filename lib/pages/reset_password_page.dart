import 'package:com_recipe/Network.dart';
import 'package:flutter/material.dart';
import '../globals.dart'; // globals.dart 파일 import

class ResetPasswordPage extends StatelessWidget {
  final _passwordController = TextEditingController();
  final _newPasswordController = TextEditingController();

  void _resetPassword(BuildContext context) async {
    print(registeredUsername);
    List<dynamic> nowpassword = [];
    Network _checkpw = Network('http://116.124.191.174:15011/checkpw');
    nowpassword = await _checkpw.sendCredentials(
        registeredUsername!, '', true); //두번째와1은 더미데이터

    // 비번이 기존 비번이랑 일치하는지 확인
    if (_passwordController.text == nowpassword[0]['pw']) {
      Network _changepassword = Network("http://116.124.191.174:15011/resetpw");
      await _changepassword.updatedb(
          registeredUsername!, _newPasswordController.text);
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('비밀번호 재설정 완료'),
          content: Text('비밀번호가 성공적으로 재설정되었습니다.'),
          actions: [
            TextButton(
              onPressed: () {
                registeredUsername = null;
                registeredUserLevel = null;
                registeredPassword = null;
                Navigator.pushReplacementNamed(context, '/');
                Navigator.pushNamed(context, '/login');
              },
              child: Text('확인'),
            ),
          ],
        ),
      );
    } else {
      // ID가 일치하지 않으면 오류 메시지 표시
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('오류'),
          content: Text('현재 비밀번호가 올바르지 않습니다.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('확인'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('새 비밀번호 설정')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: "현재 비밀번호",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _newPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "새 비밀번호",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _resetPassword(context),
              child: Text("비밀번호 리셋하기"),
            ),
          ],
        ),
      ),
    );
  }
}
