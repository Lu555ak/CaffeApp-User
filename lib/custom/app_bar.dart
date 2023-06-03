import 'package:caffe_app_user/models/cart_model.dart';
import 'package:caffe_app_user/utility/app_localizations.dart';
import 'package:flutter/material.dart';

import 'package:caffe_app_user/utility/constants.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  final Function onTapCart;
  final Function onTapLogout;
  final String username;

  const MyAppBar({super.key, required this.onTapCart, required this.onTapLogout, this.username = "User"});

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
      backgroundColor: Colors.transparent,
      toolbarHeight: 100,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          color: subColor,
          borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(25), bottomRight: Radius.circular(25)),
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
                    color: subColor2,
                    size: 35,
                  )),
              title: Text(
                AppLocalizations.of(context).translate("logged_in_as_text"),
                style: const TextStyle(color: subColor2, fontSize: 20),
              ),
              subtitle: Text(widget.username,
                  style: const TextStyle(color: subColor2, fontSize: 25, fontWeight: FontWeight.bold)),
              horizontalTitleGap: 20,
              trailing: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    StreamBuilder(
                      stream: Cart().lastOrder?.onValue,
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.active:
                            if (snapshot.data!.snapshot.child("accepted").value == false) {
                              return const Center(
                                  child: Padding(
                                padding: EdgeInsets.only(top: 5.0),
                                child: SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    color: primaryColor,
                                  ),
                                ),
                              ));
                            } else if (snapshot.data!.snapshot.child("accepted").value == true) {
                              return const Padding(
                                padding: EdgeInsets.only(top: 8.0),
                                child: Icon(
                                  Icons.check_circle_outlined,
                                  color: successColor,
                                  size: 30,
                                ),
                              );
                            }
                            break;
                          default:
                            return Container();
                        }

                        return Container();
                      },
                    ),
                    IconButton(
                        onPressed: () {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            widget.onTapCart();
                          });
                        },
                        icon: const Icon(
                          Icons.shopping_bag_rounded,
                          color: primaryColor,
                          size: 35,
                        )),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
