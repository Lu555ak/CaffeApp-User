import 'package:caffe_app_user/utility/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MyBottomNavBar extends StatelessWidget {
  final void Function(int)? onTabChange;

  const MyBottomNavBar({super.key, required this.onTabChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: GNav(
          onTabChange: (value) => onTabChange!(value),
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          activeColor: primaryColor,
          color: neutralColor,
          tabBorderRadius: 25,
          tabActiveBorder: Border.all(color: primaryColor, width: 4),
          tabs: const [
            GButton(
              icon: Icons.home_rounded,
              iconSize: 25,
              gap: 5,
              text: "Home",
            ),
            GButton(
              icon: Icons.menu_book_rounded,
              iconSize: 25,
              gap: 5,
              text: "Menu",
            ),
            GButton(
              icon: Icons.loyalty_rounded,
              iconSize: 25,
              gap: 5,
              text: "Loyalty",
            ),
            GButton(
              icon: Icons.quiz_rounded,
              iconSize: 25,
              gap: 5,
              text: "Quiz",
            ),
          ]),
    );
  }
}
