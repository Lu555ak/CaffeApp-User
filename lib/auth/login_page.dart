import 'package:caffe_app_user/auth/forgot_password_page.dart';
import 'package:caffe_app_user/custom/background.dart';
import 'package:caffe_app_user/utility/app_localizations.dart';

import 'package:caffe_app_user/utility/constants.dart';
import 'package:caffe_app_user/utility/utility.dart';
import 'package:caffe_app_user/auth/auth.dart';

import 'package:caffe_app_user/auth/registration_page.dart';

import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool? _rememberMe = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _loginFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(children: [
        const Background(),
        LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
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
                  boxShadow: [BoxShadow(color: primaryColor, spreadRadius: 3, blurRadius: 4, offset: Offset(1, 1))]),
              child: Form(
                key: _loginFormKey,
                child: Column(children: [
                  const SizedBox(
                    height: 35,
                  ),
                  Text(AppLocalizations.of(context).translate("login_text"),
                      style: const TextStyle(color: primaryColor, fontSize: 40, fontWeight: FontWeight.bold)),
                  const Divider(
                    color: primaryColor,
                    thickness: 8,
                  ),
                  TextFormField(
                      controller: _emailController,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: AppLocalizations.of(context).translate("email_text"),
                      ),
                      validator: (value) {
                        if (value == "" || value == null) {
                          return AppLocalizations.of(context).translate("please_enter_an_email_text");
                        } else if (!isValidEmail(value)) {
                          return AppLocalizations.of(context).translate("please_enter_a_valid_email");
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
                      decoration: InputDecoration(
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: AppLocalizations.of(context).translate("password_text"),
                      ),
                      autocorrect: false,
                      obscureText: true,
                      validator: (value) {
                        if (value == "" || value == null) {
                          return AppLocalizations.of(context).translate("please_enter_a_password_text");
                        }
                        return null;
                      }),
                  const Divider(
                    color: primaryColor,
                    indent: 20,
                    endIndent: 20,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ForgotPasswordPage()),
                      );
                    },
                    child: Text(AppLocalizations.of(context).translate("forgot_your_password_text"),
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          color: subColor2,
                          fontSize: 12,
                        )),
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
                    title: Text(AppLocalizations.of(context).translate("remember_me_text"),
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          color: primaryColor,
                          fontSize: 14,
                        )),
                  ),
                  const Expanded(child: SizedBox()),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_loginFormKey.currentState!.validate()) {
                          String? message =
                              await Auth().signIn(email: _emailController.text, password: _passwordController.text);

                          if (!mounted) return;
                          switch (message) {
                            case "user-not-found":
                              alert(context, "auth_no_user_found", dangerColor);
                              break;
                            case "wrong-password":
                              alert(context, "auth_wrong_password", dangerColor);
                              break;
                            case null:
                              alert(context, "default_success", successColor);
                              break;
                            default:
                              alert(context, "default_error", dangerColor);
                              break;
                          }
                        }
                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(const CircleBorder()),
                        padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
                        backgroundColor: MaterialStateProperty.all(primaryColor),
                        overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
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
                        MaterialPageRoute(builder: (context) => const RegistrationPage()),
                      );
                    },
                    child: Text(AppLocalizations.of(context).translate("dont_have_an_account_text"),
                        textAlign: TextAlign.left,
                        style: const TextStyle(
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
