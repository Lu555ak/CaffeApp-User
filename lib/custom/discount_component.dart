import 'package:flutter/material.dart';

import 'package:caffe_app_user/utility/constants.dart';

class DiscountComponent extends StatelessWidget {
  final int discount;

  const DiscountComponent({super.key, this.discount = 0});

  @override
  Widget build(BuildContext context) {
    if (discount == 0) {
      return Container();
    }
    return Container(
      decoration: const BoxDecoration(
          color: subColor2, borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Text(
          (discount == 100) ? "Free" : "$discount% OFF",
          style: const TextStyle(
              color: secondaryColor, fontSize: 14, fontWeight: FontWeight.w900),
        ),
      ),
    );
  }
}
