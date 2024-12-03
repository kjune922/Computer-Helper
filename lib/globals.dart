// lib/globals.dart
String? registeredUsername;
String? registeredPassword;
String? registeredUserLevel;
String? productName;

// 추가된 글로벌 변수
List<Map<String, dynamic>> expertCartComponents = []; // 숙련자용 장바구니 데이터
bool expertCartInitialized = false; // 장바구니 데이터 초기화 여부
