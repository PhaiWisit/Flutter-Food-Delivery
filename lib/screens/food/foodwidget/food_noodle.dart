import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_pos_kawpun/models/food_model.dart';
import 'package:flutter_pos_kawpun/utils/text_style.dart';
import 'package:provider/provider.dart';

import '../../../providers/basket_provider.dart';
import '../../../providers/food_provider.dart';

class FoodNoodleItem extends StatefulWidget {
  const FoodNoodleItem({Key? key}) : super(key: key);

  @override
  State<FoodNoodleItem> createState() => _FoodNoodleItemState();
}

class _FoodNoodleItemState extends State<FoodNoodleItem> {
  late FoodModel selectedFood;

  late List<dynamic> foodNoodles;
  late dynamic selectedfoodNoodle = foodNoodles.first;

  @override
  void initState() {
    super.initState();

    FoodProvider foodProvider =
        Provider.of<FoodProvider>(context, listen: false);

    selectedFood = foodProvider.selectFood;
    foodNoodles = jsonDecode(selectedFood.foodNoodles);
  }

  setSelectedFoodNoodle(dynamic foodNoodle) {
    setState(() {
      selectedfoodNoodle = foodNoodle;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          // color: Colors.amber,
          // width: double.infinity,
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'เลือกเส้น',
                    style: textStyleTitle,
                  ),
                ],
              ),
              ListView(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: _createRadioListFoodOption(),
              ),
              Divider(),
            ],
          )),
    );
  }

  List<Widget> _createRadioListFoodOption() {
    var basket = Provider.of<BasketProvider>(context, listen: true);
    basket.setFoodNoodle(selectedfoodNoodle);
    List<Widget> widgets = [];
    for (String foodNoodle in foodNoodles) {
      widgets.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: RadioListTile(
                visualDensity: const VisualDensity(
                    horizontal: VisualDensity.minimumDensity,
                    vertical: VisualDensity.minimumDensity),
                contentPadding: EdgeInsets.all(0),
                value: foodNoodle,
                groupValue: selectedfoodNoodle,
                title: Text(foodNoodle, style: textStyleNormal),
                onChanged: (current) {
                  setSelectedFoodNoodle(current as dynamic);
                  basket.setFoodNoodle(current);
                },
                selected: selectedfoodNoodle == foodNoodle,
                activeColor: Colors.green,
              ),
            ),
            // Text('+10 บาท')
          ],
        ),
      );
    }
    return widgets;
  }
}
