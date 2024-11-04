import 'package:flutter/material.dart';
import 'pages/cpu_page.dart';
import 'pages/explanation.dart';
import 'pages/graphics_page.dart';
import 'pages/login_page.dart';
import 'pages/home_page.dart';
import 'pages/mainboard_page.dart';
import 'pages/signup_page.dart';
import 'pages/reset_password_page.dart';
import 'pages/warning_page.dart'; // 비밀번호 재설정 페이지 import

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
      routes: {
        '/login': (context) => LoginPage(),
        '/': (context) => HomePage(),
        '/signup': (context) => SignupPage(),
        '/reset_password': (context) => ResetPasswordPage(), // 비밀번호 재설정 경로 추가
        '/cpu': (context) => CpuPage(),
        '/graphics': (context) => GraphicsPage(),
        '/mainboard': (context) => MainboardPage(),
        '/warning': (context) => WarningPage(),
        '/explanation': (context) => ExplanationPage(),
      },
    );
  }
}
