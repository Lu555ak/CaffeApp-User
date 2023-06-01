import 'package:caffe_app_user/custom/circle_icon_button.dart';
import 'package:caffe_app_user/utility/app_localizations.dart';
import 'package:flutter/material.dart';

import 'package:caffe_app_user/utility/constants.dart';

import 'package:caffe_app_user/models/menu_model.dart';

class CreditsShopComponent extends StatelessWidget {
  final MenuItem item;
  final Function onPress;

  const CreditsShopComponent(
      {super.key, required this.item, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, top: 10.0, bottom: 10.0),
      child: Container(
        width: 170,
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(25)),
          boxShadow: [
            BoxShadow(
              color: subColor2.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(-5, 5),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            Flexible(
                flex: 2,
                child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: const BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              item.getName,
                              style: const TextStyle(
                                  color: primaryColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          Expanded(
                            child: Container(),
                          ),
                        ],
                      ),
                    ))),
            Flexible(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              AppLocalizations.of(context)
                                  .translate("price_text"),
                              style: const TextStyle(
                                  color: secondaryColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: [
                                  Text(item.getCreditPrice.toString(),
                                      style: const TextStyle(
                                          color: shinyColor,
                                          fontSize: 22.5,
                                          fontWeight: FontWeight.w600)),
                                  const Icon(
                                    Icons.circle,
                                    color: shinyColor,
                                  )
                                ],
                              )),
                        ]),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: CircleIconButton(
                          onPress: () {
                            onPress();
                          },
                          iconColor: primaryColor,
                          iconData: Icons.add,
                          buttonColor: secondaryColor,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
