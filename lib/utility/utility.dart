import 'package:flutter/material.dart';

import 'app_localizations.dart';

bool isValidEmail(String? email) {
  return RegExp(
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
      .hasMatch(email ?? "");
}

void alert(BuildContext context, String key, Color color) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(AppLocalizations.of(context).translate(key)),
    backgroundColor: color,
  ));
}
