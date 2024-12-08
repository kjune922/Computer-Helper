import 'package:com_recipe/Network.dart';
import 'package:com_recipe/globals.dart';
import 'package:com_recipe/pages/popupexplan.dart';
import 'package:flutter/material.dart';
import 'shoppingcart_page.dart'; // 장바구니 페이지 import

class CpuDetailPage extends StatefulWidget {
  const CpuDetailPage({Key? key}) : super(key: key);

  @override
  _CpuDetailPageState createState() => _CpuDetailPageState();
}

class _CpuDetailPageState extends State<CpuDetailPage> {
  bool isFavorite = false; // 찜 여부 상태 관리
  bool nowLoading = true;
  List<dynamic> jsonData = [];

  @override
  void initState() {
    super.initState();
    getcpudata(globalproductName!);
  }

  void getcpudata(String name) async {
    final Network _network = Network("http://116.124.191.174:15011/cpudetail");
    jsonData = await _network.productDetail(name);

    setState(() {
      nowLoading = false;
    });
  }

  // 팝업 창을 보여주는 함수
  void _showPopup(BuildContext context,String label) {
    if(label =='소켓'){
      showSocketPopup(context: context);
    }else if(label =='파워'){
      showPowerPopup(context: context);
    }else if(label =='성능 점수'){
      showScorePopup(context: context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'CPU Details',
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
            icon: Icon(Icons.shopping_cart, color: Colors.black),
            onPressed: () {
              if(registeredUsername == null){
                Navigator.pushNamed(context, '/login');
              }else{
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Shoppingcart(),
                  ),
                );
              }
            },
          ),
        ],
      ),
      body: nowLoading
          ? Center(child: CircularProgressIndicator()) // 로딩 표시
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 제품 이미지 및 기본 정보
                    Container(
                      color: Colors.grey[200],
                      height: 300,
                      width: double.infinity,
                      child: Image.asset(
                        jsonData[0]['image'], // CPU 이미지 경로
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      jsonData[0]['cpu_name'],
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          '${jsonData[0]['cpu_price']}원',
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
                          '4.9',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(width: 5),
                        Text(
                          '(리뷰 200개)',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ],
                    ),
                    SizedBox(height: 24),

                    // 구매하기, 장바구니, 찜 버튼들
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if(registeredUsername == null){
                            Navigator.pushNamed(context, '/login');
                          }else{
                            final Network _cpunetwork = Network("http://116.124.191.174:15011/shopcpuadd");//192.168.1.2:15011//116.124.191.174:15011
                            _cpunetwork.updatedb(registeredUsername!,jsonData[0]['cpu_name']);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('CPU 장바구니에 추가되었습니다')));
                          }
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
                              if(registeredUsername == null){
                                Navigator.pushNamed(context, '/login');
                              }else{
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Shoppingcart(),
                                  ),
                                );
                              }
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
                              setState(() {
                                isFavorite = !isFavorite;
                              });
                            },
                            icon: Icon(
                              isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: isFavorite ? Colors.red : Colors.grey,
                            ),
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
                    SizedBox(height: 24),

                    // 소켓, 파워, 성능 점수 항목
                    Table(
                      border: TableBorder.all(color: Colors.grey),
                      columnWidths: {
                        0: FlexColumnWidth(2),
                        1: FlexColumnWidth(3),
                      },
                      children: [
                        _buildClickableRow(
                          context,
                          "소켓",
                          jsonData[0]['cpu_socket'],
                        ),
                        _buildClickableRow(
                          context,
                          "파워",
                          '${jsonData[0]['cpu_pw']} W',
                        ),
                        _buildClickableRow(
                          context,
                          "성능 점수",
                          '${jsonData[0]['cpu_score']} 점',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  // 클릭 가능한 테이블 행 생성 함수
  TableRow _buildClickableRow(
      BuildContext context, String label, String value) {
    return TableRow(
      children: [
        GestureDetector(
          onTap: () {
            _showPopup(context,label);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.blue,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            value,
            style: TextStyle(fontSize: 16, color: Colors.grey[700]),
          ),
        ),
      ],
    );
  }
}
