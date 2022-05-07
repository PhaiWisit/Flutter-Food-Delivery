import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_pos_kawpun/models/food_model.dart';
import 'package:flutter_pos_kawpun/providers/basket_provider.dart';
import 'package:flutter_pos_kawpun/providers/food_provider.dart';
import 'package:flutter_pos_kawpun/screens/basket/basket_screen.dart';
import 'package:flutter_pos_kawpun/screens/food/foodwidget/food_more_detail.dart';
import 'package:flutter_pos_kawpun/screens/food/foodwidget/food_noodle.dart';
import 'package:flutter_pos_kawpun/screens/food/foodwidget/food_option.dart';
import 'package:flutter_pos_kawpun/screens/food/foodwidget/food_extra.dart';
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

    // var _foodMeatSelected = foodMeat;

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
          SizedBox(height: 70),
        ],
      )),
      bottomSheet: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        color: Colors.transparent,
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildButtonBasket(context),
            _buildButtonAddToBasket(context),
          ],
        ),
      ),
    );
  }

  Widget _buildButtonBasket(BuildContext context) {
    var basket = Provider.of<BasketProvider>(context, listen: true);

    return Container(
      decoration: BoxDecoration(
          color: Colors.green, borderRadius: BorderRadius.circular(20)),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          onTap: (() {
            Navigator.of(context).pushNamed(BasketScreen.routeName);
          }),
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              width: MediaQuery.of(context).size.width * 0.25,
              // width: 100,
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Icon(
                      Icons.shopping_basket_outlined,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                  Text(basket.basketCount.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      )),
                ],
              )),
        ),
      ),
    );
  }

  Widget _buildButtonAddToBasket(BuildContext context) {
    FoodProvider food = Provider.of<FoodProvider>(context, listen: false);
    FoodModel selectedFood = food.selectFood;
    List<dynamic> foodMeat = jsonDecode(selectedFood.foodMeat);
    List<dynamic> foodOption = jsonDecode(selectedFood.foodOption);
    List<dynamic> foodNoodle = jsonDecode(selectedFood.foodNoodles);
    // List<dynamic> foodExtra = jsonDecode(selectedFood.foodExtra);

    var basket = Provider.of<BasketProvider>(context, listen: true);

    return Container(
      decoration: BoxDecoration(
          color: Colors.green, borderRadius: BorderRadius.circular(20)),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          onTap: (() {
            basket.setFoodName(food.selectFood.foodName);
            if (foodOption.isEmpty) {
              basket.setFoodOption('');
            }
            if (foodNoodle.isEmpty) {
              basket.setFoodNoodle('');
            }
            if (foodMeat.isEmpty) {
              basket.setFoodMeat('');
            }

            basket.addFoodToBasket();
            basket.resetItem();

            Navigator.of(context)
                .pushNamedAndRemoveUntil('/', (route) => false);
          }),
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              width: MediaQuery.of(context).size.width * 0.6,
              // width: 150,
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  // Container(
                  //   child: Icon(
                  //     Icons.shopping_basket,
                  //     color: Colors.white,
                  //     size: 25,
                  //   ),
                  // ),
                  Text('เพิ่มในตระกร้า', style: textStyleTitleWhite),
                  Spacer(),
                  Text(basket.foodPrice.toString(), style: textStyleTitleWhite)
                ],
              )),
        ),
      ),
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
