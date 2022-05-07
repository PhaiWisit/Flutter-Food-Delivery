// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:flutter_pos_kawpun/services/send_order.dart';

import '../services/api_status.dart';
import '../utils/app_log.dart';

class BasketItem {
  final int foodId;
  final String foodName;
  final double foodPrice;
  final String foodMeat;
  final String foodOption;
  final String foodExtra;
  final String foodNoodle;
  final String foodDetail;

  BasketItem({
    required this.foodId,
    required this.foodName,
    required this.foodPrice,
    required this.foodMeat,
    required this.foodOption,
    required this.foodExtra,
    required this.foodNoodle,
    required this.foodDetail,
  });
}

class TestData {
  static final List<BasketItem> _listTest = [];

  static List<BasketItem> get listTest {
    for (int i = 0; i < 10; i++) {
      _listTest.add(
        BasketItem(
            foodId: 0,
            foodName: 'foodName',
            foodPrice: 100,
            foodMeat: 'foodMeat',
            foodOption: 'foodOption',
            foodExtra: 'foodExtra',
            foodNoodle: 'foodNoodle',
            foodDetail: ''),
      );
    }

    return _listTest;
  }
}

class BasketProvider with ChangeNotifier {
  // List<BasketItem> _basketItem = TestData.listTest; // Test
  List<BasketItem> _basketItem = []; // Use
  int _basketCount = 0;

  int _foodId = 1;
  String _foodName = '';
  double _foodPrice = 0.0;
  String _foodMeat = '';
  String _foodOption = '';
  String _foodExtra = '';
  String _foodNoodle = '';
  String _foodDetail = '';

  double _foodPriceStart = 0.0;
  int _optionCount = 0;
  bool _isExtra = false;
  double _totalPrice = 0.0;
  String _houseNumber = '';
  bool _sendLoading = false;

  List<BasketItem> get basketItem => _basketItem;
  int get basketCount {
    return basketItem.length;
  }

  int get foodId => _foodId;
  String get foodName => _foodName;

  String get foodMeat => _foodMeat;
  String get foodOption => _foodOption;
  String get foodExtra => _foodExtra;
  String get foodNoodle => _foodNoodle;
  String get foodDetail => _foodDetail;

  double get foodPriceStart => _foodPrice;
  int get optionCount => _optionCount;
  bool get isExtra => _isExtra;
  String get houseNumber => _houseNumber;
  bool get sendLoading => _sendLoading;

  double get totalPrice {
    double total = 0.0;
    for (int i = 0; i < basketItem.length; i++) {
      total += basketItem[i].foodPrice;
    }
    return total;
  }

  double get foodPrice {
    if (isExtra) {
      _foodPrice = _foodPriceStart + (10 * optionCount) + 10;
    } else {
      _foodPrice = _foodPriceStart + (10 * optionCount);
    }

    return _foodPrice;
  }

  void sendOrder(String orderText, BuildContext context) async {
    setSendLoading(true);
    var response = await SendOrder.sendOrder(orderText);
    if (response is Success) {
      const snackBar = SnackBar(
        content: Text('ร้านค้าได้รับคำสั่งซื้อของคุณแล้ว'),
        duration: Duration(milliseconds: 1500),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      resetBasketItem();
      Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
    }
    if (response is Failure) {
      var snackBar = SnackBar(
        content: Text('เกิดข้อผิดพลาด  ${response.errorResponse.toString()}'),
        duration: Duration(milliseconds: 1500),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    setSendLoading(false);
  }

  void setSendLoading(bool sendLoading) {
    _sendLoading = sendLoading;
    notifyListeners();
  }

  void setHouseNumber(String houseNumber) {
    _houseNumber = houseNumber;
  }

  void removeItem(int index) {
    _basketItem.removeAt(index);
    notifyListeners();
  }

  void setIsExtra(bool isExtra) {
    _isExtra = isExtra;
    notifyListeners();
  }

  void setOptionCount(int optionCount) {
    _optionCount = optionCount;
    notifyListeners();
  }

  void setFoodPriceStart(double foodPriceStart) {
    _foodPriceStart = foodPriceStart;
    AppLog.info(_foodPrice.toString());
    notifyListeners();
  }

  // Not need to edit
  void setFoodId(int id) {
    _foodId = id;
  }

  void setFoodName(String foodName) {
    _foodName = foodName;
  }

  void setFoodMeat(String foodMeat) {
    _foodMeat = foodMeat;
  }

  void setFoodOption(String foodOption) {
    _foodOption = foodOption;
  }

  void setFoodExtra(String foodExtra) {
    _foodExtra = foodExtra;
  }

  void setFoodNoodle(String foodNoodle) {
    _foodNoodle = foodNoodle;
  }

  void setFoodDetail(String foodDetail) {
    _foodDetail = foodDetail;
  }

  void addFoodToBasket() {
    _basketItem.add(BasketItem(
        foodId: _foodId,
        foodName: _foodName,
        foodPrice: _foodPrice,
        foodMeat: _foodMeat,
        foodOption: _foodOption,
        foodExtra: _foodExtra,
        foodNoodle: _foodNoodle,
        foodDetail: _foodDetail));
    _foodId++;
    notifyListeners();
  }

  void resetItem() {
    _foodName = '';
    _foodPrice = 0.0;
    _foodMeat = '';
    _foodOption = '';
    _foodExtra = '';
    _foodNoodle = '';
    _foodDetail = '';
    _optionCount = 0;
    _isExtra = false;
    _foodPriceStart = 0.0;
  }

  void resetBasketItem() {
    _basketItem = [];
    _basketCount = 0;
    _foodId = 1;
    _foodName = '';
    _foodPrice = 0.0;
    _foodMeat = '';
    _foodOption = '';
    _foodExtra = '';
    _foodNoodle = '';
    _foodDetail = '';
    _foodPriceStart = 0.0;
    _optionCount = 0;
    _isExtra = false;
    _totalPrice = 0.0;
    _houseNumber = '';
  }
}
