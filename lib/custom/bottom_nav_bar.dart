import 'package:caffe_app_user/utility/app_localizations.dart';
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
          tabBorderRadius: 20,
          tabActiveBorder: Border.all(color: primaryColor, width: 4),
          tabs: [
            GButton(
              icon: Icons.home_rounded,
              iconSize: 25,
              gap: 5,
              text: AppLocalizations.of(context).translate("home_text"),
            ),
            GButton(
              icon: Icons.menu_book_rounded,
              iconSize: 25,
              gap: 5,
              text: AppLocalizations.of(context).translate("menu_text"),
            ),
            GButton(
              icon: Icons.loyalty_rounded,
              iconSize: 25,
              gap: 5,
              text: AppLocalizations.of(context).translate("loyalty_text"),
            ),
          ]),
    );
  }
}
