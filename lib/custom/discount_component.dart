import 'package:flutter/material.dart';

import 'package:caffe_app_user/utility/constants.dart';

class DiscountComponent extends StatelessWidget {
  final String item;
  final int discount;

  const DiscountComponent(
      {super.key, required this.item, required this.discount});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, top: 10.0, bottom: 10.0),
      child: Container(
        width: 150,
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
                              item,
                              style: const TextStyle(
                                  color: primaryColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          Expanded(
                            child: Container(),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              decoration: const BoxDecoration(
                                  color: subColor2,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  "$discount% OFF",
                                  style: const TextStyle(
                                      color: secondaryColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w900),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ))),
            Flexible(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: const [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Price:",
                      style: TextStyle(
                          color: secondaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "5.00€",
                      style: TextStyle(
                          color: dangerColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          decoration: TextDecoration.lineThrough),
                    ),
                  ),
                  Divider(
                    color: secondaryColor,
                    thickness: 1,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "3.50€",
                      style: TextStyle(
                        color: secondaryColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ]),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
