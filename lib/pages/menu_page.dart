import 'package:caffe_app_user/custom/discount_component.dart';
import 'package:flutter/material.dart';

import 'package:caffe_app_user/utility/constants.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  List<Map<String, dynamic>> items = [
    {"name": "ORANGE JUICE", "price": 2.0, "discount": 15},
    {"name": "HEINEKEN", "price": 3.0, "discount": 25},
    {"name": "COFFE", "price": 2.0, "discount": 0},
    {"name": "WATER", "price": 1.0, "discount": 100},
  ];

  TextEditingController searchBarController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: searchBarController,
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
            onChanged: (value) {},
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Row(
                    children: [
                      Text(
                        items[index]["name"].toString(),
                        style: const TextStyle(
                            color: primaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w900),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: DiscountComponent(
                            discount: items[index]["discount"],
                          ))
                    ],
                  ),
                  subtitle: Text(
                    "${items[index]["price"]}€",
                    style: const TextStyle(
                        color: primaryColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w400),
                  ),
                  trailing: ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(const CircleBorder()),
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.all(5)),
                      backgroundColor: MaterialStateProperty.all(primaryColor),
                      overlayColor:
                          MaterialStateProperty.resolveWith<Color?>((states) {
                        if (states.contains(MaterialState.pressed)) {
                          return subColor2;
                        }
                        return null;
                      }),
                    ),
                    child: const Icon(
                      Icons.add,
                      color: secondaryColor,
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
