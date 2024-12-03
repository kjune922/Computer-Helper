import 'package:com_recipe/Network.dart';
import 'package:com_recipe/globals.dart';
import 'package:flutter/material.dart';

class Shoppingcart extends StatefulWidget {
  Shoppingcart({super.key});

  @override
  State<Shoppingcart> createState() => _ShoppingcartState();
}

class _ShoppingcartState extends State<Shoppingcart> {
  bool nowLoading = true ;
  // 예시 데이터: CPU와 그래픽카드의 성능점수와 이름
  /*
  Map<String, dynamic> cpuProduct = {
    'name': 'Intel i7 Processor',
    'score': 700,
    'price': '299,000원'
  };
  Map<String, dynamic> graphicsProduct = {
    'name': 'NVIDIA GTX 3080',
    'score': 1200,
    'price': '1,200,000원'
  };
  Map<String, dynamic> mainboardProduct = {
    'name': 'ASUS ROG Strix B550-F',
    'price': '189,000원'
  };


  Map<String, dynamic> cpuProduct ={};
  Map<String, dynamic> graphicsProduct = {};
  Map<String, dynamic> mainboardProduct = {};
  */

  List<dynamic> cpuProduct =[];
  List<dynamic> graphicsProduct = [];
  List<dynamic> mainboardProduct = [];
  List<dynamic> computer_caseProduct =[];
  List<dynamic> cpu_coolerProduct =[];
  List<dynamic> diskProduct =[];
  List<dynamic> memoryProduct =[];
  List<dynamic> powerProduct =[];

  List<dynamic> usershopProduct = [];

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

  void initState() {
    super.initState();
    initializeData();
  }

  void initializeData() async {
    await getuserdata();

    if(usershopProduct[0]['cpu'] != null){
      final Network _cpunetwork = Network("http://116.124.191.174:15011/cpudetail");//192.168.1.2:15011//116.124.191.174:15011
      cpuProduct = await _cpunetwork.productDetail(usershopProduct[0]['cpu']);
    }else{
      cpuProduct.add({
        'cpu_name': '상품이 없습니다',
        'cpu_price': 0,
        'cpu_score': 0,
      });
    }
    if(usershopProduct[0]['graphics'] != null){
      final Network _graphicsnetwork = Network("http://116.124.191.174:15011/graphicsdetail");//192.168.1.2:15011//116.124.191.174:15011
      graphicsProduct = await _graphicsnetwork.productDetail(usershopProduct[0]['graphics']);
    }else{
      graphicsProduct.add({
        'graphics_name': '상품이 없습니다',
        'graphics_price': 0,
        'graphics_score': 0,
      });
    }
    if(usershopProduct[0]['mainboard'] != null){
      final Network _mainboardnetwork = Network("http://116.124.191.174:15011/mainboarddetail");//192.168.1.2:15011//116.124.191.174:15011
      mainboardProduct = await _mainboardnetwork.productDetail(usershopProduct[0]['mainboard']);
    }else{
      mainboardProduct.add({
        'mainboard_name': '상품이 없습니다',
        'mainboard_price': 0,
      });
    }
    if(usershopProduct[0]['memory'] != null){
      final Network _memorynetwork = Network("http://116.124.191.174:15011/memorydetail");//192.168.1.2:15011//116.124.191.174:15011
      memoryProduct = await _memorynetwork.productDetail(usershopProduct[0]['memory']);
    }else{
      memoryProduct.add({
        'memory_name': '상품이 없습니다',
        'memory_price': 0,
      });
    }
    if(usershopProduct[0]['power'] != null){
      final Network _powernetwork = Network("http://116.124.191.174:15011/powerdetail");//192.168.1.2:15011//116.124.191.174:15011
      powerProduct = await _powernetwork.productDetail(usershopProduct[0]['power']);
    }else{
      powerProduct.add({
        'power_name': '상품이 없습니다',
        'power_price': 0,
      });
    }
    if(usershopProduct[0]['disk'] != null){
      final Network _disknetwork = Network("http://116.124.191.174:15011/diskdetail");//192.168.1.2:15011//116.124.191.174:15011
      diskProduct = await _disknetwork.productDetail(usershopProduct[0]['disk']);
    }else{
      diskProduct.add({
        'disk_name': '상품이 없습니다',
        'disk_price': 0,
      });
    }
    if(usershopProduct[0]['cpu_cooler'] != null){
      final Network _cpu_coolernetwork = Network("http://116.124.191.174:15011/cpu_coolerdetail");//192.168.1.2:15011//116.124.191.174:15011
      cpu_coolerProduct = await _cpu_coolernetwork.productDetail(usershopProduct[0]['cpu_cooler']);
    }else{
      cpu_coolerProduct.add({
        'cooler_name': '상품이 없습니다',
        'cooler_price': 0,
      });
    }
    if(usershopProduct[0]['computer_case'] != null){
      final Network _computer_casenetwork = Network("http://116.124.191.174:15011/computer_casedetail");//192.168.1.2:15011//116.124.191.174:15011
      computer_caseProduct = await _computer_casenetwork.productDetail(usershopProduct[0]['computer_case']);
    }else{
      computer_caseProduct.add({
        'case_name': '상품이 없습니다',
        'case_price': 0,
      });
    }
    setState(() {
      nowLoading = false;
    });
  }

  Future<void> getuserdata() async{
    final Network _usernetwork = Network("http://116.124.191.174:15011/shop");//192.168.1.2:15011//116.124.191.174:15011
    usershopProduct = await _usernetwork.productDetail(registeredUsername!);
  }

  Widget build(BuildContext context) {
    bool showAlertIcon = false;

    if (cpuProduct.isNotEmpty && graphicsProduct.isNotEmpty) {
      if (cpuProduct[0]['cpu_score'] != 0 && graphicsProduct[0]['graphics_score'] != 0) {
        if (cpuProduct[0]['cpu_score'] != null &&
            graphicsProduct[0]['graphics_score'] != null &&
            (graphicsProduct[0]['graphics_score'] / cpuProduct[0]['cpu_score'] >= 1.5 ||
                cpuProduct[0]['cpu_score'] / graphicsProduct[0]['graphics_score'] >= 1.5)) {
          showAlertIcon = true;
        }
      }

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
      body: nowLoading             //데이터가 다 안받아졌으면 로딩동그라미가 돈다
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // CPU 항목
            _buildSection(
              context,
              title: "CPU",

              productName: cpuProduct[0]['cpu_name'],
              productPrice: '${cpuProduct[0]['cpu_price']}원',

              showAlertIcon: showAlertIcon,
              onAlertIconPressed: () => _showPerformanceAlert(context),
              onDeletePressed: () async {
                final Network _cpunetwork = Network("http://116.124.191.174:15011/shopcpudel");//192.168.1.2:15011//116.124.191.174:15011
                await _cpunetwork.productDetail(registeredUsername!);
                setState(() {
                  cpuProduct[0]['cpu_name'] = '상품이 없습니다';
                  cpuProduct[0]['cpu_price'] = 0;
                  cpuProduct[0]['cpu_score'] = 0;
                });
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('삭제되었습니다')));
              },
            ),
            SizedBox(height: 16),

            // 그래픽카드 항목
            _buildSection(
              context,
              title: "그래픽카드",

              productName: graphicsProduct[0]['graphics_name'],
              productPrice: '${graphicsProduct[0]['graphics_price']}원',

              showAlertIcon: showAlertIcon,
              onAlertIconPressed: () => _showPerformanceAlert(context),
              onDeletePressed: () async {
                final Network _graphicsnetwork = Network("http://116.124.191.174:15011/shopgraphicsdel");//192.168.1.2:15011//116.124.191.174:15011
                await _graphicsnetwork.productDetail(registeredUsername!);
                setState(() {
                  graphicsProduct[0]['graphics_name'] = '상품이 없습니다';
                  graphicsProduct[0]['graphics_price'] = 0;
                  graphicsProduct[0]['graphics_score'] = 0;

                });
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('삭제되었습니다')));
              },
            ),
            SizedBox(height: 16),

            // 메인보드 항목
            _buildSection(
              context,
              title: "메인보드",

              productName: mainboardProduct[0]['mainboard_name'],
              productPrice: '${mainboardProduct[0]['mainboard_price']}원',

              showAlertIcon: false, // 메인보드는 성능 점수 비교 제외
              onAlertIconPressed: () {},
              onDeletePressed: () async {
                final Network _mainboardnetwork = Network("http://116.124.191.174:15011/shopmainboarddel");//192.168.1.2:15011//116.124.191.174:15011
                await _mainboardnetwork.productDetail(registeredUsername!);
                setState(() {
                  mainboardProduct[0]['mainboard_name'] = '상품이 없습니다';
                  mainboardProduct[0]['mainboard_price'] = 0;
                });
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('삭제되었습니다')));
              },
            ),
            SizedBox(height: 16),

            _buildSection(
              context,
              title: "메모리",

              productName: memoryProduct[0]['memory_name'],
              productPrice: '${memoryProduct[0]['memory_price']}원',

              showAlertIcon: false, // 메인보드는 성능 점수 비교 제외
              onAlertIconPressed: () {},
              onDeletePressed: () async {
                final Network _memorynetwork = Network("http://116.124.191.174:15011/shopmemorydel");//192.168.1.2:15011//116.124.191.174:15011
                await _memorynetwork.productDetail(registeredUsername!);
                setState(() {
                  memoryProduct[0]['memory_name'] = '상품이 없습니다';
                  memoryProduct[0]['memory_price'] = 0;
                });
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('삭제되었습니다')));
              },
            ),
            SizedBox(height: 16),

            _buildSection(
              context,
              title: "파워",

              productName: powerProduct[0]['power_name'],
              productPrice: '${powerProduct[0]['power_price']}원',

              showAlertIcon: false, // 메인보드는 성능 점수 비교 제외
              onAlertIconPressed: () {},
              onDeletePressed: () async {
                final Network _powernetwork = Network("http://116.124.191.174:15011/shoppowerdel");//192.168.1.2:15011//116.124.191.174:15011
                await _powernetwork.productDetail(registeredUsername!);
                setState(() {
                  powerProduct[0]['power_name'] = '상품이 없습니다';
                  powerProduct[0]['power_price'] = 0;
                });
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('삭제되었습니다')));
              },
            ),
            SizedBox(height: 16),

            _buildSection(
              context,
              title: "디스크(저장장치)",

              productName: diskProduct[0]['disk_name'],
              productPrice: '${diskProduct[0]['disk_price']}원',

              showAlertIcon: false, // 메인보드는 성능 점수 비교 제외
              onAlertIconPressed: () {},
              onDeletePressed: () async {
                final Network _disknetwork = Network("http://116.124.191.174:15011/shopdiskdel");//192.168.1.2:15011//116.124.191.174:15011
                await _disknetwork.productDetail(registeredUsername!);
                setState(() {
                  diskProduct[0]['disk_name'] = '상품이 없습니다';
                  diskProduct[0]['disk_price'] = 0;
                });
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('삭제되었습니다')));
              },
            ),
            SizedBox(height: 16),

            _buildSection(
              context,
              title: "cpu쿨러",

              productName: cpu_coolerProduct[0]['cooler_name'],
              productPrice: '${cpu_coolerProduct[0]['cooler_price']}원',

              showAlertIcon: false, // 메인보드는 성능 점수 비교 제외
              onAlertIconPressed: () {},
              onDeletePressed: () async {
                final Network _cpu_coolernetwork = Network("http://116.124.191.174:15011/shopcpu_coolerdel");//192.168.1.2:15011//116.124.191.174:15011
                await _cpu_coolernetwork.productDetail(registeredUsername!);
                setState(() {
                  cpu_coolerProduct[0]['cooler_name'] = '상품이 없습니다';
                  cpu_coolerProduct[0]['cooler_price'] = 0;
                });
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('삭제되었습니다')));
              },
            ),
            SizedBox(height: 16),

            _buildSection(
              context,
              title: "케이스",

              productName: computer_caseProduct[0]['case_name'],
              productPrice: '${computer_caseProduct[0]['case_price']}원',

              showAlertIcon: false, // 메인보드는 성능 점수 비교 제외
              onAlertIconPressed: () {},
              onDeletePressed: () async {
                final Network _computer_casenetwork = Network("http://116.124.191.174:15011/shopcomputer_casedel");//192.168.1.2:15011//116.124.191.174:15011
                await _computer_casenetwork.productDetail(registeredUsername!);
                setState(() {
                  computer_caseProduct[0]['case_name'] = '상품이 없습니다';
                  computer_caseProduct[0]['case_price'] = 0;
                });
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('삭제되었습니다')));
              },
            ),
          ],
        ),
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
        required VoidCallback onAlertIconPressed,
        required VoidCallback onDeletePressed}) { // onDeletePressed 추가
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack( // Stack을 사용하여 위에 아이콘 배치
              children: [
                Row(
                  children: [
                    Text(
                      title,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    if (showAlertIcon) // 성능 차이 알림 아이콘 조건부 렌더링
                      IconButton(
                        icon: Icon(Icons.warning_amber_outlined,
                            color: Colors.redAccent),
                        onPressed: onAlertIconPressed,
                        tooltip: "성능 차이 알림",
                      ),
                  ],
                ),
                // 지우기 아이콘 버튼
                Positioned(
                  right: 0,
                  top: 0,
                  child: IconButton(
                    icon: Icon(Icons.delete_outline, color: Colors.red),
                    onPressed: onDeletePressed, // 삭제 버튼 클릭 시 동작
                    tooltip: "지우기",
                  ),
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

