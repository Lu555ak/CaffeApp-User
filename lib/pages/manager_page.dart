import 'package:flutter/material.dart';

import 'package:caffe_app_user/utility/constants.dart';

import 'package:caffe_app_user/custom/bottom_nav_bar.dart';
import 'package:caffe_app_user/custom/app_bar.dart';

import 'package:caffe_app_user/pages/home_page.dart';
import 'package:caffe_app_user/pages/menu_page.dart';
import 'package:caffe_app_user/pages/loyalty_page.dart';
import 'package:caffe_app_user/pages/quiz_page.dart';

class ManagerPage extends StatefulWidget {
  const ManagerPage({super.key});

  @override
  State<ManagerPage> createState() => _ManagerPageState();
}

class _ManagerPageState extends State<ManagerPage> {
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
        appBar: const MyAppBar(),
        body: _pages[_selectedIndex],
        bottomNavigationBar: MyBottomNavBar(
          onTabChange: (index) => navigateBottomBar(index),
        ),
      ),
    );
  }
}
