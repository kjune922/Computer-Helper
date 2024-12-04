import 'package:flutter/material.dart';
import 'disk_detail_page.dart';
import 'custom_bottom_nav_bar.dart';
import '../globals.dart';
import '../Network.dart';

class DiskPage extends StatefulWidget {
  const DiskPage({Key? key}) : super(key: key);

  @override
  State<DiskPage> createState() => _DiskPageState();
}

class _DiskPageState extends State<DiskPage> {
  List<dynamic> jsonData = [];
  int? datacount;
  bool nowLoading = true;

  @override
  void initState() {
    super.initState();
    getDiskData();
  }

  void getDiskData() async {
    final Network _network = Network("http://116.124.191.174:15011/disk");
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
          'Disk Products',
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
        productName = data['disk_name'];
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DiskDetailPage(),
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
                data['disk_name'],
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                '${data['disk_price']}원',
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
                    if(registeredUsername == null){
                      Navigator.pushNamed(context, '/login');
                    }else{
                      final Network _disknetwork = Network("http://116.124.191.174:15011/shopdiskadd");//192.168.1.2:15011//116.124.191.174:15011
                      _disknetwork.updatedb(registeredUsername!,data['disk_name']);
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
