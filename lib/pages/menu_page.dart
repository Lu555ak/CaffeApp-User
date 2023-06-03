import 'package:caffe_app_user/custom/menu_item.dart';
import 'package:caffe_app_user/custom/circle_icon_button.dart';
import 'package:caffe_app_user/custom/no_data_widget.dart';
import 'package:caffe_app_user/utility/app_localizations.dart';
import 'package:flutter/material.dart';

import 'package:caffe_app_user/utility/constants.dart';

import 'package:caffe_app_user/models/menu_model.dart';
import 'package:caffe_app_user/models/cart_model.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final TextEditingController _searchBarController = TextEditingController();

  bool searchBarFilter(String input) {
    String searchBarText = _searchBarController.text.replaceAll(RegExp(r"\s+"), "").toLowerCase();
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
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context).translate("search_text"),
                hintText: AppLocalizations.of(context).translate("search_text"),
                prefixIcon: const Icon(Icons.search),
                prefixIconColor: subColor2,
                labelStyle: const TextStyle(color: subColor2),
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: subColor2),
                    borderRadius: BorderRadius.all(Radius.circular(15.0))),
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(width: 4, color: subColor2),
                    borderRadius: BorderRadius.all(Radius.circular(15.0))),
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),
          Expanded(
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
                    if (Menu().getMenuLength > 0) {
                      return ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: Menu().getMenuLength,
                          itemBuilder: ((context, index) {
                            if (searchBarFilter(Menu().getMenuItemAt(index).getName)) {
                              return MenuItemWidget(
                                  menuItem: Menu().getMenuItemAt(index),
                                  onPress: () {
                                    _addToCart(index);
                                  });
                            } else {
                              return Container();
                            }
                          }));
                    } else {
                      return const NoDataWidget();
                    }
                }
              },
            ),
          )
        ],
      ),
    );
  }

  void _addToCart(int index) {
    int itemAmount = 0;

    showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateInner) {
            return Padding(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        AppLocalizations.of(context).translate("add_text") +
                            Menu().getMenuItemAt(index).getName.toUpperCase() +
                            AppLocalizations.of(context).translate("to_cart_text"),
                        style: const TextStyle(color: subColor2, fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: SizedBox(
                            height: 50,
                            child: Row(
                              children: [
                                Flexible(
                                  flex: 2,
                                  child: Container(),
                                ),
                                Flexible(
                                    flex: 1,
                                    child: CircleIconButton(
                                      iconData: Icons.remove,
                                      pressColor: secondaryColor,
                                      onPress: () {
                                        setStateInner(() {
                                          (itemAmount > 0) ? itemAmount-- : null;
                                        });
                                      },
                                    )),
                                Flexible(
                                    flex: 1,
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        itemAmount.toString(),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            color: primaryColor, fontSize: 25, fontWeight: FontWeight.w700),
                                      ),
                                    )),
                                Flexible(
                                    flex: 1,
                                    child: CircleIconButton(
                                      iconData: Icons.add,
                                      pressColor: secondaryColor,
                                      onPress: () {
                                        setStateInner(() {
                                          itemAmount++;
                                        });
                                      },
                                    )),
                                Flexible(
                                  flex: 2,
                                  child: Container(),
                                ),
                              ],
                            )),
                      ),
                      SizedBox(
                        height: 25,
                        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                          Text(
                            AppLocalizations.of(context).translate("total_text"),
                            style: const TextStyle(color: subColor2, fontSize: 18, fontWeight: FontWeight.w700),
                          ),
                          Text(
                            "${calculateMultiItemCost(itemAmount, index).toStringAsFixed(2)}€",
                            style: const TextStyle(color: subColor2, fontSize: 18, fontWeight: FontWeight.w400),
                          )
                        ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(primaryColor),
                            ),
                            onPressed: () {
                              Cart().addItem(Menu().getMenuItemAt(index).getName, itemAmount);
                              Navigator.pop(context);
                            },
                            child: Text(AppLocalizations.of(context).translate("add_text_button"))),
                      ),
                    ],
                  ),
                ));
          },
        );
      },
    );
  }

  double calculateMultiItemCost(int amount, int index) {
    if (Menu().getMenuItemAt(index).getDiscount > 0) {
      return amount * Menu().getMenuItemAt(index).getPriceDiscount;
    } else {
      return amount * Menu().getMenuItemAt(index).getPrice;
    }
  }
}
