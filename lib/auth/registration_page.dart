import 'package:caffe_app_user/custom/background.dart';
import 'package:caffe_app_user/pages/home_page.dart';
import 'package:caffe_app_user/utility/constants.dart';
import 'package:caffe_app_user/utility/utility.dart';
import 'package:caffe_app_user/auth/auth.dart';

import 'package:flutter/material.dart';

import 'package:caffe_app_user/auth/login_page.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  bool? _rememberMe = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final _registerFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(children: [
        const Background(),
        LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          double localWidth = 300;
          double localHeight = 550;
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
              child: Form(
                key: _registerFormKey,
                child: Column(children: [
                  const SizedBox(
                    height: 35,
                  ),
                  const Text("REGISTER",
                      style: TextStyle(
                          color: primaryColor,
                          fontSize: 40,
                          fontWeight: FontWeight.bold)),
                  const Divider(
                    color: primaryColor,
                    thickness: 8,
                  ),
                  TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: 'E-mail',
                      ),
                      autocorrect: false,
                      validator: (value) {
                        if (value == "" || value == null) {
                          return "Please enter an email!";
                        } else if (!isValidEmail(value)) {
                          return "Please enter a valid email!";
                        }
                        return null;
                      }),
                  const Divider(
                    color: primaryColor,
                    indent: 20,
                    endIndent: 20,
                  ),
                  TextFormField(
                      controller: _usernameController,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: 'Username',
                      ),
                      validator: (value) {
                        if (value == "" || value == null) {
                          return "Please enter an username!";
                        }
                        return null;
                      }),
                  const Divider(
                    color: primaryColor,
                    indent: 20,
                    endIndent: 20,
                  ),
                  TextFormField(
                      controller: _passwordController,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: 'Password',
                      ),
                      autocorrect: false,
                      obscureText: true,
                      validator: (value) {
                        if (value == "" || value == null) {
                          return "Please enter a password!";
                        }
                        return null;
                      }),
                  const Divider(
                    color: primaryColor,
                    indent: 20,
                    endIndent: 20,
                  ),
                  ListTile(
                    leading: Checkbox(
                      value: _rememberMe,
                      activeColor: primaryColor,
                      onChanged: (value) {
                        setState(() {
                          _rememberMe = value;
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
                      onPressed: () async {
                        if (_registerFormKey.currentState!.validate()) {
                          final message = await Auth().signUp(
                              email: _emailController.text,
                              password: _passwordController.text,
                              username: _usernameController.text);

                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(message ?? "Error"),
                            backgroundColor: dangerColor,
                          ));
                        }
                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(const CircleBorder()),
                        padding:
                            MaterialStateProperty.all(const EdgeInsets.all(20)),
                        backgroundColor:
                            MaterialStateProperty.all(primaryColor),
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
                            builder: (context) => const LoginPage()),
                      );
                    },
                    child: const Text("Have an account?",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: subColor2,
                          fontSize: 12,
                        )),
                  ),
                ]),
              ),
            ),
          );
        })
      ]),
    );
  }
}
