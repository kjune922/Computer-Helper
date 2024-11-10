import 'package:flutter/material.dart';

class Shoppingcart extends StatefulWidget {
  Shoppingcart({super.key});

  // 예시 데이터: CPU와 그래픽카드의 성능점수와 이름
  final Map<String, dynamic> cpuProduct = {
    'name': 'Intel i7 Processor',
    'score': 700,
    'price': '299,000원'
  };
  final Map<String, dynamic> graphicsProduct = {
    'name': 'NVIDIA GTX 3080',
    'score': 1200,
    'price': '1,200,000원'
  };
  final Map<String, dynamic> mainboardProduct = {
    'name': 'ASUS ROG Strix B550-F',
    'price': '189,000원'
  };

  @override
  _ShoppingcartState createState() => _ShoppingcartState();
}

class _ShoppingcartState extends State<Shoppingcart> {
  // 성능 점수 차이에 따른 경고 팝업을 보여주는 함수
  void _showPerformanceAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            '성능 차이 알림',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Text('CPU와 그래픽카드의 성능 차이가 1.5배 이상입니다.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("닫기"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    bool showAlertIcon = false;
    if (widget.cpuProduct['score'] != null &&
        widget.graphicsProduct['score'] != null &&
        (widget.graphicsProduct['score'] / widget.cpuProduct['score'] >= 1.5 ||
            widget.cpuProduct['score'] / widget.graphicsProduct['score'] >=
                1.5)) {
      showAlertIcon = true;
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0, // 그림자 없애기
        backgroundColor: Colors.white, // 배경 색상
        centerTitle: false, // title 중앙 정렬
        iconTheme: IconThemeData(color: Colors.black), // app bar icon color
        title: Text(
          "장바구니",
          style: TextStyle(
            color: Colors.black,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // CPU 항목
            _buildSection(
              context,
              title: "CPU",
              productName: widget.cpuProduct['name'],
              productPrice: widget.cpuProduct['price'],
              showAlertIcon: showAlertIcon,
              onAlertIconPressed: () => _showPerformanceAlert(context),
            ),
            SizedBox(height: 16),

            // 그래픽카드 항목
            _buildSection(
              context,
              title: "그래픽카드",
              productName: widget.graphicsProduct['name'],
              productPrice: widget.graphicsProduct['price'],
              showAlertIcon: showAlertIcon,
              onAlertIconPressed: () => _showPerformanceAlert(context),
            ),
            SizedBox(height: 16),

            // 메인보드 항목
            _buildSection(
              context,
              title: "메인보드",
              productName: widget.mainboardProduct['name'],
              productPrice: widget.mainboardProduct['price'],
              showAlertIcon: false, // 메인보드는 성능 점수 비교 제외
              onAlertIconPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  // 항목을 구성하는 위젯
  Widget _buildSection(BuildContext context,
      {required String title,
      required String productName,
      required String productPrice,
      required bool showAlertIcon,
      required VoidCallback onAlertIconPressed}) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                if (showAlertIcon) // 느낌표 아이콘 조건부 렌더링
                  IconButton(
                    icon: Icon(Icons.warning_amber_outlined,
                        color: Colors.redAccent),
                    onPressed: onAlertIconPressed,
                    tooltip: "성능 차이 알림",
                  ),
              ],
            ),
            Divider(),
            ListTile(
              title: Text(productName),
              subtitle: Text(productPrice),
              trailing: Icon(Icons.check_circle, color: Colors.green),
            ),
          ],
        ),
      ),
    );
  }
}
