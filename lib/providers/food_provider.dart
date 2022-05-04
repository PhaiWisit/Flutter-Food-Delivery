import 'package:flutter/material.dart';
import 'package:flutter_pos_kawpun/models/food_model.dart';
import 'package:flutter_pos_kawpun/services/food_service.dart';

enum FilterOption { All, Favorites, Onedish, Dishes, Noodle, Yum }

class FoodProvider with ChangeNotifier {
  bool _isLoading = false;
  List<FoodModel> _foodMenuList = [];
  List<FoodModel> _foodMenu1 = [];
  List<FoodModel> _foodMenu2 = [];
  List<FoodModel> _foodMenu3 = [];
  List<FoodModel> _foodMenu4 = [];
  FoodModel? _selectFood;

  Map<FilterOption, bool> _filterStatus = {
    FilterOption.All: false,
    FilterOption.Favorites: false,
    FilterOption.Onedish: false,
    FilterOption.Dishes: false,
    FilterOption.Noodle: false,
    FilterOption.Yum: false
  };

  final Map<FilterOption, bool> _expandStatus = {
    FilterOption.Onedish: true,
    FilterOption.Dishes: true,
    FilterOption.Noodle: true,
    FilterOption.Yum: true
  };

  bool get isLoading => _isLoading;
  List<FoodModel> get foodMenuList => _foodMenuList;
  List<FoodModel> get foodMenu1 => _foodMenu1;
  List<FoodModel> get foodMenu2 => _foodMenu2;
  List<FoodModel> get foodMenu3 => _foodMenu3;
  List<FoodModel> get foodMenu4 => _foodMenu4;
  FoodModel get selectFood => _selectFood!;

  Map<FilterOption, bool> get filterStatus => _filterStatus;
  Map<FilterOption, bool> get expandStatus => _expandStatus;

  void setSelectFood(FoodModel foodModel) {
    _selectFood = foodModel;
  }

  void setExpandStatus(FilterOption expand, bool status) {
    _expandStatus[expand] = status;
    notifyListeners();
  }

  void setFilterStatus(FilterOption filter, bool status) {
    _setFilterFalse();
    _filterStatus[filter] = status;
    notifyListeners();
  }

  void _setFilterFalse() {
    _filterStatus = {
      FilterOption.All: false,
      FilterOption.Favorites: false,
      FilterOption.Onedish: false,
      FilterOption.Dishes: false,
      FilterOption.Noodle: false,
      FilterOption.Yum: false
    };
  }

  FoodProvider() {
    getFoodMenuList();
  }

  void setLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  void setFoodMenuList(List<FoodModel> foodMenuList) {
    List<FoodModel> foodMenu1 =
        foodMenuList.where((food) => food.foodType == 'อาหารจานเดียว').toList();
    List<FoodModel> foodMenu2 =
        foodMenuList.where((food) => food.foodType == 'เป็นกับข้าว').toList();
    List<FoodModel> foodMenu3 =
        foodMenuList.where((food) => food.foodType == 'เมนูเส้น').toList();
    List<FoodModel> foodMenu4 =
        foodMenuList.where((food) => food.foodType == 'ยำ').toList();
    List<FoodModel> sumList = foodMenu1 + foodMenu2 + foodMenu3 + foodMenu4;

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
