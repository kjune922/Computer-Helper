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

  void initState(){
    super.initState();

    getgraphicsdata(productName!);
  }

  void getgraphicsdata(String name) async {
    final Network _network = Network("http://116.124.191.174:15011/graphicsdetail");
    jsonData = await _network.productDetail(name);

    setState(() {
      nowLoading = false;
    });
  }

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
      body: nowLoading             //데이터가 다 안받아졌으면 로딩동그라미가 돈다
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
                        style: TextStyle(fontSize: 16, color: Colors.grey),
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
                        style: TextStyle(fontSize: 18, color: Colors.white),
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
}
