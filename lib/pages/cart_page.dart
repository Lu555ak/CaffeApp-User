import 'package:caffe_app_user/utility/app_localizations.dart';
import 'package:flutter/material.dart';

import 'package:caffe_app_user/utility/constants.dart';

import 'package:caffe_app_user/custom/menu_item.dart';

import 'package:caffe_app_user/pages/qr_scanner.dart';

import 'package:caffe_app_user/models/menu_model.dart';
import 'package:caffe_app_user/models/cart_model.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: primaryColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(AppLocalizations.of(context).translate("cart_text"),
            style: const TextStyle(color: subColor2, fontSize: 25, fontWeight: FontWeight.bold)),
      ),
      body: Column(
        children: [
          const Divider(
            thickness: 3,
            color: subColor2,
          ),
          Expanded(
            child: Column(
              children: [
                ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: Cart().getKeys().length,
                  itemBuilder: (context, index) {
                    return MenuItemWidget(
                        menuItem: Menu().getMenuItemWithName(Cart().getKeys()[index]),
                        cartMode: true,
                        cartAmount: Cart().getItemAmount(Cart().getKeys()[index]),
                        onPress: () {
                          setState(() {
                            Cart().reduceItemAmount(Cart().getKeys()[index]);
                            if (Cart().getItemAmount(Cart().getKeys()[index]) == 0) {
                              Cart().getKeys().removeAt(index);
                            }
                          });
                        });
                  },
                ),
                (Cart().getCreditsItemLength() > 0)
                    ? Text(AppLocalizations.of(context).translate("credits_items_text"),
                        style: const TextStyle(color: primaryColor, fontSize: 22, fontWeight: FontWeight.bold))
                    : Container(),
                ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: Cart().getCreditsKeys().length,
                  itemBuilder: (context, index) {
                    return MenuItemWidget(
                        menuItem: Menu().getMenuItemWithName(Cart().getCreditsKeys()[index]),
                        cartMode: true,
                        cartAmount: Cart().getCreditsItemAmount(Cart().getCreditsKeys()[index]),
                        onPress: () {
                          setState(() {
                            Cart().updateCredits(Cart().credits.value +
                                Menu().getMenuItemWithName(Cart().getCreditsKeys()[index]).getCreditPrice);
                            Cart().reduceCreditsItemAmount(
                                Menu().getMenuItemWithName(Cart().getCreditsKeys()[index]).getName);
                          });
                        });
                  },
                ),
              ],
            ),
          ),
          const Divider(
            thickness: 3,
            color: subColor2,
          ),
          SizedBox(
            height: 80,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                children: [
                  Text(AppLocalizations.of(context).translate("total_text"),
                      style: const TextStyle(color: subColor2, fontSize: 26, fontWeight: FontWeight.w900)),
                  Text("${Cart().cartTotal().toStringAsFixed(2)}€",
                      style: const TextStyle(color: subColor2, fontSize: 18, fontWeight: FontWeight.w500)),
                  Expanded(child: Container()),
                  TextButton(
                    onPressed: () {
                      if (Cart().getKeys().isNotEmpty || Cart().getCreditsKeys().isNotEmpty) {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const QRCodeScanner()));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(AppLocalizations.of(context).translate("please_add_items_to_cart_text")),
                          backgroundColor: dangerColor,
                        ));
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(primaryColor),
                      overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
                        if (states.contains(MaterialState.pressed)) {
                          return subColor2;
                        }
                        return null;
                      }),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(AppLocalizations.of(context).translate("order_text"),
                          style: const TextStyle(color: secondaryColor, fontSize: 22, fontWeight: FontWeight.w900)),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
