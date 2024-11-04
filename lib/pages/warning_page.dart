import 'package:flutter/material.dart';

class WarningPage extends StatelessWidget {
  const WarningPage({Key? key}) : super(key: key);

  // 주의사항을 보여주는 다이얼로그 함수
  void _showWarningDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Assembly Warnings',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // CPU 주의사항 버튼
            _buildWarningButton(
              context,
              "CPU Warning",
              "CPU 장착 시 핀이 손상되지 않도록 주의하세요. 장착 후 열을 방출하기 위해 써멀 페이스트를 바르는 것도 중요합니다.",
              Colors.blueAccent,
            ),
            SizedBox(height: 20),
            // 그래픽카드 주의사항 버튼
            _buildWarningButton(
              context,
              "Graphics Card Warning",
              "그래픽카드를 장착할 때 슬롯에 정확하게 연결하고, 고정 나사를 잊지 않도록 주의하세요. 전력 소비가 크므로 적절한 전원 공급이 필요합니다.",
              Colors.greenAccent,
            ),
            SizedBox(height: 20),
            // 메인보드 주의사항 버튼
            _buildWarningButton(
              context,
              "Mainboard Warning",
              "메인보드를 설치할 때 케이스와 제대로 고정하고, 각 부품과의 호환성을 확인하세요. 특히 메모리 슬롯을 정확하게 장착하세요.",
              Colors.orangeAccent,
            ),
          ],
        ),
      ),
    );
  }

  // 동일한 크기의 주의사항 버튼 위젯
  Widget _buildWarningButton(
      BuildContext context, String title, String message, Color color) {
    return SizedBox(
      width: 300, // 버튼의 고정 너비
      height: 60, // 버튼의 고정 높이
      child: ElevatedButton(
        onPressed: () {
          _showWarningDialog(context, title, message);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 5,
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
