// ignore_for_file: dead_code

import 'package:flutter/material.dart';
import 'package:flutter_pos_kawpun/screens/basket/basket_screen.dart';
import 'package:flutter_pos_kawpun/screens/home/homewidget/home_badge.dart';
import 'package:flutter_pos_kawpun/screens/home/homewidget/home_item.dart';
import 'package:provider/provider.dart';

import '../../providers/basket_provider.dart';
import 'homewidget/home_cover.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var basket = Provider.of<BasketProvider>(context, listen: true);
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
      floatingActionButton: Container(
        width: 60,
        height: 60,
        child: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).pushNamed(BasketScreen.routeName);
            },
            backgroundColor: Colors.amber.shade900,
            child: Container(
              width: 50,
              height: 50,
              child: HomeBadge(
                  child: Icon(
                    Icons.shopping_basket_outlined,
                  ),
                  value: basket.basketCount.toString()),
            )),
      ),
    );
  }
}
