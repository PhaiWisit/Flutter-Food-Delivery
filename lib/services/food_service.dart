import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_pos_kawpun/models/food_menu_model.dart';

class FoodService {
  static Future<List<FoodMenuModel>> getFoodMenu() async {
    final String response =
        await rootBundle.loadString('assets/data/kawpun_food.json');
    List<FoodMenuModel> foodMenuModel = foodMenuModelFromJson(response);
    return foodMenuModel;
  }
}
