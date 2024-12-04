import 'package:flutter/material.dart';
import 'expertshoppingcart.dart';
import 'shoppingcart_page.dart';
import '../globals.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;

  const CustomBottomNavBar({Key? key, required this.currentIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        if (index == 0) {//홈눌렀을때
          Navigator.pushReplacementNamed(context, '/');
        } else if (index == 1) {// 카트눌렀을때
          if (registeredUsername == null) {
            Navigator.pushNamed(context, '/login');
          } else {
            if(isBeginner){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => Shoppingcart()),
              );
            }else{
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ExpertShoppingcart()),
              );
            }
          }
        } else if (index == 2) {// 프로필 눌렀을때
          if (registeredUsername == null) {
            Navigator.pushNamed(context, '/login');
          } else {
            if (registeredUserLevel == '관리자') {
              Navigator.pushNamed(context, '/master');
            } else if (registeredUserLevel == '판매자') {
              Navigator.pushNamed(context, '/seller');
            } else if (registeredUserLevel == '구매자') {
              Navigator.pushNamed(context, '/profile');
            }
          }
        }
      },
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 30), label: 'Home'),
        BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart, size: 30), label: 'Cart'),
        BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 30), label: 'Profile'),
      ],
    );
  }
}
