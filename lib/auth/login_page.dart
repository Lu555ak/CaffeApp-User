import 'package:caffe_app_user/custom/background.dart';
import 'package:caffe_app_user/utility/constants.dart';

import 'package:caffe_app_user/auth/registration_page.dart';

import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool? rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        const Background(),
        LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          double localWidth = 300;
          double localHeight = 500;
          if (constraints.maxWidth <= 320) localWidth = 220;
          if (constraints.maxHeight <= 600) localHeight = 420;
          return Center(
            child: Container(
              width: localWidth,
              height: localHeight,
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  boxShadow: [
                    BoxShadow(
                        color: primaryColor,
                        spreadRadius: 3,
                        blurRadius: 4,
                        offset: Offset(1, 1))
                  ]),
              child: Column(children: [
                const SizedBox(
                  height: 35,
                ),
                const Text("LOGIN",
                    style: TextStyle(
                        color: primaryColor,
                        fontSize: 40,
                        fontWeight: FontWeight.bold)),
                const Divider(
                  color: primaryColor,
                  thickness: 8,
                ),
                TextFormField(
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    hintText: 'Username',
                  ),
                  autocorrect: false,
                ),
                const Divider(
                  color: primaryColor,
                  indent: 20,
                  endIndent: 20,
                ),
                TextFormField(
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    hintText: 'Password',
                  ),
                  autocorrect: false,
                  obscureText: true,
                ),
                const Divider(
                  color: primaryColor,
                  indent: 20,
                  endIndent: 20,
                ),
                const Text("Forgot your password?",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: subColor2,
                      fontSize: 12,
                    )),
                ListTile(
                  leading: Checkbox(
                    value: rememberMe,
                    activeColor: primaryColor,
                    onChanged: (value) {
                      setState(() {
                        rememberMe = value;
                      });
                    },
                  ),
                  horizontalTitleGap: 0,
                  title: const Text("Remember me",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 14,
                      )),
                ),
                const Expanded(child: SizedBox()),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(const CircleBorder()),
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.all(20)),
                      backgroundColor: MaterialStateProperty.all(primaryColor),
                      overlayColor:
                          MaterialStateProperty.resolveWith<Color?>((states) {
                        if (states.contains(MaterialState.pressed)) {
                          return subColor;
                        }
                        return null;
                      }),
                    ),
                    child: const Icon(Icons.arrow_forward_ios_sharp),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegistrationPage()),
                    );
                  },
                  child: const Text("Don't have an account?",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: subColor2,
                        fontSize: 12,
                      )),
                ),
              ]),
            ),
          );
        })
      ]),
    );
  }
}