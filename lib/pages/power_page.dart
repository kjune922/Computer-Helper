import 'package:flutter/material.dart';
import 'power_detail_page.dart';
import 'custom_bottom_nav_bar.dart';
import '../globals.dart';
import '../Network.dart';

class PowerPage extends StatefulWidget {
  const PowerPage({Key? key}) : super(key: key);

  @override
  State<PowerPage> createState() => _PowerPageState();
}

class _PowerPageState extends State<PowerPage> {
  List<dynamic> jsonData = [];
  int? datacount;
  bool nowLoading = true;

  @override
  void initState() {
    super.initState();
    getPowerData();
  }

  void getPowerData() async {
    final Network _network = Network("http://116.124.191.174:15011/power");
    jsonData = await _network.getJsonData();
    datacount = jsonData.length;
    setState(() {
      nowLoading = false;
    });
  }

  @override
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
          'Power Supply Products',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: nowLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
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
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 1,
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, Map<String, dynamic> data) {
    return GestureDetector(
      onTap: () {
        productName = data['power_name'];
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PowerDetailPage(),
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
                data['power_name'],
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                '${data['power_price']}원',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}