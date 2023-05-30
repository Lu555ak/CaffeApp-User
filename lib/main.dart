import 'package:caffe_app_user/auth/auth.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:caffe_app_user/pages/manager_page.dart';
import 'package:caffe_app_user/auth/login_page.dart';

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
        home: StreamBuilder(
          stream: Auth().userChanges,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const ManagerPage(
                key: Key("ManagerPage"),
              );
            } else {
              return const LoginPage(
                key: Key("LoginPage"),
              );
            }
          },
        ));
  }
}
