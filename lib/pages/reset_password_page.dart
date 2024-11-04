import 'package:flutter/material.dart';
import '../globals.dart'; // globals.dart 파일 import

class ResetPasswordPage extends StatelessWidget {
  final _idController = TextEditingController();
  final _newPasswordController = TextEditingController();

  void _resetPassword(BuildContext context) {
    // ID가 기존 ID와 일치하는지 확인
    if (_idController.text == registeredUsername) {
      // 전역 변수에 새 비밀번호 저장
      registeredPassword = _newPasswordController.text;

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('비밀번호 재설정 완료'),
          content: Text('비밀번호가 성공적으로 재설정되었습니다.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context); // 로그인 페이지로 돌아가기
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
          content: Text('입력한 ID가 올바르지 않습니다.'),
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
      appBar: AppBar(title: Text('Reset Password')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _idController,
              decoration: InputDecoration(
                labelText: "ID",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _newPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "New Password",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _resetPassword(context),
              child: Text("Reset Password"),
            ),
          ],
        ),
      ),
    );
  }
}
