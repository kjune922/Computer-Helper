import 'package:flutter/material.dart';

import '../globals.dart';



class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('여기 구매자들의 프로필'),
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
