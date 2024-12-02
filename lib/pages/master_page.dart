import 'package:com_recipe/Network.dart';
import 'package:flutter/material.dart';
import '../globals.dart';

class MasterPage extends StatefulWidget {
  const MasterPage({super.key});

  @override
  State<MasterPage> createState() => _MasterPageState();
}

class _MasterPageState extends State<MasterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('관리자'),
        actions: [
          IconButton(
            onPressed: () {
              registeredUsername = null;
              registeredUserLevel = null;
              Navigator.pushNamed(context, '/');
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,MaterialPageRoute(builder: (_) => masterUser()));
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text('유저 관리', style: TextStyle(fontSize: 18)),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,MaterialPageRoute(builder: (_) => masterProduct()));
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text('상품 관리', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}

class masterUser extends StatefulWidget {
  const masterUser({super.key});

  @override
  State<masterUser> createState() => _masterUserState();
}
class _masterUserState extends State<masterUser> {

  List<dynamic> jsonData = [];
  int? datacount;
  bool nowLoading = true;

  @override
  void initState() {
    super.initState();
    getdata();
  }

  void getdata() async {
    final Network _network = Network("http://116.124.191.174:15011/member");
    jsonData = await _network.getJsonData();
    datacount = jsonData.length;
    setState(() {
      nowLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("유저관리"),
      ),
      body: nowLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: datacount,
              itemBuilder: (context,index){
            return _usercard(child: jsonData[index],);
          }),
      floatingActionButton: Align(
        alignment: Alignment.bottomRight,
        child: FloatingActionButton(
          onPressed: () {

          }, // 상품 추가 버튼 비움
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}


class masterProduct extends StatelessWidget {
  const masterProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('상품관리'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,MaterialPageRoute(builder: (context) => masterController(where: 'cpu')));
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text('cpu', style: TextStyle(fontSize: 18)),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,MaterialPageRoute(builder: (context) => masterController(where: 'graphics')));
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text('그래픽카드', style: TextStyle(fontSize: 18)),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,MaterialPageRoute(builder: (context) => masterController(where: 'mainboard')));
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text('메인보드', style: TextStyle(fontSize: 18)),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,MaterialPageRoute(builder: (context) => masterController(where: 'memory')));
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text('메모리', style: TextStyle(fontSize: 18)),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,MaterialPageRoute(builder: (context) => masterController(where: 'power')));
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text('파워', style: TextStyle(fontSize: 18)),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,MaterialPageRoute(builder: (context) => masterController(where: 'disk')));
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text('디스크', style: TextStyle(fontSize: 18)),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,MaterialPageRoute(builder: (context) => masterController(where: 'cpu_cooler')));
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text('cpu쿨러', style: TextStyle(fontSize: 18)),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,MaterialPageRoute(builder: (context) => masterController(where: 'computer_case')));
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text('케이스', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}

class masterController extends StatefulWidget {
  final String where;
  const masterController({super.key, required this.where});

  @override
  State<masterController> createState() => _masterControllerState();
}

class _masterControllerState extends State<masterController> {
  List<dynamic> jsonData = [];
  int? datacount;
  bool nowLoading = true;

  @override
  void initState() {
    super.initState();
    getdata();
  }

  void getdata() async {
    final Network _network = Network("http://116.124.191.174:15011/${widget.where}");
    jsonData = await _network.getJsonData();
    datacount = jsonData.length;
    print(datacount);
    setState(() {
      nowLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.where} 관리"),
      ),
      body: nowLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: datacount,
        itemBuilder: (context, index) {
          return _productcard(child: jsonData[index],where: widget.where,);
        },
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomRight,
        child: FloatingActionButton(
          onPressed: () {

          }, // 상품 추가 버튼 비움
          child: Icon(Icons.add),
        ),
      ),
    );

  }
}

class _productcard extends StatelessWidget {
  final Map<String, dynamic> child;
  final String where;
  _productcard({required this.child, required this.where});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 8.0),
        child: ListTile(
          title: Text(child["${where}_name"] ?? "이름 없음"), // null 체크 추가
          subtitle: Text("가격: ${child["${where}_price"] ?? 0}원"), // null 체크 추가
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  // 수정 버튼 비움
                },
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  // 삭제 버튼 비움
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _usercard extends StatelessWidget {
  final Map<String, dynamic> child;
  _usercard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 8.0),
        child: ListTile(
          title: Text(child["id"] ?? "이름 없음"), // null 체크 추가
          subtitle: Column(
            children: [
              Text("비번: ${child['pw'] ?? '없음'}"),
              Text('등급: ${child['level'] ?? '없음'}'),
            ],
          ), // null 체크 추가
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  // 수정 버튼 비움
                },
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  // 삭제 버튼 비움
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
