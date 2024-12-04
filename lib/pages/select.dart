import 'package:com_recipe/globals.dart';
import 'package:flutter/material.dart';

class SelectPage extends StatefulWidget {
  const SelectPage({super.key});

  @override
  State<SelectPage> createState() => _SelectPageState();
}

class _SelectPageState extends State<SelectPage> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final buttonSize = screenWidth * 0.4;

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: screenHeight * 0.3,),
            Text(
                "나는 컴퓨터?",
                style: TextStyle(
                  fontSize: 40,
                ),
            ),
            SizedBox(height: screenHeight * 0.1,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {//초보자 버튼
                    isBeginner = true;
                    ScaffoldMessenger.of(context).clearSnackBars();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          '초보자를 선택하셨습니다',
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        ),
                        duration: Duration(seconds: 2), // 알림 지속 시간
                      ),
                    );
                    Navigator.pop(context);
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
                    isBeginner = false;
                    ScaffoldMessenger.of(context).clearSnackBars();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            '숙련자를 선택하셨습니다',
                            style: TextStyle(
                              fontSize: 25,
                            ),
                        ),
                        duration: Duration(seconds: 2), // 알림 지속 시간
                      ),
                    );
                    Navigator.pop(context);
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
}

