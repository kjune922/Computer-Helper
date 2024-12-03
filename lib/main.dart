import 'package:flutter/material.dart';
import 'pages/cpu_page.dart';
import 'pages/explanation.dart';
import 'pages/graphics_page.dart';
import 'pages/login_page.dart';
import 'pages/home_page.dart';
import 'pages/mainboard_page.dart';
import 'pages/master_page.dart';
import 'pages/profile_page.dart';
import 'pages/seller_page.dart';
import 'pages/signup_page.dart';
import 'pages/reset_password_page.dart';
import 'pages/warning_page.dart'; // 비밀번호 재설정 페이지 import
import 'pages/memory_page.dart'; // 메모리 페이지 추가로 import 했음
import 'pages/case_page.dart'; // 케이스 페이지 import
import 'pages/cpu_cooler_page.dart'; // 쿨러 페이지 import
import 'pages/power_page.dart'; // 파워 페이지 import
import 'pages/disk_page.dart'; // 디스크 페이지 import

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/login': (context) => LoginPage(),
        '/': (context) => HomePage(),
        '/signup': (context) => SignupPage(),
        '/reset_password': (context) => ResetPasswordPage(), // 비밀번호 재설정 경로 추가
        '/cpu': (context) => CpuPage(),
        '/graphics': (context) => GraphicsPage(),
        '/mainboard': (context) => MainboardPage(),
        '/memory': (context) => MemoryPage(), // 메모리 경로 추가
        '/case': (context) => CasePage(), // 케이스 경로 추가
        '/cpu_cooler': (context) => CpuCoolerPage(), // CPU 쿨러 경로 추가
        '/power': (context) => PowerPage(), // 파워 경로 추가
        '/disk': (context) => DiskPage(), // 디스크 경로 추가
        '/warning': (context) => WarningPage(),
        '/explanation': (context) => ExplanationPage(),
        '/profile': (context) => ProfilePage(),
        '/master': (context) => MasterPage(),
        '/seller': (context) => SellerPage(),
      },
    );
  }
}
