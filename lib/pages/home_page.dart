import 'package:flutter/material.dart';
import 'custom_bottom_nav_bar.dart'; // 하단바 위젯 import
import 'dart:io'; // 앱 종료를 위해 추가

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 컴퓨터 부품 데이터 리스트
    List<Map<String, dynamic>> dataList = [
      {
        "category": "CPU",
        "imgUrl": "assets/images/cpu.png",
        "goWhere": "/cpu",
      },
      {
        "category": "그래픽 카드",
        "imgUrl": "assets/images/graphics.jpg",
        "goWhere": "/graphics",
      },
      {
        "category": "메인 보드",
        "imgUrl": "assets/images/mainboard.jpg",
        "goWhere": "/mainboard",
      },
      {
        "category": "사용시 주의사항",
        "imgUrl": "assets/images/warning.png",
        "goWhere": "/warning",
      },
      {
        "category": "부품 설명 도움",
        "imgUrl": "assets/images/explanation.png",
        "goWhere": "/explanation",
      },
    ];

    return PopScope(
      canPop: false, // 뒤로 가기(pop)를 방지
      onPopInvokedWithResult: (didPop, result) {
        // 뒤로 가기 버튼을 누르면 앱 종료
        if (!didPop) exit(0); // 앱 종료
      },

      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          automaticallyImplyLeading: false, // 첫 애뮬켰을때 로그인안했는데도 뜨는 뒤로가기 화살표 제거
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text(
            "컴알못 도우미",
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
                    hintText: 'Search products...',
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(height: 16),
              // 부품 목록
              Expanded(
                child: ListView.builder(
                  itemCount: dataList.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> data = dataList[index];
                    return _buildProductCard(context, data);
                  },
                ),
              ),
            ],
          ),
        ),
        // 고정된 하단바 추가
        bottomNavigationBar: CustomBottomNavBar(
          currentIndex: 0, // 홈 탭을 기본 선택 상태로 설정
        ),
      ),
    );
  }

  // 기존 카드 스타일을 유지하면서 UI 개선
  Widget _buildProductCard(BuildContext context, Map<String, dynamic> data) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, data['goWhere']);
      },
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        clipBehavior: Clip.antiAlias,
        elevation: 4,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // 배경 이미지
            Image.asset(
              data['imgUrl'],
              width: double.infinity,
              height: 150,
              fit: BoxFit.cover,
            ),
            // 반투명 오버레이
            Container(
              width: double.infinity,
              height: 150,
              color: Colors.black.withOpacity(0.4),
            ),
            // 카테고리 텍스트
            Positioned(
              child: Text(
                data['category'],
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
