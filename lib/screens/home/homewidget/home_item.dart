import 'package:flutter/material.dart';
import 'package:flutter_pos_kawpun/models/food_model.dart';
import 'package:flutter_pos_kawpun/providers/food_provider.dart';
import 'package:flutter_pos_kawpun/screens/food/food_screen.dart';
import 'package:flutter_pos_kawpun/utils/app_log.dart';
import 'package:flutter_pos_kawpun/utils/text_style.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../providers/basket_provider.dart';

class HomeItem extends StatefulWidget {
  const HomeItem({Key? key}) : super(key: key);

  @override
  State<HomeItem> createState() => _HomeItemState();
}

class _HomeItemState extends State<HomeItem> {
  @override
  Widget build(BuildContext context) {
    // FoodProvider foodMenu = Provider.of<FoodProvider>(context, listen: false)
    return Padding(
      padding: const EdgeInsets.only(top: 0, left: 10, right: 10, bottom: 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 40,
            // color: Colors.amber,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Consumer<FoodProvider>(builder: ((context, foodMenu, child) {
                  if (foodMenu.filterStatus[FilterOption.Favorites] == true) {
                    return Text('รายการโปรด', style: textStyleNormal);
                  }
                  if (foodMenu.filterStatus[FilterOption.Dishes] == true) {
                    return Text('เป็นกับข้าว', style: textStyleNormal);
                  }
                  if (foodMenu.filterStatus[FilterOption.Onedish] == true) {
                    return Text('อาหารจานเดียว', style: textStyleNormal);
                  }
                  if (foodMenu.filterStatus[FilterOption.Noodle] == true) {
                    return Text('เมนูเส้น', style: textStyleNormal);
                  }
                  if (foodMenu.filterStatus[FilterOption.Yum] == true) {
                    return Text('เมนูยำ', style: textStyleNormal);
                  }
                  return Text('รายการอาหารทั้งหมด', style: textStyleNormal);
                })),
                Spacer(),
                Consumer<FoodProvider>(
                  builder: ((context, foodMenu, child) {
                    return _buildPopupMenu(context, foodMenu);
                  }),
                ),
              ],
            ),
          ),
          Divider(),
          Consumer<FoodProvider>(builder: (context, foodMenu, child) {
            return foodMenu.isLoading
                ? Text('loading...')
                : Consumer<FoodProvider>(builder: ((context, foodMenu, child) {
                    if (foodMenu.filterStatus[FilterOption.Onedish] == true) {
                      return Column(
                        children: [
                          _buildLable(
                              title: 'อาหารจานเดียว',
                              foodMenu: foodMenu,
                              filterOption: FilterOption.Dishes,
                              canExpand: false),
                          _buildListMenu(foodMenu.foodMenu1, 1),
                          SizedBox(
                            height: 60,
                          )
                        ],
                      );
                    } else if (foodMenu.filterStatus[FilterOption.Dishes] ==
                        true) {
                      return Column(
                        children: [
                          _buildLable(
                              title: 'เป็นกับข้าว',
                              foodMenu: foodMenu,
                              filterOption: FilterOption.Dishes,
                              canExpand: false),
                          _buildListMenu(foodMenu.foodMenu2, 2),
                          SizedBox(
                            height: 60,
                          )
                        ],
                      );
                    } else if (foodMenu.filterStatus[FilterOption.Noodle] ==
                        true) {
                      return Column(
                        children: [
                          _buildLable(
                              title: 'เมนูเส้น',
                              foodMenu: foodMenu,
                              filterOption: FilterOption.Noodle,
                              canExpand: false),
                          _buildListMenu(foodMenu.foodMenu3, 3),
                          SizedBox(
                            height: 60,
                          )
                        ],
                      );
                    } else if (foodMenu.filterStatus[FilterOption.Yum] ==
                        true) {
                      return Column(
                        children: [
                          _buildLable(
                              title: 'เมนูยำ',
                              foodMenu: foodMenu,
                              filterOption: FilterOption.Yum,
                              canExpand: false),
                          _buildListMenu(foodMenu.foodMenu4, 4),
                          SizedBox(
                            height: 60,
                          )
                        ],
                      );
                    } else if (foodMenu.filterStatus[FilterOption.Favorites] ==
                        true) {
                      return Column(
                        children: [
                          _buildLable(
                              title: 'รายการโปรด',
                              foodMenu: foodMenu,
                              filterOption: FilterOption.Yum,
                              canExpand: false),
                          _buildListMenu(foodMenu.foodFavorite, 5),
                          SizedBox(
                            height: 60,
                          )
                        ],
                      );
                    } else {
                      return Column(
                        children: [
                          _buildLable(
                              title: 'อาหารจานเดียว',
                              foodMenu: foodMenu,
                              filterOption: FilterOption.Onedish,
                              canExpand: true),
                          foodMenu.expandStatus[FilterOption.Onedish] == true
                              ? _buildListMenu(foodMenu.foodMenu1, 1)
                              : SizedBox(),
                          Divider(),
                          _buildLable(
                              title: 'เป็นกับข้าว',
                              foodMenu: foodMenu,
                              filterOption: FilterOption.Dishes,
                              canExpand: true),
                          foodMenu.expandStatus[FilterOption.Dishes] == true
                              ? _buildListMenu(foodMenu.foodMenu2, 2)
                              : SizedBox(),
                          Divider(),
                          _buildLable(
                              title: 'เมนูเส้น',
                              foodMenu: foodMenu,
                              filterOption: FilterOption.Noodle,
                              canExpand: true),
                          foodMenu.expandStatus[FilterOption.Noodle] == true
                              ? _buildListMenu(foodMenu.foodMenu3, 3)
                              : SizedBox(),
                          Divider(),
                          _buildLable(
                              title: 'เมนูยำ',
                              foodMenu: foodMenu,
                              filterOption: FilterOption.Yum,
                              canExpand: true),
                          foodMenu.expandStatus[FilterOption.Yum] == true
                              ? _buildListMenu(foodMenu.foodMenu4, 4)
                              : SizedBox(),
                          Divider(),
                          SizedBox(
                            height: 60,
                          )
                        ],
                      );
                    }
                  }));
          })
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  void onSetFavoriteLocal(List<String> listId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('favoriteId', listId);
    // final List<String> favoriteId = prefs.getStringList('favoriteId') ?? [''];
    // if (favoriteId.isNotEmpty) {
    //   for (int i = 0; i < favoriteId.length; i++) {
    //     AppLog.info(favoriteId[i]);
    //   }
    // }
  }

  Widget _buildPopupMenu(BuildContext context, FoodProvider foodMenu) {
    return PopupMenuButton(
      onSelected: (FilterOption selectedValue) {
        if (selectedValue == FilterOption.Onedish) {
          foodMenu.setFilterStatus(FilterOption.Onedish, true);
        } else if (selectedValue == FilterOption.Dishes) {
          foodMenu.setFilterStatus(FilterOption.Dishes, true);
        } else if (selectedValue == FilterOption.Noodle) {
          foodMenu.setFilterStatus(FilterOption.Noodle, true);
        } else if (selectedValue == FilterOption.Yum) {
          foodMenu.setFilterStatus(FilterOption.Yum, true);
        } else if (selectedValue == FilterOption.Favorites) {
          foodMenu.setFilterStatus(FilterOption.Favorites, true);
        } else if (selectedValue == FilterOption.All) {
          foodMenu.setFilterStatus(FilterOption.All, true);
        }
      },
      child: Row(
        children: [
          Text('หมวดหมู่', style: textStyleSmall),
          Icon(Icons.expand_more)
        ],
      ),
      itemBuilder: (_) => [
        PopupMenuItem(
          child: Text('ทั้งหมด', style: textStyleNormal),
          value: FilterOption.All,
        ),
        PopupMenuItem(
          child: Text('รายการโปรด', style: textStyleNormal),
          value: FilterOption.Favorites,
        ),
        PopupMenuItem(
          child: Text('อาหารจานดียว', style: textStyleNormal),
          value: FilterOption.Onedish,
        ),
        PopupMenuItem(
          child: Text('เป็นกับข้าว', style: textStyleNormal),
          value: FilterOption.Dishes,
        ),
        PopupMenuItem(
          child: Text('เมนูเส้น', style: textStyleNormal),
          value: FilterOption.Noodle,
        ),
        PopupMenuItem(
          child: Text('เมนูยำ', style: textStyleNormal),
          value: FilterOption.Yum,
        ),
      ],
    );
  }

  SingleChildScrollView _buildListMenu(
      List<FoodModel> foodMenuType, int foodType) {
    FoodProvider foodPro = Provider.of<FoodProvider>(context, listen: true);
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: ListView.separated(
        separatorBuilder: (context, index) {
          return Divider();
        },
        padding: EdgeInsets.zero,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: foodMenuType.length,
        itemBuilder: (context, index) {
          return Consumer<FoodProvider>(builder: (context, foodMenu, child) {
            return InkWell(
              onTap: (() {
                foodMenu.setSelectFood(foodMenuType[index]);
                var basket =
                    Provider.of<BasketProvider>(context, listen: false);
                basket.setFoodPriceStart(
                    double.parse(foodMenu.selectFood.foodPrice));
                Navigator.of(context).pushNamed(FoodScreen.routeName);
              }),
              child: ListTile(
                  leading: Container(
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image:
                                NetworkImage(foodMenuType[index].foodImageUrl),
                            fit: BoxFit.cover)),
                  ),
                  title: Text(foodMenuType[index].foodName,
                      style: textStyleNormal),
                  subtitle: Text(
                      'เริ่มต้น ${foodMenuType[index].foodPrice} บาท',
                      style: textStyleSmall),
                  trailing: IconButton(
                    icon: Icon(
                      foodMenuType[index].isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border_sharp,
                      color: Colors.red.shade400,
                    ),
                    onPressed: () {
                      if (foodMenuType[index].isFavorite) {
                        foodPro.removeFoodFavorite(
                            foodMenuType[index].foodId, foodType);
                      } else {
                        foodPro.addFoodFavorite(
                            foodMenuType[index].foodId, foodType);
                      }
                      onSetFavoriteLocal(foodPro.favoriteId);
                    },
                  )),
            );
          });
        },
      ),
    );
  }

  @override
  void deactivate() {
    super.deactivate();
    FoodProvider foodPro = Provider.of<FoodProvider>(context, listen: true);
  }

  @override
  void dispose() {
    super.dispose();
  }

  Padding _buildLable(
      {required String title,
      required FoodProvider foodMenu,
      required FilterOption filterOption,
      required bool canExpand}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          if (canExpand) {
            if (foodMenu.expandStatus[filterOption] == false) {
              foodMenu.setExpandStatus(filterOption, true);
            } else {
              foodMenu.setExpandStatus(filterOption, false);
            }
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: textStyleNormalBold,
            ),
            Builder(builder: (context) {
              if (canExpand) {
                if (foodMenu.expandStatus[filterOption] == true) {
                  return Text(
                    'collapse',
                    style: textStyleSmallGrey,
                  );
                } else {
                  return Text(
                    'expand',
                    style: textStyleSmallGrey,
                  );
                }
              } else {
                return SizedBox();
              }
            }),
          ],
        ),
      ),
    );
  }
}
