// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_pos_kawpun/models/food_model.dart';
import 'package:flutter_pos_kawpun/services/food_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/app_log.dart';

enum FilterOption { All, Favorites, Onedish, Dishes, Noodle, Yum }

class FoodProvider with ChangeNotifier {
  bool _isLoading = false;
  List<FoodModel> _foodMenuList = [];
  List<FoodModel> _foodMenu1 = [];
  List<FoodModel> _foodMenu2 = [];
  List<FoodModel> _foodMenu3 = [];
  List<FoodModel> _foodMenu4 = [];
  List<FoodModel> _foodFavorite = [];
  List<String> _favoriteId = [];
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
  List<FoodModel> get foodFavorite => _foodFavorite;
  List<String> get favoriteId => _favoriteId;
  FoodModel get selectFood => _selectFood!;

  Map<FilterOption, bool> get filterStatus => _filterStatus;
  Map<FilterOption, bool> get expandStatus => _expandStatus;

  void setFavoriteByLocal() async {
    setLoading(true);
    final prefs = await SharedPreferences.getInstance();
    final List<String> favoriteIdLocal = prefs.getStringList('favoriteId')!;

    _favoriteId = favoriteIdLocal;
    for (int i = 0; i < favoriteIdLocal.length; i++) {
      AppLog.error(favoriteIdLocal[i]);
      _foodFavorite.add(_foodMenuList
          .firstWhere((food) => food.foodId == favoriteIdLocal[i]));
      if (_foodFavorite
              .firstWhere((food) => food.foodId == favoriteIdLocal[i])
              .foodType ==
          'อาหารจานเดียว') {
        _foodMenu1
            .firstWhere((food) => food.foodId == favoriteIdLocal[i])
            .isFavorite = true;
      }
      if (_foodFavorite
              .firstWhere((food) => food.foodId == favoriteIdLocal[i])
              .foodType ==
          'เป็นกับข้าว') {
        _foodMenu2
            .firstWhere((food) => food.foodId == favoriteIdLocal[i])
            .isFavorite = true;
      }
      if (_foodFavorite
              .firstWhere((food) => food.foodId == favoriteIdLocal[i])
              .foodType ==
          'เมนูเส้น') {
        _foodMenu3
            .firstWhere((food) => food.foodId == favoriteIdLocal[i])
            .isFavorite = true;
      }
      if (_foodFavorite
              .firstWhere((food) => food.foodId == favoriteIdLocal[i])
              .foodType ==
          'ยำ') {
        _foodMenu4
            .firstWhere((food) => food.foodId == favoriteIdLocal[i])
            .isFavorite = true;
      }
    }
    setLoading(false);
  }

  void addFoodFavorite(String id, int type) {
    _foodFavorite.add(_foodMenuList.firstWhere((food) => food.foodId == id));
    _favoriteId.add(id);
    if (type == 1) {
      _foodMenu1.firstWhere((food) => food.foodId == id).isFavorite = true;
    }
    if (type == 2) {
      _foodMenu2.firstWhere((food) => food.foodId == id).isFavorite = true;
    }
    if (type == 3) {
      _foodMenu3.firstWhere((food) => food.foodId == id).isFavorite = true;
    }
    if (type == 4) {
      _foodMenu4.firstWhere((food) => food.foodId == id).isFavorite = true;
    }
    notifyListeners();
  }

  void removeFoodFavorite(String id, int type) {
    if (type == 1) {
      _foodMenu1.firstWhere((food) => food.foodId == id).isFavorite = false;
    }
    if (type == 2) {
      _foodMenu2.firstWhere((food) => food.foodId == id).isFavorite = false;
    }
    if (type == 3) {
      _foodMenu3.firstWhere((food) => food.foodId == id).isFavorite = false;
    }
    if (type == 4) {
      _foodMenu4.firstWhere((food) => food.foodId == id).isFavorite = false;
    }
    if (type == 5) {
      if (_foodFavorite.firstWhere((food) => food.foodId == id).foodType ==
          'อาหารจานเดียว') {
        _foodMenu1.firstWhere((food) => food.foodId == id).isFavorite = false;
      }
      if (_foodFavorite.firstWhere((food) => food.foodId == id).foodType ==
          'เป็นกับข้าว') {
        _foodMenu2.firstWhere((food) => food.foodId == id).isFavorite = false;
      }
      if (_foodFavorite.firstWhere((food) => food.foodId == id).foodType ==
          'เมนูเส้น') {
        _foodMenu3.firstWhere((food) => food.foodId == id).isFavorite = false;
      }
      if (_foodFavorite.firstWhere((food) => food.foodId == id).foodType ==
          'ยำ') {
        _foodMenu4.firstWhere((food) => food.foodId == id).isFavorite = false;
      }
    }

    _foodFavorite.remove(_foodMenuList.firstWhere((food) => food.foodId == id));
    _favoriteId.remove(id);
    notifyListeners();
  }

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
    mains();
  }

  void mains() async {
    await getFoodMenuList();
    setFavoriteByLocal();
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
