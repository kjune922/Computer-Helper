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
