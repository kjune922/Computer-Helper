import 'package:com_recipe/Network.dart';
import 'package:flutter/material.dart';
import '../globals.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Network changebegin = Network('http://116.124.191.174:15011/changeuserbool');

  String beginOrNot ='';
  @override
  void initState() {
    super.initState();
    if(isBeginner){
      beginOrNot ='컴알못';
    }else{
      beginOrNot ='컴잘알';
    }
  }
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final buttonSize = screenWidth * 0.4;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${registeredUsername}님의 프로필',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(context: context, builder: (context){
                return AlertDialog(
                  title: Text('로그아웃 하시겠습니까?'),
                  actions: [
                    TextButton(onPressed: (){
                      registeredUsername = null;
                      registeredUserLevel = null;
                      Navigator.pushReplacementNamed(context, '/');
                    }, child: Text('로그아웃')),
                    TextButton(onPressed: (){Navigator.pop(context);}, child: Text('취소'))
                  ],
                );
              });
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 닉네임 카드
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // 아이템을 양 끝에 배치
                  children: [
                    // 왼쪽: 아이콘과 텍스트
                    Row(
                      children: [
                        Icon(
                          Icons.person,
                          color: Colors.blueAccent,
                          size: 40,
                        ),
                        SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '아이디',
                              style: TextStyle(fontSize: 18, color: Colors.grey),
                            ),
                            Text(
                              registeredUsername ?? '알 수 없음',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    // 오른쪽: 숙련자 / 초보자 텍스트
                    Text(
                      beginOrNot, // 또는 '초보자'로 변경 가능
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green, // 색상은 필요에 따라 변경
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 24),

            // 비밀번호 변경 버튼
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/reset_password');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                minimumSize: Size(double.infinity, 48), // 버튼 너비를 화면 가득 차게 설정
              ),
              child: Text(
                '비밀번호 변경',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            SizedBox(height: 16),

            // 계정 탈퇴 버튼
            ElevatedButton(
              onPressed: () {
                _showDeleteAccountDialog(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                minimumSize: Size(double.infinity, 48),
              ),
              child: Text(
                '계정 탈퇴',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {//초보자 버튼
                    changebegin.updatedb(registeredUsername!, '1');
                    setState(() {
                      isBeginner = true;
                      beginOrNot ='컴알못';
                    });
                    ScaffoldMessenger.of(context).clearSnackBars();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          '초보자로 변경하셨습니다',
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        ),
                        duration: Duration(seconds: 1), // 알림 지속 시간
                      ),
                    );
                  },
                  child: Container(
                    width: buttonSize,
                    height: buttonSize,
                    decoration: BoxDecoration(
                      color: Colors.lightBlue,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '초보자',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: buttonSize * 0.2, // 버튼 크기에 비례한 글꼴 크기
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: screenWidth * 0.05), // 버튼 간격 (화면 너비의 5%)
                GestureDetector(
                  onTap: () {//숙련자 버튼
                    changebegin.updatedb(registeredUsername!, '0');
                    setState(() {
                      isBeginner = false;
                      beginOrNot ='컴잘알';
                    });
                    ScaffoldMessenger.of(context).clearSnackBars();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          '숙련자로 변경하섰습니다',
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        ),
                        duration: Duration(seconds: 1), // 알림 지속 시간
                      ),
                    );
                  },
                  child: Container(
                    width: buttonSize,
                    height: buttonSize,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '숙련자',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: buttonSize * 0.2, // 버튼 크기에 비례한 글꼴 크기
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // 계정 탈퇴 확인 팝업 함수
  void _showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            '계정 탈퇴',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Text('정말로 계정을 탈퇴하시겠습니까? 이 작업은 되돌릴 수 없습니다.'),
          actions: [
            TextButton(
              onPressed: () async {
                String? user = registeredUsername;
                final Network _network = Network("http://116.124.191.174:15011/usernagam");
                await _network.updatedb(user!,'');

                registeredUsername  = null;
                registeredPassword = null;
                registeredUserLevel = null;
                Navigator.pushReplacementNamed(context, '/');
              },
              child: Text('탈퇴',
              style: TextStyle(color: Colors.red),),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('취소'),
            ),
          ],
        );
      },
    );
  }
}
