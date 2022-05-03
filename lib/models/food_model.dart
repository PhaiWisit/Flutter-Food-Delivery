// To parse this JSON data, do
//
//     final foodMenuModel = foodMenuModelFromJson(jsonString);

import 'dart:convert';

List<FoodModel> foodMenuModelFromJson(String str) =>
    List<FoodModel>.from(json.decode(str).map((x) => FoodModel.fromJson(x)));

String foodMenuModelToJson(List<FoodModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FoodModel {
  FoodModel({
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

  factory FoodModel.fromJson(Map<String, dynamic> json) => FoodModel(
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
