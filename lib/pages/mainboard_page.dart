import 'package:com_recipe/Network.dart';
import 'package:com_recipe/globals.dart';
import 'package:flutter/material.dart';
import 'custom_bottom_nav_bar.dart';
import 'mainboard_detail_page.dart';

class MainboardPage extends StatefulWidget {
  final String whatserch;
  final String socket;
  MainboardPage(
      {this.whatserch = '', this.socket = ''}); //소켓검색 whatserch=socket

  @override
  State<MainboardPage> createState() => _MainboardPageState();
}

class _MainboardPageState extends State<MainboardPage> {
  List<dynamic> jsonData = [];
  int? datacount;
  bool nowLoading = true;

  @override
  void initState() {
    super.initState();

    getgraphicsdata();
  }

  void getgraphicsdata() async {
    if (widget.whatserch == 'socket') {
      final Network _network =
          Network("http://116.124.191.174:15011/mainboardsocketserch");
      jsonData = await _network.productDetail(widget.socket);
      datacount = jsonData.length;
    } else {
      final Network _network =
          Network("http://116.124.191.174:15011/mainboard");
      jsonData = await _network.getJsonData();
      datacount = jsonData.length;
    }
    print(datacount);
    setState(() {
      nowLoading = false;
    });
  }

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
          'Mainboard Products',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: nowLoading //데이터가 다 안받아졌으면 로딩동그라미가 돈다
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        icon: Icon(Icons.search, color: Colors.grey),
                        hintText: 'Search Mainboard',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        childAspectRatio: 3 / 4,
                      ),
                      itemCount: datacount,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> data = jsonData[index];
                        return _buildProductCard(context, data);
                      },
                    ),
                  ),
                ],
              ),
            ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 1,
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, Map<String, dynamic> data) {
    return GestureDetector(
      onTap: () {
        globalproductName = data['mainboard_name'];
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MainboardDetailPage(),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.asset(
                  data['image'],
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                data['mainboard_name'],
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                '${data['mainboard_price']}원',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.favorite_border, color: Colors.grey),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.shopping_cart_outlined, color: Colors.grey),
                  onPressed: () {
                    if (registeredUsername == null) {
                      Navigator.pushNamed(context, '/login');
                    } else {
                      final Network _mainboardnetwork = Network(
                          "http://116.124.191.174:15011/shopmainboardadd"); //192.168.1.2:15011//116.124.191.174:15011
                      _mainboardnetwork.updatedb(
                          registeredUsername!, data['mainboard_name']);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('메인보드가 장바구니에 추가되었습니다')), // 추가
                      );
                    }
                    ScaffoldMessenger.of(context).clearSnackBars();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          '메인보드 장바구니에 추가되었습니다',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        backgroundColor: Colors.purple,
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
