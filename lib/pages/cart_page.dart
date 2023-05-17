import 'package:flutter/material.dart';

import 'package:caffe_app_user/utility/constants.dart';

import 'package:caffe_app_user/custom/discount_component.dart';

import 'package:caffe_app_user/pages/qr_scanner.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Map<String, dynamic>> cart = [
    {"name": "ORANGE JUICE", "price": 2.0, "discount": 15, "amount": 4},
    {"name": "HEINEKEN", "price": 3.0, "discount": 25, "amount": 1},
    {"name": "COFFE", "price": 2.0, "discount": 0, "amount": 2},
    {"name": "WATER", "price": 1.0, "discount": 100, "amount": 3},
  ];

  double sumPrice() {
    double sum = 0;
    for (var item in cart) {
      sum += item["price"] * item["amount"];
    }
    return sum;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon:
              const Icon(Icons.arrow_back_ios_new_rounded, color: primaryColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text("C A R T",
            style: TextStyle(
                color: primaryColor,
                fontSize: 25,
                fontWeight: FontWeight.bold)),
      ),
      body: Column(
        children: [
          const Divider(
            thickness: 3,
            color: primaryColor,
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: cart.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Row(
                    children: [
                      Text(
                        cart[index]["name"].toString(),
                        style: const TextStyle(
                            color: primaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w900),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: DiscountComponent(
                            discount: cart[index]["discount"],
                          ))
                    ],
                  ),
                  subtitle: Text(
                    "${cart[index]["price"]}€",
                    style: const TextStyle(
                        color: primaryColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w400),
                  ),
                  trailing: FittedBox(
                    child: Row(
                      children: [
                        Text(cart[index]["amount"].toString(),
                            style: const TextStyle(
                                color: primaryColor,
                                fontSize: 21,
                                fontWeight: FontWeight.w500)),
                        ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            shape:
                                MaterialStateProperty.all(const CircleBorder()),
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.all(5)),
                            backgroundColor:
                                MaterialStateProperty.all(primaryColor),
                            overlayColor:
                                MaterialStateProperty.resolveWith<Color?>(
                                    (states) {
                              if (states.contains(MaterialState.pressed)) {
                                return subColor2;
                              }
                              return null;
                            }),
                          ),
                          child: const Icon(
                            Icons.remove,
                            color: secondaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const Divider(
            thickness: 3,
            color: primaryColor,
          ),
          SizedBox(
            height: 80,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                children: [
                  const Text("TOTAL: ",
                      style: TextStyle(
                          color: primaryColor,
                          fontSize: 26,
                          fontWeight: FontWeight.w900)),
                  Text("${sumPrice().toString()}€",
                      style: const TextStyle(
                          color: primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w500)),
                  Expanded(child: Container()),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const QRCodeScanner()));
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(primaryColor),
                      overlayColor:
                          MaterialStateProperty.resolveWith<Color?>((states) {
                        if (states.contains(MaterialState.pressed)) {
                          return subColor2;
                        }
                        return null;
                      }),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("ORDER",
                          style: TextStyle(
                              color: secondaryColor,
                              fontSize: 22,
                              fontWeight: FontWeight.w900)),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
