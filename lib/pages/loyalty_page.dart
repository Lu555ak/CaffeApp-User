import 'package:flutter/material.dart';

import 'package:caffe_app_user/utility/constants.dart';

import 'package:caffe_app_user/custom/road_map.dart';

class LoyaltyPage extends StatefulWidget {
  const LoyaltyPage({super.key});

  @override
  State<LoyaltyPage> createState() => _LoyaltyPageState();
}

class _LoyaltyPageState extends State<LoyaltyPage> {
  List<int> roadmap = [1, 0, 0, 0, 0, 2, 0, 0, 0, 3, 0, 0, 0, 0, 0, 4, 0, 0, 5];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 15.0, bottom: 10, top: 10),
                  child: Text("R O A D   M A P",
                      style: TextStyle(
                          color: primaryColor,
                          fontSize: 24,
                          fontWeight: FontWeight.w900)),
                )),
            RoadMap(roadmap: roadmap)
          ],
        ),
      ),
    );
  }
}
