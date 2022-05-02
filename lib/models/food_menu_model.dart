// To parse this JSON data, do
//
//     final foodMenuModel = foodMenuModelFromJson(jsonString);

import 'dart:convert';

List<FoodMenuModel> foodMenuModelFromJson(String str) =>
    List<FoodMenuModel>.from(
        json.decode(str).map((x) => FoodMenuModel.fromJson(x)));

String foodMenuModelToJson(List<FoodMenuModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FoodMenuModel {
  FoodMenuModel({
    required this.foodId,
    required this.foodName,
    required this.foodType,
    required this.foodMeat,
    required this.foodOption,
    required this.foodExtra,
    required this.foodNoodles,
    required this.foodPrice,
    required this.foodImageUrl,
  });

  String foodId;
  String foodName;
  String foodType;
  String foodMeat;
  String foodOption;
  String foodExtra;
  String foodNoodles;
  String foodPrice;
  String foodImageUrl;

  factory FoodMenuModel.fromJson(Map<String, dynamic> json) => FoodMenuModel(
        foodId: json["food_id"],
        foodName: json["food_name"],
        foodType: json["food_type"],
        foodMeat: json["food_meat"],
        foodOption: json["food_option"],
        foodExtra: json["food_extra"],
        foodNoodles: json["food_noodles"],
        foodPrice: json["food_price"],
        foodImageUrl: json["food_imageURL"],
      );

  Map<String, dynamic> toJson() => {
        "food_id": foodId,
        "food_name": foodName,
        "food_type": foodType,
        "food_meat": foodMeat,
        "food_option": foodOption,
        "food_extra": foodExtra,
        "food_noodles": foodNoodles,
        "food_price": foodPrice,
        "food_imageURL": foodImageUrl,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap ??= map.map((k, v) => new MapEntry(v, k));
    return reverseMap!;
  }
}
