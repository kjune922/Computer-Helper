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
            return _usercard(
              child: jsonData[index],
              onDataUpdated: getdata,
            );
          }),
      floatingActionButton: Align(
        alignment: Alignment.bottomRight,
        child: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                TextEditingController textController1 = TextEditingController();
                TextEditingController textController2 = TextEditingController();
                TextEditingController textController3 = TextEditingController();

                return AlertDialog(
                  title: Text('생성 정보 입력'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: textController1,
                        decoration: InputDecoration(
                          labelText: 'id입력',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 16),
                      TextField(
                        controller: textController2,
                        decoration: InputDecoration(
                          labelText: '비밀번호 입력',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 16),
                      TextField(
                        controller: textController3,
                        decoration: InputDecoration(
                          labelText: '구매자,관리자,판매자',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {//생성버튼
                        if(!textController1.text.isEmpty && !textController2.text.isEmpty){
                          Network _masterusercrete = Network('http://116.124.191.174:15011/createuser');
                          _masterusercrete.createuser(textController1.text, textController2.text, textController3.text);
                          setState(() {
                            getdata();
                          });
                          Navigator.pop(context);
                        }else{
                          showDialog(
                              context: context,
                              builder: (context){
                                return AlertDialog(
                                  title: Text('아이디와 비번을 써주세요'),
                                  actions: [
                                    TextButton(onPressed: (){
                                      Navigator.pop(context);
                                    }, child: Text('확인'))
                                  ],
                                );
                              }
                              );
                        }

                      },
                      child: Text(
                        '생성',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // 팝업 닫기
                      },
                      child: Text('취소'),
                    ),
                  ],
                );
              },
            );
          },
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

class _productcard extends StatelessWidget {//상품 관리
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
          title: Text(child["${where}_name"] ?? "이름 없음"),
          subtitle: Text("가격: ${child["${where}_price"] ?? 0}원"),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {//상품수정

                },
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {//상품삭제

                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _usercard extends StatefulWidget {//유저관리
  final Map<String, dynamic> child;
  final VoidCallback onDataUpdated;

  _usercard({required this.child, required this.onDataUpdated});

  @override
  State<_usercard> createState() => _usercardState();
}

class _usercardState extends State<_usercard> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 8.0),
        child: ListTile(
          title: Text(widget.child["id"] ?? "이름 없음"),
          subtitle: Column(
            children: [
              Text("비번: ${widget.child['pw'] ?? '없음'}"),
              Text('등급: ${widget.child['level'] ?? '없음'}'),
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {//유저수정

                },
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {//유저삭제
                  String user = widget.child['id'];
                  String user2 =widget.child['pw'];
                  final Network _network = Network("http://116.124.191.174:15011/userdel");
                  showDialog(
                    context: context,
                    builder: (context) {
                      TextEditingController textController1 = TextEditingController();
                      TextEditingController textController2 = TextEditingController();

                      return AlertDialog(
                        title: Text('삭제 정보 입력'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextField(
                              controller: textController1,
                              decoration: InputDecoration(
                                labelText: 'id입력',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            SizedBox(height: 16), // 간격 추가ㄴ
                            TextField(
                              controller: textController2,
                              decoration: InputDecoration(
                                labelText: '비밀번호 입력',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {//삭제 눌렀을때
                              if(textController1.text == widget.child['id'] && textController2.text == widget.child['pw']){
                                _network.updatedb(user, user2);
                                widget.onDataUpdated();
                                Navigator.pop(context);
                              }else{
                                print('비번다름');
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context){
                                      return AlertDialog(
                                        title: Text('아이디 비번이 다르다'),
                                        actions: [
                                          TextButton(onPressed: (){
                                            Navigator.pop(context);
                                          }, child: Text('확인'))
                                        ],
                                      );
                                    },
                                );
                              }
                          },
                            child: Text(
                              '삭제',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // 팝업 닫기
                            },
                            child: Text('취소'),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
