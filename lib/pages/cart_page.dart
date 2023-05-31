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
          icon:
              const Icon(Icons.arrow_back_ios_new_rounded, color: primaryColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text("C A R T",
            style: TextStyle(
                color: primaryColor,
                fontSize: 25,
                fontWeight: FontWeight.bold)),
      ),
      body: Column(
        children: [
          const Divider(
            thickness: 3,
            color: primaryColor,
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: Cart().getKeys().length,
              itemBuilder: (context, index) {
                return MenuItemWidget(
                    menuItem:
                        Menu().getMenuItemWithName(Cart().getKeys()[index]),
                    cartMode: true,
                    cartAmount: Cart().getItemAmount(Cart().getKeys()[index]),
                    onPress: () {
                      setState(() {
                        Cart().reduceItemAmount(Cart().getKeys()[index]);
                        if (Cart().getItemAmount(Cart().getKeys()[index]) ==
                            0) {
                          Cart().getKeys().removeAt(index);
                        }
                      });
                    });
              },
            ),
          ),
          const Divider(
            thickness: 3,
            color: primaryColor,
          ),
          SizedBox(
            height: 80,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                children: [
                  const Text("TOTAL: ",
                      style: TextStyle(
                          color: primaryColor,
                          fontSize: 26,
                          fontWeight: FontWeight.w900)),
                  Text("${Cart().cartTotal().toStringAsFixed(2)}€",
                      style: const TextStyle(
                          color: primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w500)),
                  Expanded(child: Container()),
                  TextButton(
                    onPressed: () {
                      if (Cart().getKeys().isNotEmpty) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const QRCodeScanner()));
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content:
                              Text("Please add items to your cart to order!"),
                          backgroundColor: dangerColor,
                        ));
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(primaryColor),
                      overlayColor:
                          MaterialStateProperty.resolveWith<Color?>((states) {
                        if (states.contains(MaterialState.pressed)) {
                          return subColor2;
                        }
                        return null;
                      }),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("ORDER",
                          style: TextStyle(
                              color: secondaryColor,
                              fontSize: 22,
                              fontWeight: FontWeight.w900)),
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
