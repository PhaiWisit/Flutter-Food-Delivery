// ignore_for_file: dead_code

import 'package:flutter/material.dart';
import 'package:flutter_pos_kawpun/screens/home/homewidget/home_item.dart';
import 'package:flutter_pos_kawpun/utils/textStyle.dart';

import 'homewidget/home_cover.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isHideAppBar = true;
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          HomeCover(),
          Container(
            color: Colors.grey.shade200,
            height: 10,
          ),
          HomeItem(),
        ],
      )),
    );
  }
}
