import 'package:flutter/material.dart';
import 'shoppingcart_page.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;

  const CustomBottomNavBar({Key? key, required this.currentIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        // 각 탭을 클릭했을 때 해당 페이지로 이동
        if (index == 0) {
          Navigator.pushReplacementNamed(context, '/home');
        } else if (index == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const Shoppingcart()),
          );
        } else if (index == 2) {
          // 계정 페이지로 이동
          Navigator.pushNamed(context, '/profile');
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
