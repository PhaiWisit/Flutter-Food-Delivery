import 'package:flutter/material.dart';
import 'package:flutter_pos_kawpun/models/food_menu_model.dart';
import 'package:flutter_pos_kawpun/services/food_service.dart';

class FoodMenuProvider with ChangeNotifier {
  bool _isLoading = false;
  List<FoodMenuModel> _foodMenuList = [];

  bool get isLoading => _isLoading;
  List<FoodMenuModel> get foodMenuList => _foodMenuList;

  FoodMenuProvider() {
    getFoodMenuList();
  }

  void setLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  void setFoodMenuList(List<FoodMenuModel> foodMenuList) {
    _foodMenuList = foodMenuList;
  }

  getFoodMenuList() async {
    setLoading(true);
    setFoodMenuList(await FoodService.getFoodMenu());
    setLoading(false);
  }
}
