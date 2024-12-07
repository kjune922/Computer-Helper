import 'package:com_recipe/Network.dart';
import 'package:com_recipe/pages/cpu_detail_page.dart';
import 'package:flutter/material.dart';
import '../globals.dart';
import 'custom_bottom_nav_bar.dart'; // 하단바 위젯 import

// 받아온 JSON 데이터를 출력합니다

class CpuPage extends StatefulWidget {
  const CpuPage({Key? key}) : super(key: key);

  @override
  State<CpuPage> createState() => _CpuPageState();
}

class _CpuPageState extends State<CpuPage> {
  List<dynamic> jsonData = [];
  int? datacount;
  bool nowLoading = true;

  @override
  void initState() {
    super.initState();

    getcpudata();
  }

  void getcpudata() async {
    final Network _network = Network("http://116.124.191.174:15011/cpu");
    jsonData = await _network.getJsonData();
    datacount = jsonData.length;
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
          'CPU Products',
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
                  // 검색 바
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
                        hintText: 'Search CPU',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  // 상품 목록
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        childAspectRatio: 3 / 4,
                      ),
                      itemCount: datacount, // 상품 개수 (샘플 데이터)
                      itemBuilder: (context, index) {
                        Map<String, dynamic> data = jsonData[index];
                        return _buildProductCard(context, data);
                      },
                    ),
                  ),
                ],
              ),
            ),
      // 고정된 하단바 추가
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 1, // 현재 CPU 페이지 탭에 해당하는 인덱스로 설정
      ),
    );
  }

  // 상품 카드
  Widget _buildProductCard(BuildContext context, Map<String, dynamic> data) {
    return InkWell(
      onTap: () {
        productName = data['cpu_name'];
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const CpuDetailPage()),
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
                  data['image'], // CPU 이미지 경로
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                data['cpu_name'],
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                "${data['cpu_price']}원",
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
                      final Network _cpunetwork = Network(
                          "http://116.124.191.174:15011/shopcpuadd"); //192.168.1.2:15011//116.124.191.174:15011
                      _cpunetwork.updatedb(
                          registeredUsername!, data['cpu_name']);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('CPU가 장바구니에 추가되었습니다')),
                      );
                    }
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
