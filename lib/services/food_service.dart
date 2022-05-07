import 'package:flutter/services.dart';
import 'package:flutter_pos_kawpun/models/food_model.dart';

class FoodService {
  static Future<List<FoodModel>> getFoodMenu() async {
    final String response =
        await rootBundle.loadString('assets/data/kawpun_food.json');
    List<FoodModel> foodMenuModel = foodMenuModelFromJson(response);
    return foodMenuModel;
  }
}
