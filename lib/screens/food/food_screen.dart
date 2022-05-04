import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_pos_kawpun/models/food_model.dart';
import 'package:flutter_pos_kawpun/providers/food_provider.dart';
import 'package:flutter_pos_kawpun/screens/food/foodwidget/food_more_detail.dart';
import 'package:flutter_pos_kawpun/screens/food/foodwidget/food_noodle.dart';
import 'package:flutter_pos_kawpun/screens/food/foodwidget/food_option.dart';
import 'package:flutter_pos_kawpun/screens/food/foodwidget/food_extra.dart';
import 'package:flutter_pos_kawpun/utils/app_log.dart';
import 'package:flutter_pos_kawpun/utils/text_style.dart';
import 'package:provider/provider.dart';

import 'foodwidget/food_meat.dart';

class FoodScreen extends StatelessWidget {
  static const routeName = '/food';
  const FoodScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FoodProvider foodProvider =
        Provider.of<FoodProvider>(context, listen: false);
    FoodModel selectedFood = foodProvider.selectFood;

    List<dynamic> foodMeat = jsonDecode(selectedFood.foodMeat);
    List<dynamic> foodOption = jsonDecode(selectedFood.foodOption);
    List<dynamic> foodExtra = jsonDecode(selectedFood.foodExtra);
    List<dynamic> foodNoodle = jsonDecode(selectedFood.foodNoodles);

    var _foodMeatSelected = foodMeat;

    if (foodNoodle.isEmpty) {
      AppLog.error('foodNoodle empty');
    }

    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          _buildFoodCover(selectedFood, context),
          _buildFoodName(selectedFood),
          Divider(),
          foodMeat.isNotEmpty ? FoodMeatItem() : SizedBox(),
          foodOption.isNotEmpty ? FoodOptionItem() : SizedBox(),
          foodExtra.isNotEmpty ? FoodExtraItem() : SizedBox(),
          foodNoodle.isNotEmpty ? FoodNoodleItem() : SizedBox(),
          FoodMoreDetail(),
          SizedBox(height: 20),
          _buildButtonAddToCart(context),
          SizedBox(height: 20),
        ],
      )),
    );
  }

  Widget _buildButtonAddToCart(BuildContext context) {
    return InkWell(
      onTap: (() {
        AppLog.tap('add to cart');
      }),
      child: Container(
          width: MediaQuery.of(context).size.width * 0.5,
          decoration: BoxDecoration(
              color: Colors.green, borderRadius: BorderRadius.circular(20)),
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Icon(
                  Icons.add_shopping_cart,
                  color: Colors.white,
                  size: 25,
                ),
              ),
              Text('เพิ่มในตระกร้า',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ))
            ],
          )),
    );
  }

  Stack _buildFoodCover(FoodModel selectedFood, BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 250,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(selectedFood.foodImageUrl),
                  fit: BoxFit.cover)),
        ),
        SafeArea(
          child: Align(
            alignment: Alignment.topLeft,
            child: Container(
              height: 40,
              decoration:
                  BoxDecoration(color: Colors.white30, shape: BoxShape.circle),
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Container _buildFoodName(FoodModel selectedFood) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            selectedFood.foodName,
            style: textStyleHead,
          ),
        ],
      ),
    );
  }
}
