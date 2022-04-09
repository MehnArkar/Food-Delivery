import 'package:flutter/material.dart';
import 'package:food_delivery/page/account/account_page.dart';
import 'package:food_delivery/page/auth/sign_up_page.dart';
import 'package:food_delivery/page/cart/cart_history.dart';
import 'package:food_delivery/page/home/main_food_page.dart';
import 'package:food_delivery/utils/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  List pages = [
    const MainFoodPage(),
    SignUpPage(),
    const CartHistory(),
    const AccountPage()
  ];

  void onTapNav(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          onTap: onTapNav,
          currentIndex: selectedIndex,
          selectedItemColor: AppColors.mainColor,
          unselectedItemColor: Colors.amber,
          selectedFontSize: 0.0,
          unselectedFontSize: 0.0,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.history), label: 'History'),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart), label: 'Cart'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ]),
    );
  }
}
