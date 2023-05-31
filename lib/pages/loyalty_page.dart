import 'package:caffe_app_user/auth/auth.dart';
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
  Future<Map<dynamic, dynamic>> fetchCredits() async {
    var value = await FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: Auth().currentUser?.uid)
        .limit(1)
        .get();
    return value.docs.first.data();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            FutureBuilder(
              future: fetchCredits(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    Map<dynamic, dynamic> data =
                        snapshot.data as Map<dynamic, dynamic>;
                    return CreditsDisplay(creditsAmount: data["credits"]);
                  }
                } else {
                  return const CreditsDisplay(
                    creditsAmount: 0,
                  );
                }
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
                      item: Menu().creditMenuItems()[index]);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
