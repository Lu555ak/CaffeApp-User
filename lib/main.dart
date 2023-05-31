import 'package:caffe_app_user/auth/auth.dart';
import 'package:caffe_app_user/utility/app_localizations.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:caffe_app_user/pages/manager_page.dart';
import 'package:caffe_app_user/auth/login_page.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        supportedLocales: const [Locale("en", "EN"), Locale("hr", "HR")],
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        localeListResolutionCallback: (locales, supportedLocales) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locales![0].languageCode &&
                supportedLocale.countryCode == locales[0].countryCode) {
              return supportedLocale;
            }
          }
          return supportedLocales.first;
        },
        home: StreamBuilder(
          stream: Auth().userChanges,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return const LoginPage();
              case ConnectionState.waiting:
                return const Center(child: CircularProgressIndicator());
              default:
                if (snapshot.hasData) {
                  return const ManagerPage();
                } else {
                  return const LoginPage();
                }
            }
          },
        ));
  }
}
