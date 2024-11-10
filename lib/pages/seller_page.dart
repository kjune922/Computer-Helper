import 'package:flutter/material.dart';
import '../globals.dart';

class SellerPage extends StatefulWidget {
  const SellerPage({super.key});

  @override
  State<SellerPage> createState() => _SellerPageState();
}

class _SellerPageState extends State<SellerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('판매자'),
        actions: [
          IconButton(
            onPressed: () {
              registeredUsername = null;
              registeredUserLevel = null;
              Navigator.pushNamed(context, '/');
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // 내 상품 관리 기능 구현
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('내 상품 관리'),
                  content: Text('내 상품 관리 기능을 여기에 추가할 수 있습니다.'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('닫기'),
                    ),
                  ],
                );
              },
            );
          },
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text('내 상품 관리', style: TextStyle(fontSize: 18)),
        ),
      ),
    );
  }
}
