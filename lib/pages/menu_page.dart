import 'package:caffe_app_user/custom/discount_component.dart';
import 'package:caffe_app_user/custom/circle_icon_button.dart';
import 'package:flutter/material.dart';

import 'package:caffe_app_user/utility/constants.dart';

import 'package:caffe_app_user/models/menu_model.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final TextEditingController _searchBarController = TextEditingController();

  bool searchBarFilter(String input) {
    String searchBarText =
        _searchBarController.text.replaceAll(RegExp(r"\s+"), "").toLowerCase();
    String itemName = input.replaceAll(RegExp(r"\s+"), "").toLowerCase();

    if (searchBarText.isEmpty || itemName.contains(searchBarText)) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15),
            child: TextField(
              controller: _searchBarController,
              decoration: const InputDecoration(
                labelText: "Search",
                hintText: "Search",
                prefixIcon: Icon(Icons.search),
                prefixIconColor: primaryColor,
                labelStyle: TextStyle(color: primaryColor),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: subColor2),
                    borderRadius: BorderRadius.all(Radius.circular(15.0))),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 4, color: subColor2),
                    borderRadius: BorderRadius.all(Radius.circular(15.0))),
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: Menu().getMenuLength,
                itemBuilder: ((context, index) {
                  if (searchBarFilter(Menu().getMenuItemAt(index).getName)) {
                    return ListTile(
                        title: Row(
                          children: [
                            Text(
                              Menu().getMenuItemAt(index).getName.toUpperCase(),
                              style: const TextStyle(
                                  color: primaryColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900),
                            ),
                            Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: DiscountComponent(
                                    discount: Menu()
                                        .getMenuItemAt(index)
                                        .getDiscount))
                          ],
                        ),
                        subtitle: (Menu().getMenuItemAt(index).getDiscount == 0)
                            ? Text(
                                "${Menu().getMenuItemAt(index).getPrice}€",
                                style: const TextStyle(
                                    color: primaryColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400),
                              )
                            : Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                      "${Menu().getMenuItemAt(index).getPrice}€",
                                      style: const TextStyle(
                                          color: primaryColor,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          decoration:
                                              TextDecoration.lineThrough,
                                          decorationThickness: 3)),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                        "${Menu().getMenuItemAt(index).getPriceDiscount.toStringAsFixed(2)}€",
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
                            (Menu().getMenuItemAt(index).getFeatured)
                                ? const Icon(Icons.star)
                                : Container(),
                            CircleIconButton(
                              iconData: Icons.add,
                              onPress: () {},
                            )
                          ],
                        ));
                  } else {
                    return Container();
                  }
                })),
          )
        ],
      ),
    );
  }
}
