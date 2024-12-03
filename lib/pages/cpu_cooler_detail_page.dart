import 'package:flutter/material.dart';
import '../globals.dart';
import '../Network.dart';
import 'shoppingcart_page.dart';

class CpuCoolerDetailPage extends StatefulWidget {
  const CpuCoolerDetailPage({Key? key}) : super(key: key);

  @override
  State<CpuCoolerDetailPage> createState() => _CpuCoolerDetailPageState();
}

class _CpuCoolerDetailPageState extends State<CpuCoolerDetailPage> {
  List<dynamic> jsonData = [];
  bool nowLoading = true;

  @override
  void initState() {
    super.initState();
    getCpuCoolerData(productName!);
  }

  void getCpuCoolerData(String name) async {
    final Network _network =
        Network("http://116.124.191.174:15011/cpu_coolerdetail");
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
          'CPU Cooler Details',
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
                          jsonData[0]['cpu_cooler_name'],
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '${jsonData[0]['cpu_cooler_price']}원',
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
