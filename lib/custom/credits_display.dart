import 'package:caffe_app_user/utility/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:caffe_app_user/utility/constants.dart';

class CreditsDisplay extends StatelessWidget {
  const CreditsDisplay({
    super.key,
    required this.creditsAmount,
  });

  final int creditsAmount;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 5.0),
        child: Container(
          width: 350,
          height: 100,
          decoration: BoxDecoration(
            color: subColor,
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  AppLocalizations.of(context).translate("credits_text"),
                  style: const TextStyle(color: subColor2, fontWeight: FontWeight.w600, fontSize: 30),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Container(
                  height: 75,
                  decoration: BoxDecoration(
                      color: secondaryColor,
                      border: Border.all(color: secondaryColor, width: 3),
                      borderRadius: const BorderRadius.all(Radius.circular(15))),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      children: [
                        Text(
                          creditsAmount.toString(),
                          style: const TextStyle(color: shinyColor, fontWeight: FontWeight.w800, fontSize: 35),
                        ),
                        const Icon(
                          Icons.circle,
                          color: shinyColor,
                          size: 30,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
