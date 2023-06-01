import 'package:caffe_app_user/custom/no_data_widget.dart';
import 'package:caffe_app_user/models/cart_model.dart';
import 'package:caffe_app_user/utility/app_localizations.dart';
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
            Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0, bottom: 5, top: 20),
                  child: Text(AppLocalizations.of(context).translate("credit_shop_text"),
                      style: const TextStyle(color: primaryColor, fontSize: 22, fontWeight: FontWeight.w900)),
                )),
            SizedBox(
              height: 175,
              child: FutureBuilder(
                future: Menu().loadFromDatabase(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return const Center(child: CircularProgressIndicator());
                    case ConnectionState.waiting:
                      return const Center(child: CircularProgressIndicator());
                    case ConnectionState.active:
                      return const Center(child: CircularProgressIndicator());
                    case ConnectionState.done:
                      if (Menu().creditMenuItems().isNotEmpty) {
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: Menu().creditMenuItems().length,
                          itemBuilder: (context, index) {
                            return CreditsShopComponent(
                              item: Menu().creditMenuItems()[index],
                              onPress: () {
                                if (Cart().credits.value < Menu().creditMenuItems()[index].getCreditPrice) {
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content:
                                        Text(AppLocalizations.of(context).translate("credit_shop_not_enough_credits")),
                                    backgroundColor: dangerColor,
                                  ));
                                } else {
                                  Cart().addCreditsItem(Menu().creditMenuItems()[index].getName);
                                  Cart().updateCredits(
                                      Cart().credits.value - Menu().creditMenuItems()[index].getCreditPrice);
                                }
                              },
                            );
                          },
                        );
                      } else {
                        return const NoDataWidget();
                      }
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
