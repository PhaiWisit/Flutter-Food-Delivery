import 'package:flutter/material.dart';
import 'package:flutter_pos_kawpun/models/food_menu_model.dart';
import 'package:flutter_pos_kawpun/services/food_service.dart';

class FoodMenuProvider with ChangeNotifier {
  bool _isLoading = false;
  List<FoodMenuModel> _foodMenuList = [];
  List<FoodMenuModel> _foodMenu1 = [];
  List<FoodMenuModel> _foodMenu2 = [];
  List<FoodMenuModel> _foodMenu3 = [];
  List<FoodMenuModel> _foodMenu4 = [];

  bool get isLoading => _isLoading;
  List<FoodMenuModel> get foodMenuList => _foodMenuList;
  List<FoodMenuModel> get foodMenu1 => _foodMenu1;
  List<FoodMenuModel> get foodMenu2 => _foodMenu2;
  List<FoodMenuModel> get foodMenu3 => _foodMenu3;
  List<FoodMenuModel> get foodMenu4 => _foodMenu4;

  FoodMenuProvider() {
    getFoodMenuList();
  }

  void setLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  void setFoodMenuList(List<FoodMenuModel> foodMenuList) {
    List<FoodMenuModel> foodMenu1 =
        foodMenuList.where((food) => food.foodType == 'อาหารจานเดียว').toList();
    List<FoodMenuModel> foodMenu2 =
        foodMenuList.where((food) => food.foodType == 'เป็นกับข้าว').toList();
    List<FoodMenuModel> foodMenu3 =
        foodMenuList.where((food) => food.foodType == 'เมนูเส้น').toList();
    List<FoodMenuModel> foodMenu4 =
        foodMenuList.where((food) => food.foodType == 'ยำ').toList();
    List<FoodMenuModel> sumList = foodMenu1 + foodMenu2 + foodMenu3 + foodMenu4;

    _foodMenu1 = foodMenu1;
    _foodMenu2 = foodMenu2;
    _foodMenu3 = foodMenu3;
    _foodMenu4 = foodMenu4;

    _foodMenuList = sumList;
  }

  getFoodMenuList() async {
    setLoading(true);
    setFoodMenuList(await FoodService.getFoodMenu());
    setLoading(false);
  }
}
