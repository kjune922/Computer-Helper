import 'package:flutter/material.dart';

class ExpertShoppingcart extends StatelessWidget {
  const ExpertShoppingcart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("컴잘알 장바구니"),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "숙련자용 장바구니입니다",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
