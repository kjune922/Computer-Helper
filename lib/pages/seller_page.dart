import 'package:flutter/material.dart';

import '../globals.dart';

class SellerPage extends StatefulWidget {
  const SellerPage({super.key});

  @override
  State<SellerPage> createState() => _SellerPageState();
}

class _SellerPageState extends State<SellerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('판매자'),actions: [
        IconButton(
            onPressed: (){
              registeredUsername = null;
              registeredUserLevel = null;
              Navigator.pushNamed(context, '/');
            },
            icon: Icon(Icons.logout))
      ],
      ),
    );
  }
}
