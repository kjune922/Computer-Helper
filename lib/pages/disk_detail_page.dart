import 'package:flutter/material.dart';
import '../globals.dart';
import '../Network.dart';
import 'popupexplan.dart';
import 'shoppingcart_page.dart';
import 'package:flutter/gestures.dart';

class DiskDetailPage extends StatefulWidget {
  const DiskDetailPage({Key? key}) : super(key: key);

  @override
  State<DiskDetailPage> createState() => _DiskDetailPageState();
}

class _DiskDetailPageState extends State<DiskDetailPage> {
  bool nowLoading = true;
  List<dynamic> jsonData = [];

  @override
  void initState() {
    super.initState();
    getDiskData(globalproductName!);
  }

  void getDiskData(String name) async {
    final Network _network = Network("http://116.124.191.174:15011/diskdetail");
    jsonData = await _network.productDetail(name);
    setState(() {
      nowLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Disk Details',
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
              if (registeredUsername == null) {
                Navigator.pushNamed(context, '/login');
              } else {
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
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: Colors.grey[200],
                      height: 300,
                      width: double.infinity,
                      child: Image.asset(
                        jsonData[0]['image'],
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      jsonData[0]['disk_name'],
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '${jsonData[0]['disk_price']}원',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (registeredUsername == null) {
                            Navigator.pushNamed(context, '/login');
                          } else {
                            final Network _network = Network(
                                "http://116.124.191.174:15011/shopdiskadd");
                            _network.updatedb(
                                registeredUsername!, jsonData[0]['disk_name']);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('디스크가 장바구니에 추가되었습니다')),
                            );
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
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {
                              if (registeredUsername == null) {
                                Navigator.pushNamed(context, '/login');
                              } else {
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
                      ],
                    ),
                    SizedBox(height: 24),
                    Table(
                      border: TableBorder.all(color: Colors.grey),
                      columnWidths: {
                        0: FlexColumnWidth(2),
                        1: FlexColumnWidth(3),
                      },
                      children: [
                        TableRow(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text.rich(
                                TextSpan(
                                  text: "디스크 종류",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.blue, // 파란색 강조
                                    decoration: TextDecoration.underline, // 밑줄 추가 (선택 사항)
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      showdiskPopup(context: context);
                                    },
                                ),
                              )
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                jsonData[0]['disk_type'],
                                style: TextStyle(
                                    fontSize: 16, color: Colors.grey[700]),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
