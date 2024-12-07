import 'package:com_recipe/Network.dart';
import 'package:com_recipe/globals.dart';
import 'package:com_recipe/pages/popupexplan.dart';
import 'package:com_recipe/pages/power_detail_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'case_detail_page.dart';
import 'cpu_cooler_detail_page.dart';
import 'cpu_detail_page.dart';
import 'cpu_page.dart';
import 'disk_detail_page.dart';
import 'graphics_detail_page.dart';
import 'graphics_page.dart';
import 'mainboard_detail_page.dart';
import 'memory_detail_page.dart';
import 'memory_page.dart';
import 'case_page.dart';
import 'cpu_cooler_page.dart';
import 'disk_page.dart';
import 'mainboard_page.dart';
import 'power_page.dart';

enum ProductType { cpu, graphics, mainboard, memory, power, disk, cpu_cooler, computer_case}

class Shoppingcart extends StatefulWidget {
  Shoppingcart({super.key});

  @override
  State<Shoppingcart> createState() => _ShoppingcartState();
}

class _ShoppingcartState extends State<Shoppingcart> {
  bool nowLoading = true ;

  final Map<ProductType, Widget Function(BuildContext)> productPageMap = {
    ProductType.cpu: (context) => CpuPage(),
    ProductType.graphics: (context) => GraphicsPage(),
    ProductType.mainboard: (context) => MainboardPage(),
    ProductType.memory: (context) => MemoryPage(),
    ProductType.power: (context) => PowerPage(),
    ProductType.disk: (context) =>DiskPage(),
    ProductType.cpu_cooler: (context) => CpuCoolerPage(),
    ProductType.computer_case: (context) => CasePage(),
  };

  final Map<ProductType, Widget Function(BuildContext)> productDetailPageMap = {
    ProductType.cpu: (context) => CpuDetailPage(),
    ProductType.graphics: (context) => GraphicsDetailPage(),
    ProductType.mainboard: (context) => MainboardDetailPage(),
    ProductType.memory: (context) => MemoryDetailPage(),
    ProductType.power: (context) => PowerDetailPage(),
    ProductType.disk: (context) =>DiskDetailPage(),
    ProductType.cpu_cooler: (context) => CpuCoolerDetailPage(),
    ProductType.computer_case: (context) => CaseDetailPage(),
  };

  List cpuinfo =[];
  List graphicsinfo =[];
  List mainboardinfo =[];
  List memoryinfo =[];
  List powerinfo =[];
  List diskinfo =[];
  List cpu_coolerinfo =[];
  List computer_caseinfo =[];

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
  void _showcpugraphicsPerformanceAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '성능 차이 알림',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: Icon(Icons.help_outline), // 물음표 아이콘
                onPressed: () {//성능차이 ?버튼
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('점수차이가 많으면?'),
                              IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.close))
                            ],
                          ),
                          content: Container(
                            height: MediaQuery.of(context).size.height*0.2,
                            width: 300,
                            child: Text.rich(
                              TextSpan(
                                text: 'cpu와 그래픽카드의 ',
                                style: TextStyle(fontSize: 20),
                                children: [
                                  TextSpan(
                                    text: '성능점수',
                                    style: TextStyle(
                                      color: Colors.blue, // 파란색으로 색상 변경
                                      decoration: TextDecoration.underline, // 밑줄 추가
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {//병목현상 클릭시
                                      showScorePopup(context: context);
                                      },
                                  ),
                                  TextSpan(text: '가 1.5배 이상 나면'),
                                  TextSpan(
                                    text: '병목현상',
                                    style: TextStyle(
                                      color: Colors.blue, // 파란색으로 색상 변경
                                      decoration: TextDecoration.underline, // 밑줄 추가
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {//병목현상 클릭시
                                        showBottleneckPopup(context: context);
                                      },
                                  ),
                                  TextSpan(text: '이 발생해요'),
                                ],
                              ),
                            ),
                          ),
                          actions: [
                          ],
                        );
                      });
                },
              ),
              SizedBox(width: 40),
              IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.close))
            ],
          ),
          content: Text(
              'CPU와 그래픽카드의 성능차이가 너무큽니다!\n\n'
              'CPU 성능정수: ${cpuProduct[0]['cpu_score']}\n'
                  '그래픽카드 성능점수: ${graphicsProduct[0]['graphics_score']}',
            style: TextStyle(
              fontSize: 18
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(onPressed: () async {//cpu 글카 문제에서 cpu찾기 눌렀을때
                  Navigator.pop(context);
                  await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) =>
                              CpuPage(
                                  whatserch: 'score',
                                  lowscore: (graphicsProduct[0]['graphics_score'] / 1.5).toInt(),
                                  highscore: (graphicsProduct[0]['graphics_score']*1.5).toInt()
                              )
                      )
                  );
                  setState(() {
                    initializeData();
                  });
                }, child: Text("CPU찾기",style: TextStyle(fontSize: 20),)),
                TextButton(onPressed: () async {// cpu 글카 문제에서 클카찾기 눌렀을때
                  Navigator.pop(context);
                  await Navigator.push(context, MaterialPageRoute(
                      builder: (_) =>
                          GraphicsPage(
                              whatserch:'score',
                              lowscore: (cpuProduct[0]['cpu_score'] / 1.5).toInt(),
                              highscore: (cpuProduct[0]['cpu_score'] * 1.5).toInt()
                          )
                  )
                  );
                  setState(() {
                    initializeData();
                  });

                }, child: Text("그래픽카드찾기",style: TextStyle(fontSize: 20)),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void _showcpumainboardSocketAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '소켓 차이 알림',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: Icon(Icons.help_outline), // 물음표 아이콘
                onPressed: () {//성능차이 ?버튼
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('소켓이 다르면?'),
                              IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.close))
                            ],
                          ),
                          content: Container(
                            height: MediaQuery.of(context).size.height*0.2,
                            width: 300,
                            child: Text.rich(
                              TextSpan(
                                text: 'cpu와 메인보드의 ',
                                style: TextStyle(fontSize: 20),
                                children: [
                                  TextSpan(
                                    text: '소켓',
                                    style: TextStyle(
                                      color: Colors.blue, // 파란색으로 색상 변경
                                      decoration: TextDecoration.underline, // 밑줄 추가
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {//병목현상 클릭시
                                      showSocketPopup(context: context);
                                      },
                                  ),
                                  TextSpan(text: '이 다르면 조립을 할수없어요'),
                                ],
                              ),
                            ),
                          ),
                          actions: [
                          ],
                        );
                      });
                },
              ),
              SizedBox(width: 40),
              IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.close))
            ],
          ),
          content: Text(
            'CPU와 메인보드의 소켓이 다릅니다\n\n'
                'CPU 소켓: ${cpuProduct[0]['cpu_socket']}\n'
                '메인보드 소켓: ${mainboardProduct[0]['mainboard_socket']}',
            style: TextStyle(
                fontSize: 18
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(onPressed: () async {//cpu 메인보드 문제에서 cpu찾기 눌렀을때
                  Navigator.pop(context);
                  await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) =>
                              CpuPage(
                                whatserch: 'socket',
                                socket: mainboardProduct[0]['mainboard_socket'],
                              )
                      )
                  );
                  setState(() {
                    initializeData();
                  });
                }, child: Text("CPU찾기",style: TextStyle(fontSize: 20),)),
                TextButton(onPressed: () async {//cpu 메인보드 문제에서 메인보드찾기 눌렀을때
                  Navigator.pop(context);
                  await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) =>
                              MainboardPage(
                                whatserch: 'socket',
                                socket: cpuProduct[0]['cpu_socket'],
                              )
                      )
                  );
                  setState(() {
                    initializeData();
                  });
                }, child: Text("메인보드찾기",style: TextStyle(fontSize: 20)),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void _showgraphicspowerPwAlert(BuildContext context){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '파워 낮음 알림',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: Icon(Icons.help_outline), // 물음표 아이콘
                onPressed: () {//파워차이 ?버튼
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('파워가 낮으면?'),
                              IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.close))
                            ],
                          ),
                          content: Container(
                            height: MediaQuery.of(context).size.height*0.2,
                            width: 300,
                            child: Text.rich(
                              TextSpan(
                                text: '파워가 그래픽카드의 적정 ',
                                style: TextStyle(fontSize: 20),
                                children: [
                                  TextSpan(
                                    text: '파워',
                                    style: TextStyle(
                                      color: Colors.blue, // 파란색으로 색상 변경
                                      decoration: TextDecoration.underline, // 밑줄 추가
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {//병목현상 클릭시
                                      showPowerPopup(context: context);
                                      },
                                  ),
                                  TextSpan(text: '보다 낮으면 컴퓨터가 꺼질수 있어요'),
                                ],
                              ),
                            ),
                          ),
                          actions: [
                          ],
                        );
                      });
                },
              ),
              SizedBox(width: 40),
              IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.close))
            ],
          ),
          content: Text(
            '그래픽카드 성능에비해 파워가 너무낮습니다\n\n'
                '그래픽카드 적정파워: ${graphicsProduct[0]['graphics_pw']}\n'
                '현재 파워: ${powerProduct[0]['power_pw']}',
            style: TextStyle(
                fontSize: 18
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(onPressed: (){
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (_)=> GraphicsPage(whatserch: 'powerdown',power: powerProduct[0]['power_pw'],)));
                }, child: Text("그래픽카드찾기",style: TextStyle(fontSize: 20),)),
                TextButton(onPressed: (){}, child: Text("파워찾기",style: TextStyle(fontSize: 20)),
                ),
              ],
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

      cpuinfo.clear();
      cpuinfo.add('가격: ${NumberFormat.decimalPattern('ko').format(cpuProduct[0]['cpu_price']).toString()} 원');
      cpuinfo.add('성능정수: ${cpuProduct[0]['cpu_score'].toString()} 점');
      cpuinfo.add('소켓: ${cpuProduct[0]['cpu_socket']}');
      cpuinfo.add('cpu사용파워: ${cpuProduct[0]['cpu_pw'].toString()} W');

    }else{
      cpuProduct.add({
        'cpu_name': '상품이 없습니다',
        'cpu_price': 0,
        'cpu_score': 0,
        'cpu_socket': '소켓이 없습니다',
        'cpu_pw':0,
        'image':'assets/images/noproduct.jpg',
      });
      cpuinfo.clear();
    }
    if(usershopProduct[0]['graphics'] != null){
      final Network _graphicsnetwork = Network("http://116.124.191.174:15011/graphicsdetail");//192.168.1.2:15011//116.124.191.174:15011
      graphicsProduct = await _graphicsnetwork.productDetail(usershopProduct[0]['graphics']);

      graphicsinfo.clear();
      graphicsinfo.add('가격: ${NumberFormat.decimalPattern('ko').format(graphicsProduct[0]['graphics_price']).toString()} 원');
      graphicsinfo.add('성능점수: ${graphicsProduct[0]['graphics_score'].toString()} 점');
      graphicsinfo.add('적정파워: ${graphicsProduct[0]['graphics_pw'].toString()}W');
      graphicsinfo.add('너비: ${graphicsProduct[0]['graphics_width'].toString()}mm');
      graphicsinfo.add('길이: ${graphicsProduct[0]['graphics_length'].toString()}mm');

    }else{
      graphicsProduct.add({
        'graphics_name': '상품이 없습니다',
        'graphics_price': 0,
        'graphics_score': 0,
        'graphics_pw':0,
        'graphics_width':0,
        'graphics_length':0,
        'image':'assets/images/noproduct.jpg',
      });
      graphicsinfo.clear();
      print('비웠다');
    }
    if(usershopProduct[0]['mainboard'] != null){
      final Network _mainboardnetwork = Network("http://116.124.191.174:15011/mainboarddetail");//192.168.1.2:15011//116.124.191.174:15011
      mainboardProduct = await _mainboardnetwork.productDetail(usershopProduct[0]['mainboard']);

      mainboardinfo.clear();
      mainboardinfo.add('가격: ${NumberFormat.decimalPattern('ko').format(mainboardProduct[0]['mainboard_price']).toString()} 원');
      mainboardinfo.add('소켓: ${mainboardProduct[0]['mainboard_socket']}');

    }else{
      mainboardProduct.add({
        'mainboard_name': '상품이 없습니다',
        'mainboard_price': 0,
        'mainboard_socket':'소켓이 없습니다',
        'image':'assets/images/noproduct.jpg',
      });
      mainboardinfo.clear();
    }
    if(usershopProduct[0]['memory'] != null){
      final Network _memorynetwork = Network("http://116.124.191.174:15011/memorydetail");//192.168.1.2:15011//116.124.191.174:15011
      memoryProduct = await _memorynetwork.productDetail(usershopProduct[0]['memory']);

      memoryinfo.add('가격: ${NumberFormat.decimalPattern('ko').format(memoryProduct[0]['memory_price']).toString()} 원');

    }else{
      memoryProduct.add({
        'memory_name': '상품이 없습니다',
        'memory_price': 0,
        'image':'assets/images/noproduct.jpg',
      });
      memoryinfo.clear();
    }
    if(usershopProduct[0]['power'] != null){
      final Network _powernetwork = Network("http://116.124.191.174:15011/powerdetail");//192.168.1.2:15011//116.124.191.174:15011
      powerProduct = await _powernetwork.productDetail(usershopProduct[0]['power']);

      powerinfo.clear();
      powerinfo.add('가격: ${NumberFormat.decimalPattern('ko').format(powerProduct[0]['power_price']).toString()} 원');
      powerinfo.add('파워전력: ${powerProduct[0]['power_pw'].toString()}W');

    }else{
      powerProduct.add({
        'power_name': '상품이 없습니다',
        'power_price': 0,
        'power_pw':0,
        'image':'assets/images/noproduct.jpg',
      });
      powerinfo.clear();
    }
    if(usershopProduct[0]['disk'] != null){
      final Network _disknetwork = Network("http://116.124.191.174:15011/diskdetail");//192.168.1.2:15011//116.124.191.174:15011
      diskProduct = await _disknetwork.productDetail(usershopProduct[0]['disk']);

      diskinfo.clear();
      diskinfo.add('가격: ${NumberFormat.decimalPattern('ko').format(diskProduct[0]['disk_price']).toString()} 원');
      diskinfo.add('종류: ${diskProduct[0]['disk_type']}');

    }else{
      diskProduct.add({
        'disk_name': '상품이 없습니다',
        'disk_price': 0,
        'disk_type':'타입이 없습니다',
        'image':'assets/images/noproduct.jpg',
      });
      diskinfo.clear();
    }
    if(usershopProduct[0]['cpu_cooler'] != null){
      final Network _cpu_coolernetwork = Network("http://116.124.191.174:15011/cpu_coolerdetail");//192.168.1.2:15011//116.124.191.174:15011
      cpu_coolerProduct = await _cpu_coolernetwork.productDetail(usershopProduct[0]['cpu_cooler']);

      cpu_coolerinfo.clear();
      cpu_coolerinfo.add('가격: ${NumberFormat.decimalPattern('ko').format(cpu_coolerProduct[0]['cpu_cooler_price']).toString()} 원');
      cpu_coolerinfo.add('cpu쿨러 높이: ${cpu_coolerProduct[0]['cpu_cooler_height'].toString()}mm');

    }else{
      cpu_coolerProduct.add({
        'cpu_cooler_name': '상품이 없습니다',
        'cpu_cooler_price': 0,
        'cpu_cooler_height':0,
        'image':'assets/images/noproduct.jpg',
      });
      cpu_coolerinfo.clear();
    }
    if(usershopProduct[0]['computer_case'] != null){
      final Network _computer_casenetwork = Network("http://116.124.191.174:15011/computer_casedetail");//192.168.1.2:15011//116.124.191.174:15011
      computer_caseProduct = await _computer_casenetwork.productDetail(usershopProduct[0]['computer_case']);

      computer_caseinfo.clear();
      computer_caseinfo.add('가격: ${NumberFormat.decimalPattern('ko').format(computer_caseProduct[0]['computer_case_price']).toString()} 원');
      computer_caseinfo.add('너비: ${computer_caseProduct[0]['computer_case_width'].toString()}mm');
      computer_caseinfo.add('길이: ${computer_caseProduct[0]['computer_case_length'].toString()}mm');
      computer_caseinfo.add('두께: ${computer_caseProduct[0]['computer_case_thick'].toString()}mm');
      computer_caseinfo.add('cpu쿨러 높이: ${computer_caseProduct[0]['computer_case_cooler_height'].toString()}mm');

    }else{
      computer_caseProduct.add({
        'computer_case_name': '상품이 없습니다',
        'computer_case_price': 0,
        'computer_case_width':0,
        'computer_case_length':0,
        'computer_case_thick':0,
        'computer_case_cooler_height':0,
        'image':'assets/images/noproduct.jpg',
      });
      computer_caseinfo.clear();
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
    bool cpugraphicsshowAlertIcon = false;
    bool cpumainboardshowAlertIcon = false;
    bool graphicspowershowAlertIcon = false;

    if (cpuProduct.isNotEmpty && graphicsProduct.isNotEmpty) {//cpu글카 성능정수
      if (cpuProduct[0]['cpu_score'] != 0 && graphicsProduct[0]['graphics_score'] != 0) {
        if (cpuProduct[0]['cpu_score'] != null &&
            graphicsProduct[0]['graphics_score'] != null &&
            (graphicsProduct[0]['graphics_score'] / cpuProduct[0]['cpu_score'] >= 1.5 ||
                cpuProduct[0]['cpu_score'] / graphicsProduct[0]['graphics_score'] >= 1.5)) {
          cpugraphicsshowAlertIcon = true;
        }
      }
    }
    if(cpuProduct.isNotEmpty && mainboardProduct.isNotEmpty){
      if(cpuProduct[0]['cpu_socket'] != mainboardProduct[0]['mainboard_socket']){
      cpumainboardshowAlertIcon =true;
    }}
    if(cpuProduct.isNotEmpty && mainboardProduct.isNotEmpty){
      if(graphicsProduct[0]['graphics_pw'] > powerProduct[0]['power_pw']){
        graphicspowershowAlertIcon = true;
      }
    }



    return Scaffold(
      appBar: AppBar(
        elevation: 0, // 그림자 없애기
        backgroundColor: Colors.white, // 배경 색상
        centerTitle: false, // title 중앙 정렬
        iconTheme: IconThemeData(color: Colors.black), // app bar icon color
        title: Text(
          "컴알못 장바구니",
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

              whatproduct: productPageMap[ProductType.cpu]!,
              whatproductDetail:productDetailPageMap[ProductType.cpu]!,
              productName: cpuProduct[0]['cpu_name'],
              productInfo: cpuinfo,
              image: cpuProduct[0]['image'],

              showAlertIcon: cpugraphicsshowAlertIcon  || cpumainboardshowAlertIcon,
              onAlertIconPressed: (){
                if(cpugraphicsshowAlertIcon){_showcpugraphicsPerformanceAlert(context);}
                else if(cpumainboardshowAlertIcon){_showcpumainboardSocketAlert(context);}
                },
              onDeletePressed: () async {
                final Network _cpunetwork = Network("http://116.124.191.174:15011/shopcpudel");//192.168.1.2:15011//116.124.191.174:15011
                await _cpunetwork.productDetail(registeredUsername!);
                setState(() {
                  cpuProduct[0]['cpu_name'] = '상품이 없습니다';
                  cpuProduct[0]['cpu_price'] = 0;
                  cpuProduct[0]['cpu_score'] = 0;
                  cpuProduct[0]['image']='assets/images/noproduct.jpg';
                  cpuinfo.clear();
                });
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('삭제되었습니다')));
              },
            ),
            SizedBox(height: 16),

            // 그래픽카드 항목
            _buildSection(
              context,
              title: "그래픽카드",

              whatproduct: productPageMap[ProductType.graphics]!,
              whatproductDetail:productDetailPageMap[ProductType.graphics]!,
              productName: graphicsProduct[0]['graphics_name'],
              productInfo: graphicsinfo,
              image: graphicsProduct[0]['image'],

              showAlertIcon: cpugraphicsshowAlertIcon || graphicspowershowAlertIcon ,
              onAlertIconPressed: () {
                if(cpugraphicsshowAlertIcon){_showcpugraphicsPerformanceAlert(context);}
                else if(graphicspowershowAlertIcon){_showgraphicspowerPwAlert(context);}
                },
              onDeletePressed: () async {
                final Network _graphicsnetwork = Network("http://116.124.191.174:15011/shopgraphicsdel");//192.168.1.2:15011//116.124.191.174:15011
                await _graphicsnetwork.productDetail(registeredUsername!);
                setState(() {
                  graphicsProduct[0]['graphics_name'] = '상품이 없습니다';
                  graphicsProduct[0]['graphics_price'] = 0;
                  graphicsProduct[0]['graphics_score'] = 0;
                  graphicsProduct[0]['image']='assets/images/noproduct.jpg';
                  graphicsinfo.clear();
                });
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('삭제되었습니다')));
              },
            ),
            SizedBox(height: 16),

            // 메인보드 항목
            _buildSection(
              context,
              title: "메인보드",

              whatproduct: productPageMap[ProductType.mainboard]!,
              whatproductDetail:productDetailPageMap[ProductType.mainboard]!,
              productName: mainboardProduct[0]['mainboard_name'],
              productInfo: mainboardinfo,
              image: mainboardProduct[0]['image'],

              showAlertIcon: cpumainboardshowAlertIcon, // 메인보드는 성능 점수 비교 제외
              onAlertIconPressed: () {_showcpumainboardSocketAlert(context);},
              onDeletePressed: () async {
                final Network _mainboardnetwork = Network("http://116.124.191.174:15011/shopmainboarddel");//192.168.1.2:15011//116.124.191.174:15011
                await _mainboardnetwork.productDetail(registeredUsername!);
                setState(() {
                  mainboardProduct[0]['mainboard_name'] = '상품이 없습니다';
                  mainboardProduct[0]['mainboard_price'] = 0;
                  mainboardProduct[0]['image']='assets/images/noproduct.jpg';
                  mainboardinfo.clear();
                });
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('삭제되었습니다')));
              },
            ),
            SizedBox(height: 16),

            _buildSection(
              context,
              title: "메모리",

              whatproduct: productPageMap[ProductType.memory]!,
              whatproductDetail:productDetailPageMap[ProductType.memory]!,
              productName: memoryProduct[0]['memory_name'],
              productInfo: memoryinfo,
              image: memoryProduct[0]['image'],

              showAlertIcon: false, // 메인보드는 성능 점수 비교 제외
              onAlertIconPressed: () {},
              onDeletePressed: () async {
                final Network _memorynetwork = Network("http://116.124.191.174:15011/shopmemorydel");//192.168.1.2:15011//116.124.191.174:15011
                await _memorynetwork.productDetail(registeredUsername!);
                setState(() {
                  memoryProduct[0]['memory_name'] = '상품이 없습니다';
                  memoryProduct[0]['memory_price'] = 0;
                  memoryProduct[0]['image']='assets/images/noproduct.jpg';
                  memoryinfo.clear();
                });
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('삭제되었습니다')));
              },
            ),
            SizedBox(height: 16),

            _buildSection(
              context,
              title: "파워",

              whatproduct: productPageMap[ProductType.power]!,
              whatproductDetail:productDetailPageMap[ProductType.power]!,
              productName: powerProduct[0]['power_name'],
              productInfo: powerinfo,
              image: powerProduct[0]['image'],

              showAlertIcon: graphicspowershowAlertIcon,
              onAlertIconPressed: () {_showgraphicspowerPwAlert(context);},
              onDeletePressed: () async {
                final Network _powernetwork = Network("http://116.124.191.174:15011/shoppowerdel");//192.168.1.2:15011//116.124.191.174:15011
                await _powernetwork.productDetail(registeredUsername!);
                setState(() {
                  powerProduct[0]['power_name'] = '상품이 없습니다';
                  powerProduct[0]['power_price'] = 0;
                  powerProduct[0]['image']='assets/images/noproduct.jpg';
                  powerinfo.clear();
                });
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('삭제되었습니다')));
              },
            ),
            SizedBox(height: 16),

            _buildSection(
              context,
              title: "디스크(저장장치)",

              whatproduct: productPageMap[ProductType.disk]!,
              whatproductDetail:productDetailPageMap[ProductType.disk]!,
              productName: diskProduct[0]['disk_name'],
              productInfo: diskinfo,
              image: diskProduct[0]['image'],

              showAlertIcon: false, // 메인보드는 성능 점수 비교 제외
              onAlertIconPressed: () {},
              onDeletePressed: () async {
                final Network _disknetwork = Network("http://116.124.191.174:15011/shopdiskdel");//192.168.1.2:15011//116.124.191.174:15011
                await _disknetwork.productDetail(registeredUsername!);
                setState(() {
                  diskProduct[0]['disk_name'] = '상품이 없습니다';
                  diskProduct[0]['disk_price'] = 0;
                  diskProduct[0]['image']='assets/images/noproduct.jpg';
                  diskinfo.clear();
                });
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('삭제되었습니다')));
              },
            ),
            SizedBox(height: 16),

            _buildSection(
              context,
              title: "cpu쿨러",

              whatproduct: productPageMap[ProductType.cpu_cooler]!,
              whatproductDetail:productDetailPageMap[ProductType.cpu_cooler]!,
              productName: cpu_coolerProduct[0]['cpu_cooler_name'],
              productInfo: cpu_coolerinfo,
              image: cpu_coolerProduct[0]['image'],

              showAlertIcon: false, // 메인보드는 성능 점수 비교 제외
              onAlertIconPressed: () {},
              onDeletePressed: () async {
                final Network _cpu_coolernetwork = Network("http://116.124.191.174:15011/shopcpu_coolerdel");//192.168.1.2:15011//116.124.191.174:15011
                await _cpu_coolernetwork.productDetail(registeredUsername!);
                setState(() {
                  cpu_coolerProduct[0]['cpu_cooler_name'] = '상품이 없습니다';
                  cpu_coolerProduct[0]['cpu_cooler_price'] = 0;
                  cpu_coolerProduct[0]['image']='assets/images/noproduct.jpg';
                  cpu_coolerinfo.clear();
                });
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('삭제되었습니다')));
              },
            ),
            SizedBox(height: 16),

            _buildSection(
              context,
              title: "케이스",

              whatproduct: productPageMap[ProductType.computer_case]!,
              whatproductDetail:productDetailPageMap[ProductType.computer_case]!,
              productName: computer_caseProduct[0]['computer_case_name'],
              productInfo: computer_caseinfo,
              image: computer_caseProduct[0]['image'],

              showAlertIcon: false, // 메인보드는 성능 점수 비교 제외
              onAlertIconPressed: () {},
              onDeletePressed: () async {
                final Network _computer_casenetwork = Network("http://116.124.191.174:15011/shopcomputer_casedel");//192.168.1.2:15011//116.124.191.174:15011
                await _computer_casenetwork.productDetail(registeredUsername!);
                setState(() {
                  computer_caseProduct[0]['computer_case_name'] = '상품이 없습니다';
                  computer_caseProduct[0]['computer_case_price'] = 0;
                  computer_caseProduct[0]['image']='assets/images/noproduct.jpg';
                  computer_caseinfo.clear();
                });
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('삭제되었습니다')));
              },
            ),
            Text('합계: ${NumberFormat.decimalPattern('ko').format(cpuProduct[0]['cpu_price'] + graphicsProduct[0]['graphics_price']+mainboardProduct[0]['mainboard_price']
                +memoryProduct[0]['memory_price']+powerProduct[0]['power_price']+diskProduct[0]['disk_price']
                +cpu_coolerProduct[0]['cpu_cooler_price']+computer_caseProduct[0]['computer_case_price'])}원',
              style: TextStyle(fontSize: 40),
            ),
            //구매하기버튼만들어야함

          ],
        ),
        ),
      ),
    );
  }

  // 항목을 구성하는 위젯
  Widget _buildSection(BuildContext context,
      {required String title,
        required Widget Function(BuildContext) whatproduct,
        required Widget Function(BuildContext) whatproductDetail,
        required String productName,
        required List<dynamic> productInfo,
        required String image,
        required bool showAlertIcon,
        required VoidCallback onAlertIconPressed,
        required VoidCallback onDeletePressed}) {
    bool isbad;
    if(productName == '상품이 없습니다'){
      isbad = true;
    }else{
      isbad = false;
    }
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    Row(
                      children: [
                        !isbad
                            ? TextButton(onPressed: (){
                                globalproductName = productName;
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: whatproductDetail),
                                );}, child: Text('상세정보보기',style: TextStyle(fontSize: 18),))
                            : SizedBox.shrink(),
                        IconButton(
                          icon: Icon(Icons.delete_outline, color: Colors.red),
                          onPressed: onDeletePressed, // 삭제 버튼 클릭 시 동작
                          tooltip: "지우기",
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
            Divider(),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Image.asset(
                    image,
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: ListTile(
                    title: Text(productName),
                    subtitle: Column(
                      children: [
                        Container(
                          height: 50,
                          child: ListView.builder(
                              itemCount: productInfo.length,
                              itemBuilder: (context,index){
                                return _productinfocard(infoData: productInfo[index],);
                              },
                          ),
                        ),
                      ],
                    ),
                      trailing: showAlertIcon
                          ? IconButton(onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context){
                              return AlertDialog(
                                title: Text('$title 상품페이지로 이동하시겠습니까?'),
                                actions: [
                                  TextButton(onPressed: () async {
                                    Navigator.pop(context);
                                    await Navigator.push(context, MaterialPageRoute(builder: whatproduct));
                                    setState(() {
                                      initializeData();
                                    });
                                    }, child: Text('확인',style: TextStyle(fontSize: 20),)),
                                  TextButton(onPressed: (){Navigator.pop(context);}, child: Text('취소',style: TextStyle(fontSize: 20),))
                                ],
                              );
                            });
                      }, icon: Icon(Icons.warning, color: Colors.orange, size: 35))
                          : isbad
                          ? IconButton(onPressed: (){
                        showDialog(
                            context: context,
                            builder: (context){
                              return AlertDialog(
                                title: Text('$title 상품페이지로 이동하시겠습니까?'),
                                actions: [
                                  TextButton(onPressed: ()async{
                                    Navigator.pop(context);
                                    await Navigator.push(context, MaterialPageRoute(builder: whatproduct));
                                    setState(() {
                                      initializeData();
                                    });
                                    },
                                      child: Text('확인',style: TextStyle(fontSize: 20),)),
                                  TextButton(onPressed: (){Navigator.pop(context);}, child: Text('취소',style: TextStyle(fontSize: 20),))
                                ],
                              );
                            });
                      }, icon: Icon(Icons.cancel, color: Colors.red, size: 35))
                          : IconButton(onPressed: (){
                        ScaffoldMessenger.of(context).clearSnackBars();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Center(
                              child: Text(
                                '문제없습니다!',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            backgroundColor: Colors.blueAccent,
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }, icon: Icon(Icons.check_circle, color: Colors.green, size: 35))
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _productinfocard extends StatelessWidget {
  final String infoData;
  _productinfocard({required this.infoData});
  @override

  Widget build(BuildContext context) {
    return Text(infoData);
  }
}

