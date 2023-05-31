import 'package:caffe_app_user/auth/auth.dart';
import 'package:caffe_app_user/models/cart_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:caffe_app_user/utility/constants.dart';

import 'package:caffe_app_user/custom/credits_display.dart';
import 'package:caffe_app_user/custom/credits_shop_component.dart';

import 'package:caffe_app_user/models/menu_model.dart';

class LoyaltyPage extends StatefulWidget {
  const LoyaltyPage({super.key});

  @override
  State<LoyaltyPage> createState() => _LoyaltyPageState();
}

class _LoyaltyPageState extends State<LoyaltyPage> {
  @override
  void initState() {
    Cart().fetchCredits();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ValueListenableBuilder(
              valueListenable: Cart().credits,
              builder: (context, value, child) {
                return CreditsDisplay(
                  creditsAmount: value,
                );
              },
            ),
            const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 15.0, bottom: 5, top: 20),
                  child: Text("C R E D I T   S H O P",
                      style: TextStyle(
                          color: primaryColor,
                          fontSize: 24,
                          fontWeight: FontWeight.w900)),
                )),
            SizedBox(
              height: 175,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: Menu().creditMenuItems().length,
                itemBuilder: (context, index) {
                  return CreditsShopComponent(
                    item: Menu().creditMenuItems()[index],
                    onPress: () {
                      if (Cart().credits.value <
                          Menu().creditMenuItems()[index].getCreditPrice) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text(
                              "You do not have enough credits for this item!"),
                          backgroundColor: dangerColor,
                        ));
                      } else {
                        Cart().addCreditsItem(
                            Menu().creditMenuItems()[index].getName);
                        Cart().updateCredits(Cart().credits.value -
                            Menu().creditMenuItems()[index].getCreditPrice);
                      }
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
