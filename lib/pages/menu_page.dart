import 'package:caffe_app_user/custom/discount_component.dart';
import 'package:flutter/material.dart';

import 'package:caffe_app_user/utility/constants.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  List<List<dynamic>> items = [
    ["ORANGE JUICE", 15],
    ["HEINEKEN", 25],
    ["COFFE", 50],
    ["WATER", 100]
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(height: 50, color: Colors.red),
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
                        items[index][0].toString(),
                        style: const TextStyle(
                            color: primaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w900),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: DiscountComponent(
                          discount: items[index][1],
                        ),
                      )
                    ],
                  ),
                  subtitle: const Text(
                    "25.0€",
                    style: TextStyle(
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
                          return secondaryColor;
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
