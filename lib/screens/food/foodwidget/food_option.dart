import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_pos_kawpun/models/food_model.dart';
import 'package:flutter_pos_kawpun/utils/app_log.dart';
import 'package:flutter_pos_kawpun/utils/text_style.dart';
import 'package:provider/provider.dart';

import '../../../providers/basket_provider.dart';
import '../../../providers/food_provider.dart';

class FoodOptionItem extends StatefulWidget {
  const FoodOptionItem({Key? key}) : super(key: key);

  // final List foodMeat;
  // final List _foodMeatSelected;

  @override
  State<FoodOptionItem> createState() => _FoodOptionItemState();
}

class _FoodOptionItemState extends State<FoodOptionItem> {
  late FoodModel selectedFood;

  late List<dynamic> foodOptions;
  late dynamic selectedfoodOption = foodOptions.first;

  final Map<String, bool> _map = {};

  @override
  void initState() {
    super.initState();

    FoodProvider foodProvider =
        Provider.of<FoodProvider>(context, listen: false);

    selectedFood = foodProvider.selectFood;
    foodOptions = jsonDecode(selectedFood.foodOption);

    for (int i = 0; i < foodOptions.length; i++) {
      _map.addEntries([MapEntry(foodOptions[i], false)]);
      // AppLog.info(_map[foodOptions[i]].toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    var basket = Provider.of<BasketProvider>(context, listen: true);
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'ตัวเลือกเพิ่ม',
                    style: textStyleTitle,
                  ),
                ],
              ),
              ListView(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: _map.keys
                    .map(
                      (key) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: CheckboxListTile(
                                activeColor: Colors.green,
                                title: Text(key, style: textStyleNormal),
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                contentPadding: EdgeInsets.all(0),
                                visualDensity: const VisualDensity(
                                    horizontal: VisualDensity.minimumDensity,
                                    vertical: VisualDensity.minimumDensity),
                                value: _map[key],
                                onChanged: (value) {
                                  setState(() => _map[key] = value!);
                                  List<String> foodOptionSelected = [];
                                  String textFoodOption = '';
                                  int optionCount = 0;
                                  for (String key in _map.keys) {
                                    if (_map[key] == true) {
                                      foodOptionSelected.add(key);
                                      textFoodOption =
                                          foodOptionSelected.join(', ');
                                      optionCount++;
                                    }
                                  }
                                  AppLog.info(optionCount.toString());
                                  basket.setOptionCount(optionCount);
                                  basket.setFoodOption(textFoodOption);
                                }),
                          ),
                          Text('+10 บาท', style: textStyleNormal)
                        ],
                      ),
                    )
                    .toList(),
              ),
              Divider(),
            ],
          )),
    );
  }

  // List<Widget> _createRadioListFoodOption() {
  //   List<Widget> widgets = [];
  //   for (String foodOption in foodOptions) {
  //     widgets.add(
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           Expanded(
  //             child: RadioListTile(
  //               visualDensity: const VisualDensity(
  //                   horizontal: VisualDensity.minimumDensity,
  //                   vertical: VisualDensity.minimumDensity),
  //               contentPadding: EdgeInsets.all(0),
  //               value: foodOption,
  //               groupValue: selectedfoodOption,
  //               title: Text(foodOption),
  //               onChanged: (currentUser) {
  //                 // setSelectedUser(currentUser as dynamic);
  //               },
  //               selected: selectedfoodOption == foodOption,
  //               activeColor: Colors.green,
  //             ),
  //           ),
  //           Text('+10 บาท')
  //         ],
  //       ),
  //     );
  //   }
  //   return widgets;
  // }
}
