import 'package:flutter/material.dart';

import 'package:caffe_app_user/utility/constants.dart';

import 'package:caffe_app_user/custom/bottom_nav_bar.dart';
import 'package:caffe_app_user/custom/app_bar.dart';

import 'package:caffe_app_user/pages/home_page.dart';
import 'package:caffe_app_user/pages/menu_page.dart';
import 'package:caffe_app_user/pages/loyalty_page.dart';
import 'package:caffe_app_user/pages/quiz_page.dart';
import 'package:caffe_app_user/pages/cart_page.dart';

import 'package:caffe_app_user/auth/auth.dart';
import 'package:caffe_app_user/models/menu_model.dart';

class ManagerPage extends StatefulWidget {
  const ManagerPage({super.key});

  @override
  State<ManagerPage> createState() => _ManagerPageState();
}

class _ManagerPageState extends State<ManagerPage> {
  @override
  initState() {
    setState(() {
      Menu().loadFromDatabase();
    });
    super.initState();
  }

  // Page navigation
  int _selectedIndex = 0;
  navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Pages
  final List<Widget> _pages = [
    const HomePage(),
    const MenuPage(),
    const LoyaltyPage(),
    const QuizPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: secondaryColor,
        appBar: MyAppBar(
          onTapCart: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const CartPage()));
          },
          onTapLogout: () {
            Auth().signOut();
          },
          username: Auth().currentUser?.displayName ?? "User",
        ),
        body: _pages[_selectedIndex],
        bottomNavigationBar: MyBottomNavBar(
          onTabChange: (index) => navigateBottomBar(index),
        ),
      ),
    );
  }
}
