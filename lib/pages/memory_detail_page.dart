import 'package:com_recipe/Network.dart';
import 'package:flutter/material.dart';
import '../globals.dart';
import 'shoppingcart_page.dart';

class MemoryDetailPage extends StatefulWidget {
  const MemoryDetailPage({Key? key}) : super(key: key);

  @override
  _MemoryDetailPageState createState() => _MemoryDetailPageState();
}

class _MemoryDetailPageState extends State<MemoryDetailPage> {
  List<dynamic> jsonData = [];
  bool nowLoading = true;

  @override
  void initState() {
    super.initState();
    getMemoryData(productName!);
  }

  void getMemoryData(String name) async {
    final Network _network =
        Network("http://116.124.191.174:15011/memorydetail");
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
          'Memory Details',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: nowLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
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
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          jsonData[0]['memory_name'],
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '${jsonData[0]['memory_price']}원',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
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
