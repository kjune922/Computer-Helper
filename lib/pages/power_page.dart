import 'package:flutter/material.dart';
import 'power_detail_page.dart';
import 'custom_bottom_nav_bar.dart';
import '../globals.dart';
import '../Network.dart';

class PowerPage extends StatefulWidget {
  final String whatserch;
  final int power;
  PowerPage({this.whatserch ='',this.power=-1});//검색하려면 isserch true

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
    if(widget.whatserch == 'power'){
      final Network _network = Network("http://116.124.191.174:15011/powerserchup");
      jsonData = await _network.scoreserch(widget.power,0);
      datacount = jsonData.length;
    }else{
      final Network _network = Network("http://116.124.191.174:15011/power");
      jsonData = await _network.getJsonData();
      datacount = jsonData.length;
    }
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
        globalproductName = data['power_name'];
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
                      final Network _powernetwork = Network("http://116.124.191.174:15011/shoppoweradd");//192.168.1.2:15011//116.124.191.174:15011
                      _powernetwork.updatedb(registeredUsername!,data['power_name']);
                    }
                    ScaffoldMessenger.of(context).clearSnackBars();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          '파워 장바구니에 추가되었습니다',
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
