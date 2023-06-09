import 'package:caffe_app_user/auth/auth.dart';
import 'package:caffe_app_user/utility/app_localizations.dart';
import 'package:caffe_app_user/utility/constants.dart';
import 'package:flutter/material.dart';

import 'package:caffe_app_user/custom/background.dart';
import 'package:caffe_app_user/utility/utility.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final loginFormKey = GlobalKey<FormState>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(backgroundColor: secondaryColor, iconTheme: const IconThemeData(color: primaryColor)),
      body: Stack(children: [
        const Background(
          color: subColor,
          opacity: 0.5,
        ),
        Center(
          child: Container(
            width: 350,
            height: 250,
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
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(children: [
                Text(AppLocalizations.of(context).translate("forgot_password_text"),
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: subColor2, fontSize: 20, fontWeight: FontWeight.w500)),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Form(
                    key: loginFormKey,
                    child: TextFormField(
                        controller: emailController,
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
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: TextButton(
                        onPressed: () {
                          if (loginFormKey.currentState!.validate()) {
                            Auth().resetPassword(emailController.text);
                            Navigator.pop(context);
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(primaryColor),
                          overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
                            if (states.contains(MaterialState.pressed)) {
                              return subColor2;
                            }
                            return null;
                          }),
                        ),
                        child: Text(AppLocalizations.of(context).translate("send_text"),
                            style: const TextStyle(color: secondaryColor, fontSize: 25, fontWeight: FontWeight.w600))),
                  ),
                )
              ]),
            ),
          ),
        )
      ]),
    );
  }
}
