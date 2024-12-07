import 'package:flutter/material.dart';

class WordPage extends StatelessWidget {
  final String label;
  final String value;

  const WordPage({required this.label, required this.value, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<String, String> descriptions = {
      "가로 길이": "케이스의 가로 길이는 그래픽카드 및 내부 부품 설치 공간에 영향을 미칩니다.",
      "높이": "케이스의 높이는 전체적인 크기와 부품 호환성에 중요한 요소입니다.",
      "세로 길이": "케이스의 세로 길이는 내부 부품 배치와 공간 효율성을 좌우합니다.",
      "쿨러 높이": "쿨러 높이는 CPU 쿨러 장착 가능 여부를 결정짓는 중요한 사양입니다."
    };

    return Scaffold(
      appBar: AppBar(
        title: Text(label),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "$label 설명",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              descriptions[label] ?? "설명이 없습니다.",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            Text(
              "값: $value",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
