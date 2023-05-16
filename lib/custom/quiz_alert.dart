import 'package:flutter/material.dart';

import 'package:caffe_app_user/utility/constants.dart';

class QuizAlert extends StatelessWidget {
  const QuizAlert({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
            width: double.infinity,
            height: double.infinity,
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
            child: Align(
              alignment: Alignment.center,
              child: ListTile(
                title: Row(
                  children: const [
                    Text(
                      "Hello, ",
                      style: TextStyle(
                          color: secondaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "User!",
                      style: TextStyle(
                          color: secondaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                subtitle: const Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text(
                    "A quiz will be taking place soon, press the button to join!",
                    style: TextStyle(
                        color: secondaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                trailing: ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(const CircleBorder()),
                    padding:
                        MaterialStateProperty.all(const EdgeInsets.all(15)),
                    backgroundColor: MaterialStateProperty.all(secondaryColor),
                    overlayColor:
                        MaterialStateProperty.resolveWith<Color?>((states) {
                      if (states.contains(MaterialState.pressed)) {
                        return subColor2;
                      }
                      return null;
                    }),
                  ),
                  child: const Icon(
                    Icons.arrow_forward_ios_sharp,
                    color: primaryColor,
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
