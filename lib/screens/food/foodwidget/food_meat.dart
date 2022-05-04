import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_pos_kawpun/models/food_model.dart';
import 'package:flutter_pos_kawpun/utils/text_style.dart';
import 'package:provider/provider.dart';

import '../../../providers/food_provider.dart';

class FoodMeatItem extends StatefulWidget {
  const FoodMeatItem({Key? key}) : super(key: key);

  // final List foodMeat;
  // final List _foodMeatSelected;

  @override
  State<FoodMeatItem> createState() => _FoodMeatItemState();
}

class _FoodMeatItemState extends State<FoodMeatItem> {
  late FoodModel selectedFood;

  late List<dynamic> foodMeats;
  late dynamic selectedfoodMeat = foodMeats.first;
  late int selectedRadio = 0;
  late int selectedRadioTile = 0;

  @override
  void initState() {
    super.initState();

    FoodProvider foodProvider =
        Provider.of<FoodProvider>(context, listen: false);

    selectedFood = foodProvider.selectFood;
    foodMeats = jsonDecode(selectedFood.foodMeat);
  }

  setSelectedFoodMeat(dynamic foodMeat) {
    setState(() {
      selectedfoodMeat = foodMeat;
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
                    'เลือกเนื้อสัตว์ 1 อย่าง',
                    style: textStyleTitle,
                  ),
                ],
              ),
              ListView(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: _createRadioListFoodMeat(),
              ),
              Divider(),
            ],
          )),
    );
  }

  List<Widget> _createRadioListFoodMeat() {
    List<Widget> widgets = [];
    for (String foodMeat in foodMeats) {
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
                value: foodMeat,
                groupValue: selectedfoodMeat,
                title: Text(foodMeat),
                onChanged: (currentUser) {
                  setSelectedFoodMeat(currentUser as dynamic);
                },
                selected: selectedfoodMeat == foodMeat,
                activeColor: Colors.green,
              ),
            ),
          ],
        ),
      );
    }
    return widgets;
  }
}
