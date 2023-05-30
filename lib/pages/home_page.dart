import 'package:flutter/material.dart';

import 'package:caffe_app_user/custom/featured_component.dart';
import 'package:caffe_app_user/custom/quiz_alert.dart';

import 'package:caffe_app_user/utility/constants.dart';

import 'package:caffe_app_user/models/menu_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<MenuItem> _featuredMenu = Menu().getFeaturedItems();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 15.0, bottom: 10, top: 10),
                child: Text("F E A T U R E D",
                    style: TextStyle(
                        color: primaryColor,
                        fontSize: 24,
                        fontWeight: FontWeight.w900)),
              )),
          SizedBox(
            height: 250,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: _featuredMenu.length,
              itemBuilder: (context, index) {
                return FeaturedComponent(
                  item: _featuredMenu[index],
                );
              },
            ),
          ),
          const QuizAlert()
        ]),
      ),
    );
  }
}
