import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_pos_kawpun/models/food_model.dart';
import 'package:flutter_pos_kawpun/utils/text_style.dart';
import 'package:provider/provider.dart';
import '../../../providers/basket_provider.dart';
import '../../../providers/food_provider.dart';

class FoodExtraItem extends StatefulWidget {
  const FoodExtraItem({Key? key}) : super(key: key);

  @override
  State<FoodExtraItem> createState() => _FoodExtraItemState();
}

class _FoodExtraItemState extends State<FoodExtraItem> {
  late FoodModel selectedFood;
  // late BasketProvider basket;

  late List<dynamic> foodExtras;
  late dynamic selectedfoodExtra = foodExtras.first;

  @override
  void initState() {
    super.initState();

    FoodProvider foodProvider =
        Provider.of<FoodProvider>(context, listen: false);

    selectedFood = foodProvider.selectFood;
    foodExtras = jsonDecode(selectedFood.foodExtra);
  }

  setSelectedFoodExtra(dynamic foodExtra) {
    setState(() {
      selectedfoodExtra = foodExtra;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'พิเศษ',
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
    BasketProvider basket = Provider.of<BasketProvider>(context, listen: false);

    List<Widget> widgets = [];
    for (String foodExtra in foodExtras) {
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
                value: foodExtra,
                groupValue: selectedfoodExtra,
                title: foodExtra == 'true'
                    ? Text('พิเศษ', style: textStyleNormal)
                    : Text('ธรรมดา', style: textStyleNormal),
                onChanged: (current) {
                  setSelectedFoodExtra(current as dynamic);
                  if (foodExtra == 'true') {
                    basket.setFoodExtra('(พิเศษ)');
                    basket.setIsExtra(true);
                  } else {
                    basket.setFoodExtra('');
                    basket.setIsExtra(false);
                  }
                },
                selected: selectedfoodExtra == foodExtra,
                activeColor: Colors.green,
              ),
            ),
            foodExtra == 'true'
                ? Text(
                    '+10 บาท',
                    style: textStyleNormal,
                  )
                : SizedBox(),
          ],
        ),
      );
    }
    return widgets;
  }
}
