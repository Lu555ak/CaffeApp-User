import 'package:caffe_app_user/custom/background.dart';
import 'package:caffe_app_user/utility/app_localizations.dart';

import 'package:caffe_app_user/utility/constants.dart';
import 'package:caffe_app_user/utility/utility.dart';
import 'package:caffe_app_user/auth/auth.dart';

import 'package:flutter/material.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final _registerFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(children: [
        const Background(
          color: subColor,
          opacity: 0.5,
        ),
        Center(
          child: Container(
            width: 300,
            height: 500,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: secondaryColor,
              borderRadius: const BorderRadius.all(Radius.circular(50)),
              boxShadow: [
                BoxShadow(
                  color: subColor2.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(-5, 5),
                ),
              ],
            ),
            child: Form(
              key: _registerFormKey,
              child: Column(children: [
                const SizedBox(
                  height: 35,
                ),
                Text(AppLocalizations.of(context).translate("register_text"),
                    style: const TextStyle(color: primaryColor, fontSize: 40, fontWeight: FontWeight.bold)),
                const Divider(
                  color: primaryColor,
                  thickness: 8,
                ),
                TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintText: AppLocalizations.of(context).translate("email_text"),
                    ),
                    autocorrect: false,
                    validator: (value) {
                      if (value == "" || value == null) {
                        return AppLocalizations.of(context).translate("please_enter_an_email_text");
                      } else if (!isValidEmail(value)) {
                        return AppLocalizations.of(context).translate("please_enter_a_valid_email");
                      }
                      return null;
                    }),
                const Divider(
                  color: subColor2,
                  indent: 20,
                  endIndent: 20,
                ),
                TextFormField(
                    controller: _usernameController,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintText: AppLocalizations.of(context).translate("username_text"),
                    ),
                    validator: (value) {
                      if (value == "" || value == null) {
                        return AppLocalizations.of(context).translate("please_enter_an_username_text");
                      }
                      return null;
                    }),
                const Divider(
                  color: subColor2,
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
                  color: subColor2,
                  indent: 20,
                  endIndent: 20,
                ),
                const Expanded(child: SizedBox()),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_registerFormKey.currentState!.validate()) {
                        String? message = await Auth().signUp(
                          email: _emailController.text,
                          password: _passwordController.text,
                          username: _usernameController.text,
                        );

                        if (!mounted) return;
                        switch (message) {
                          case "weak-password":
                            alert(context, "auth_password_weak_text", dangerColor);
                            break;
                          case "email-already-in-use":
                            alert(context, "auth_account_exists", dangerColor);
                            break;
                          case null:
                            alert(context, "default_success", successColor);
                            Navigator.pop(context);
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
                    Navigator.pop(context);
                  },
                  child: Text(AppLocalizations.of(context).translate("have_an_account_text"),
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        color: subColor2,
                        fontSize: 12,
                      )),
                ),
              ]),
            ),
          ),
        )
      ]),
    );
  }
}
