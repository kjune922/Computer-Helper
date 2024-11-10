import 'package:com_recipe/Network.dart';
import 'package:flutter/material.dart';
import '../globals.dart';
import 'shoppingcart_page.dart'; // shoppingcart 페이지 import

class GraphicsDetailPage extends StatefulWidget {
  const GraphicsDetailPage({Key? key}) : super(key: key);

  @override
  State<GraphicsDetailPage> createState() => _GraphicsDetailPageState();
}

class _GraphicsDetailPageState extends State<GraphicsDetailPage> {
  List<dynamic> jsonData = [];
  bool nowLoading = true;

  @override
  void initState() {
    super.initState();
    getGraphicsData(productName!);
  }

  void getGraphicsData(String name) async {
    final Network _network =
        Network("http://116.124.191.174:15011/graphicsdetail");
    jsonData = await _network.productDetail(name);

    setState(() {
      nowLoading = false;
    });
  }

  // 팝업 창을 보여주는 함수
  void _showPopup(BuildContext context, String title, Widget content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          content: content,
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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Graphics Card Details',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.black),
            onPressed: () {
              // 검색 기능
            },
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart, color: Colors.black),
            onPressed: () {
              // 장바구니 페이지로 이동
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Shoppingcart(),
                ),
              );
            },
          ),
        ],
      ),
      body: nowLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 제품 이미지 및 기본 정보
                  Container(
                    color: Colors.grey[200],
                    height: 300,
                    width: double.infinity,
                    child: Image.asset(
                      'assets/images/graphics2.jpg', // 그래픽카드 이미지 경로
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          jsonData[0]['graphics_name'],
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Text(
                              '${jsonData[0]['graphics_price']}원',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                            SizedBox(width: 10),
                            Text(
                              '할인률 적기',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.orange, size: 20),
                            SizedBox(width: 4),
                            Text(
                              '4.8',
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(width: 5),
                            Text(
                              '(리뷰 120개)',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                          ],
                        ),
                        SizedBox(height: 24),

                        // 강조된 팝업 버튼들 (파워 정보, 벤치마킹 점수)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildPopupButton(
                              context,
                              title: "파워 정보",
                              buttonText: "파워",
                              content: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildInfoRow("TDP", "250W"),
                                  _buildInfoRow("최대 클럭", "1.8GHz"),
                                ],
                              ),
                            ),
                            _buildPopupButton(
                              context,
                              title: "벤치마킹 점수",
                              buttonText: "벤치마킹",
                              content: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildInfoRow("3DMark 점수", "15000"),
                                  _buildInfoRow("CUDA 코어 수", "3072"),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 24),

                        // 구매하기 버튼
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              // 구매하기 기능
                            },
                            child: Text(
                              '구매하기',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.purple,
                              padding: EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 12),

                        // 장바구니 및 찜 버튼
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: () {
                                  // 장바구니 페이지로 이동
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Shoppingcart(),
                                    ),
                                  );
                                },
                                icon: Icon(Icons.shopping_cart_outlined),
                                label: Text('장바구니'),
                                style: OutlinedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(vertical: 14),
                                  side: BorderSide(color: Colors.grey),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: () {
                                  // 찜 기능
                                },
                                icon: Icon(Icons.favorite_border),
                                label: Text('찜'),
                                style: OutlinedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(vertical: 14),
                                  side: BorderSide(color: Colors.grey),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  // 팝업 버튼 생성 함수
  Widget _buildPopupButton(BuildContext context,
      {required String title,
      required String buttonText,
      required Widget content}) {
    return ElevatedButton(
      onPressed: () {
        _showPopup(context, title, content);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blueAccent,
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        buttonText,
        style: TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }

  // 정보 행을 생성하는 함수
  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 16, color: Colors.grey[700]),
          ),
        ],
      ),
    );
  }
}
