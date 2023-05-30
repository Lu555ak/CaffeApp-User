import 'package:flutter/material.dart';

import 'package:caffe_app_user/utility/constants.dart';

import 'package:caffe_app_user/custom/discount_component.dart';
import 'package:caffe_app_user/models/menu_model.dart';

class FeaturedComponent extends StatelessWidget {
  final MenuItem item;

  const FeaturedComponent({super.key, required this.item});

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
                          Align(
                              alignment: Alignment.bottomRight,
                              child: DiscountComponent(
                                discount: item.getDiscount,
                              )),
                        ],
                      ),
                    ))),
            Flexible(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: [
                  const Align(
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
                    child: (item.getDiscount > 0)
                        ? Text(
                            "${item.getPrice.toStringAsFixed(2)}€",
                            style: const TextStyle(
                                color: secondaryColor,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                decoration: TextDecoration.lineThrough,
                                decorationThickness: 3),
                          )
                        : Text(
                            "${item.getPrice.toStringAsFixed(2)}€",
                            style: const TextStyle(
                              color: secondaryColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                  ),
                  (item.getDiscount > 0)
                      ? const Divider(
                          color: secondaryColor,
                          thickness: 1,
                        )
                      : Container(),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: (item.getDiscount > 0)
                          ? Text(
                              "${item.getPriceDiscount.toStringAsFixed(2)}€",
                              style: const TextStyle(
                                color: dangerColor,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          : Container()),
                ]),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
