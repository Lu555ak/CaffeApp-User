import 'package:flutter/material.dart';

import 'package:caffe_app_user/utility/constants.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  State<MyAppBar> createState() => _MyAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(100);
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: secondaryColor,
      toolbarHeight: 100,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25)),
          boxShadow: [
            BoxShadow(
              color: subColor2.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(-4, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListTile(
              leading: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.login_rounded,
                    color: secondaryColor,
                    size: 35,
                  )),
              title: const Text(
                "Logged in as ",
                style: TextStyle(color: secondaryColor, fontSize: 20),
              ),
              subtitle: const Text("User",
                  style: TextStyle(
                      color: secondaryColor,
                      fontSize: 25,
                      fontWeight: FontWeight.bold)),
              horizontalTitleGap: 20,
              trailing: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.shopping_bag_rounded,
                      color: secondaryColor,
                      size: 35,
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
