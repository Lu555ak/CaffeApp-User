import 'package:caffe_app_user/utility/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:caffe_app_user/utility/constants.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(
          Icons.production_quantity_limits_rounded,
          size: 60,
          color: primaryColor,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            AppLocalizations.of(context).translate("no_data"),
            style: const TextStyle(color: primaryColor, fontSize: 20),
          ),
        ),
      ],
    );
  }
}
