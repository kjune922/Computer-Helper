import 'package:flutter/material.dart';
import '../globals.dart';
import '../Network.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Network changebegin = Network('http://116.124.191.174:15011/changeuserbool');

  String beginOrNot = '';

  @override
  void initState() {
    super.initState();
    if (isBeginner) {
      beginOrNot = '컴알못';
    } else {
      beginOrNot = '컴잘알';
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final buttonSize = screenWidth * 0.4;

    return Scaffold(
      backgroundColor: Colors.grey[100],
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
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('로그아웃 하시겠습니까?'),
                    actions: [
                      TextButton(
                          onPressed: () {
                            registeredUsername = null;
                            registeredUserLevel = null;
                            Navigator.pushReplacementNamed(context, '/');
                          },
                          child: Text('로그아웃')),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('취소'))
                    ],
                  );
                },
              );
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 상단 프로필 카드
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 8,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Container(
                        child: CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.grey[300],
                          child: Icon(
                            Icons.person,
                            size: 40,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${registeredUsername}님 안녕하세요!',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            beginOrNot,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.green,
                            ),
                          ),
                        ],
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
                  backgroundColor: const Color.fromARGB(255, 95, 111, 138),
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  minimumSize: Size(double.infinity, 48),
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
                  backgroundColor: const Color.fromARGB(255, 95, 111, 138),
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

              SizedBox(height: 24),

              // 초보자/숙련자 버튼
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      changebegin.updatedb(registeredUsername!, '1');
                      setState(() {
                        isBeginner = true;
                        beginOrNot = '컴알못';
                      });
                      ScaffoldMessenger.of(context).clearSnackBars();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            '초보자로 변경하셨습니다',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    },
                    child: Container(
                      width: buttonSize,
                      height: buttonSize,
                      decoration: BoxDecoration(
                        color: Colors.lightBlue[200],
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          '초보자',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: buttonSize * 0.2,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.05),
                  GestureDetector(
                    onTap: () {
                      changebegin.updatedb(registeredUsername!, '0');
                      setState(() {
                        isBeginner = false;
                        beginOrNot = '컴잘알';
                      });
                      ScaffoldMessenger.of(context).clearSnackBars();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            '숙련자로 변경하셨습니다',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    },
                    child: Container(
                      width: buttonSize,
                      height: buttonSize,
                      decoration: BoxDecoration(
                        color: Colors.orange[200],
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          '숙련자',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: buttonSize * 0.2,
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
      ),
    );
  }

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
                final Network _network =
                    Network("http://116.124.191.174:15011/usernagam");
                await _network.updatedb(user!, '');

                registeredUsername = null;
                registeredPassword = null;
                registeredUserLevel = null;
                Navigator.pushReplacementNamed(context, '/');
              },
              child: Text(
                '탈퇴',
                style: TextStyle(color: Colors.red),
              ),
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
