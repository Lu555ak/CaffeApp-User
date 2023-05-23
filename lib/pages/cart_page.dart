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
  var cartKeys = Cart().getCart.keys.toList();

  double cartTotal() {
    double total = 0;
    for (var cartItem in cartKeys) {
      if (Menu().getMenuItemWithName(cartItem).getDiscount > 0) {
        total += Menu().getMenuItemWithName(cartItem).getPriceDiscount *
            Cart().getItemAmount(cartItem);
      } else {
        total += Menu().getMenuItemWithName(cartItem).getPrice *
            Cart().getItemAmount(cartItem);
      }
    }
    return total;
  }

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
              itemCount: cartKeys.length,
              itemBuilder: (context, index) {
                return MenuItemWidget(
                    menuItem: Menu().getMenuItemWithName(cartKeys[index]),
                    cartMode: true,
                    cartAmount: Cart().getItemAmount(cartKeys[index]),
                    onPress: () {
                      setState(() {
                        Cart().reduceItemAmount(cartKeys[index]);
                        if (Cart().getItemAmount(cartKeys[index]) == 0) {
                          cartKeys.removeAt(index);
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
                  Text("${cartTotal()}€",
                      style: const TextStyle(
                          color: primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w500)),
                  Expanded(child: Container()),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const QRCodeScanner()));
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
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
