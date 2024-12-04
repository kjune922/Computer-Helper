import 'package:com_recipe/Network.dart';
import 'package:com_recipe/globals.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _usernameController = TextEditingController();

  final _passwordController = TextEditingController();

  List<dynamic> data = [];

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
              onPressed: () async {
                if (_usernameController.text != '' &&
                    _passwordController.text != '') {
                  Network network = Network(
                      'http://116.124.191.174:15011/signup'); //116.124.191.174:15011

                  data = await network.sendCredentials(_usernameController.text,
                      _passwordController.text, isBeginner);
                  if (data[0] == -1) {
                    // 아이디 중복
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('회원가입 실패'),
                        content: Text('중복된 아이디입니다'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('확인'),
                          ),
                        ],
                      ),
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('회원가입 성공'),
                        content: Text('정상적으로 회원가입 되었습니다'),
                        actions: [
                          TextButton(
                            onPressed: () =>
                                Navigator.pushNamed(context, '/login'),
                            child: Text('확인'),
                          ),
                        ],
                      ),
                    );
                  }
                } else {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('회원가입 실패'),
                      content: Text('아이디와 비밀번호를 써주세요'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('확인'),
                        ),
                      ],
                    ),
                  );
                }
              },
              child: Text('회원가입'),
            ),
          ],
        ),
      ),
    );
  }
}
