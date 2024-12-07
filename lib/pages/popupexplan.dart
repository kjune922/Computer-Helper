import 'package:flutter/material.dart';

Future<void> showSocketPopup({required BuildContext context}) {
  String imageUrl ="assets/images/cpu_socket_explan.jpg";
  String description ="소켓이란 CPU가 메인보드에 장착되는 인터페이스를 의미합니다.";
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              imageUrl,
              height: 150,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 10),
            Text(
              description,
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("닫기"),
          ),
        ],
      );
    },
  );
}

Future<void> showPowerPopup({required BuildContext context}) {
  String imageUrl ="assets/images/cpu_power_explan.png";
  String description ="파워는 CPU가 소모하는 최대 전력을 나타냅니다.";
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              imageUrl,
              height: 150,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 10),
            Text(
              description,
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("닫기"),
          ),
        ],
      );
    },
  );
}

Future<void> showScorePopup({required BuildContext context}) {
  String imageUrl ="assets/images/cpu_score_explan.png";
  String description ="성능 점수는 CPU의 처리 성능을 수치로 나타내며, 높을수록 좋은 CPU입니다. 벤치마크 테스트를 통해 측정됩니다.";
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              imageUrl,
              height: 150,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 10),
            Text(
              description,
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("닫기"),
          ),
        ],
      );
    },
  );
}

Future<void> showBottleneckPopup({required BuildContext context}) {
  String imageUrl ="assets/images/Bottleneck_explan.png";
  String description ="부품의 성능 차이가 너무 클 때 나타나는 현상입니다. 한 부품이 성능이 너무 낮으면 그 부품 하나가 전체 흐름을 막을 수 있습니다. ";
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              imageUrl,
              height: 150,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 10),
            Text(
              description,
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("닫기"),
          ),
        ],
      );
    },
  );
}
