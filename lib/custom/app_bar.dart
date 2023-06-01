import 'package:caffe_app_user/utility/app_localizations.dart';
import 'package:flutter/material.dart';

import 'package:caffe_app_user/utility/constants.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  final Function onTapCart;
  final Function onTapLogout;
  final String username;

  const MyAppBar(
      {super.key,
      required this.onTapCart,
      required this.onTapLogout,
      this.username = "User"});

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
                  onPressed: () {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      widget.onTapLogout();
                    });
                  },
                  icon: const Icon(
                    Icons.login_rounded,
                    color: secondaryColor,
                    size: 35,
                  )),
              title: Text(
                AppLocalizations.of(context).translate("logged_in_as_text"),
                style: const TextStyle(color: secondaryColor, fontSize: 20),
              ),
              subtitle: Text(widget.username,
                  style: const TextStyle(
                      color: secondaryColor,
                      fontSize: 25,
                      fontWeight: FontWeight.bold)),
              horizontalTitleGap: 20,
              trailing: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: IconButton(
                    onPressed: () {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        widget.onTapCart();
                      });
                    },
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
