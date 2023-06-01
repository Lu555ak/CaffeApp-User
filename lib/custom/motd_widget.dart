import 'package:caffe_app_user/utility/app_localizations.dart';
import 'package:flutter/material.dart';

import 'package:caffe_app_user/utility/constants.dart';

class MOTDWidget extends StatelessWidget {
  const MOTDWidget({super.key});

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
                  title: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Row(
                      children: [
                        Text(
                          AppLocalizations.of(context).translate("motd_welcome"),
                          style: const TextStyle(color: secondaryColor, fontSize: 20, fontWeight: FontWeight.w400),
                        ),
                        const Text(
                          "CaffeApp!",
                          style: TextStyle(color: secondaryColor, fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 10.0, left: 8.0),
                    child: Text(
                      AppLocalizations.of(context).translate("motd_message"),
                      style: const TextStyle(color: secondaryColor, fontSize: 17, fontWeight: FontWeight.w400),
                    ),
                  ),
                  trailing: const Padding(
                    padding: EdgeInsets.only(right: 15.0),
                    child: Icon(
                      Icons.local_drink_outlined,
                      color: secondaryColor,
                      size: 60,
                    ),
                  )),
            )),
      ),
    );
  }
}
