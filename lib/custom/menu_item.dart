import 'package:caffe_app_user/custom/discount_component.dart';
import 'package:caffe_app_user/custom/circle_icon_button.dart';
import 'package:flutter/material.dart';

import 'package:caffe_app_user/utility/constants.dart';
import 'package:caffe_app_user/models/menu_model.dart';

class MenuItemWidget extends StatelessWidget {
  final int cartAmount;
  final bool cartMode;
  final MenuItem menuItem;
  final Function onPress;
  const MenuItemWidget(
      {super.key,
      required this.menuItem,
      required this.onPress,
      this.cartMode = false,
      this.cartAmount = 0});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Row(
          children: [
            Text(
              menuItem.getName.toUpperCase(),
              style: const TextStyle(
                  color: primaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w900),
            ),
            Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: DiscountComponent(discount: menuItem.getDiscount))
          ],
        ),
        subtitle: (menuItem.getDiscount == 0)
            ? Text(
                "${menuItem.getPrice}€",
                style: const TextStyle(
                    color: primaryColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w400),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("${menuItem.getPrice}€",
                      style: const TextStyle(
                          color: primaryColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          decoration: TextDecoration.lineThrough,
                          decorationThickness: 3)),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                        "${menuItem.getPriceDiscount.toStringAsFixed(2)}€",
                        style: const TextStyle(
                            color: dangerColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w500)),
                  )
                ],
              ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            (cartMode)
                ? Text(cartAmount.toString(),
                    style: const TextStyle(
                        color: primaryColor,
                        fontSize: 25,
                        fontWeight: FontWeight.w700))
                : ((menuItem.getFeatured)
                    ? const Icon(Icons.star)
                    : Container()),
            CircleIconButton(
              iconData: (cartMode) ? Icons.remove : Icons.add,
              onPress: () {
                onPress();
              },
            )
          ],
        ));
  }
}
