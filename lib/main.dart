import 'package:flutter/material.dart';
import 'package:caffe_app_user/pages/manager_page.dart';
import 'package:caffe_app_user/auth/login_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: ManagerPage());
  }
}