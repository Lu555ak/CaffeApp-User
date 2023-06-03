import 'package:caffe_app_user/custom/motd_widget.dart';
import 'package:caffe_app_user/custom/no_data_widget.dart';
import 'package:caffe_app_user/utility/app_localizations.dart';
import 'package:flutter/material.dart';

import 'package:caffe_app_user/custom/featured_component.dart';

import 'package:caffe_app_user/utility/constants.dart';

import 'package:caffe_app_user/models/menu_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0, bottom: 10, top: 10),
                child: Text(AppLocalizations.of(context).translate("featured_text"),
                    style: const TextStyle(color: subColor2, fontSize: 24, fontWeight: FontWeight.w900)),
              )),
          SizedBox(
            height: 250,
            child: FutureBuilder(
              future: Menu().loadFromDatabase(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return const Center(child: CircularProgressIndicator());
                  case ConnectionState.waiting:
                    return const Center(child: CircularProgressIndicator());
                  case ConnectionState.active:
                    return const Center(child: CircularProgressIndicator());
                  case ConnectionState.done:
                    var featuredMenu = Menu().getFeaturedItems();
                    if (featuredMenu.isNotEmpty) {
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: featuredMenu.length,
                        itemBuilder: (context, index) {
                          return FeaturedComponent(
                            item: featuredMenu[index],
                          );
                        },
                      );
                    } else {
                      return const NoDataWidget();
                    }
                }
              },
            ),
          ),
          const MOTDWidget()
        ]),
      ),
    );
  }
}
