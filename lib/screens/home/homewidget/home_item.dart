import 'package:flutter/material.dart';
import 'package:flutter_pos_kawpun/models/food_model.dart';
import 'package:flutter_pos_kawpun/providers/food_provider.dart';
import 'package:flutter_pos_kawpun/screens/food/food_screen.dart';
import 'package:flutter_pos_kawpun/utils/app_log.dart';
import 'package:flutter_pos_kawpun/utils/text_style.dart';
import 'package:provider/provider.dart';

class HomeItem extends StatefulWidget {
  const HomeItem({Key? key}) : super(key: key);

  @override
  State<HomeItem> createState() => _HomeItemState();
}

class _HomeItemState extends State<HomeItem> {
  @override
  Widget build(BuildContext context) {
    // FoodProvider foodMenu = Provider.of<FoodProvider>(context, listen: false);

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
                    return Text('รายการโปรด');
                  }
                  if (foodMenu.filterStatus[FilterOption.Dishes] == true) {
                    return Text('เป็นกับข้าว');
                  }
                  if (foodMenu.filterStatus[FilterOption.Onedish] == true) {
                    return Text('อาหารจานเดียว');
                  }
                  if (foodMenu.filterStatus[FilterOption.Noodle] == true) {
                    return Text('เมนูเส้น');
                  }
                  if (foodMenu.filterStatus[FilterOption.Yum] == true) {
                    return Text('เมนูยำ');
                  }
                  return Text('รายการอาหารทั้งหมด');
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
                          _buildListMenu(foodMenu.foodMenu1)
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
                          _buildListMenu(foodMenu.foodMenu2)
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
                          _buildListMenu(foodMenu.foodMenu3)
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
                          _buildListMenu(foodMenu.foodMenu4)
                        ],
                      );
                    } else if (foodMenu.filterStatus[FilterOption.Favorites] ==
                        true) {
                      return Column(
                        children: [Text('favorite')],
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
                              ? _buildListMenu(foodMenu.foodMenu1)
                              : SizedBox(),
                          Divider(),
                          _buildLable(
                              title: 'เป็นกับข้าว',
                              foodMenu: foodMenu,
                              filterOption: FilterOption.Dishes,
                              canExpand: true),
                          foodMenu.expandStatus[FilterOption.Dishes] == true
                              ? _buildListMenu(foodMenu.foodMenu2)
                              : SizedBox(),
                          Divider(),
                          _buildLable(
                              title: 'เมนูเส้น',
                              foodMenu: foodMenu,
                              filterOption: FilterOption.Noodle,
                              canExpand: true),
                          foodMenu.expandStatus[FilterOption.Noodle] == true
                              ? _buildListMenu(foodMenu.foodMenu3)
                              : SizedBox(),
                          Divider(),
                          _buildLable(
                              title: 'เมนูยำ',
                              foodMenu: foodMenu,
                              filterOption: FilterOption.Yum,
                              canExpand: true),
                          foodMenu.expandStatus[FilterOption.Yum] == true
                              ? _buildListMenu(foodMenu.foodMenu4)
                              : SizedBox(),
                          Divider(),
                        ],
                      );
                    }
                  }));
          })
        ],
      ),
    );
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
          Text(
            'หมวดหมู่',
            style: textStyleSmall,
          ),
          Icon(Icons.expand_more)
        ],
      ),
      itemBuilder: (_) => [
        PopupMenuItem(
          child: Text('ทั้งหมด'),
          value: FilterOption.All,
        ),
        PopupMenuItem(
          child: Text('รายการโปรด'),
          value: FilterOption.Favorites,
        ),
        PopupMenuItem(
          child: Text('อาหารจานดียว'),
          value: FilterOption.Onedish,
        ),
        PopupMenuItem(
          child: Text('เป็นกับข้าว'),
          value: FilterOption.Dishes,
        ),
        PopupMenuItem(
          child: Text('เมนูเส้น'),
          value: FilterOption.Noodle,
        ),
        PopupMenuItem(
          child: Text('เมนูยำ'),
          value: FilterOption.Yum,
        ),
      ],
    );
  }

  SingleChildScrollView _buildListMenu(List<FoodModel> foodMenuType) {
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
                  title: Text(foodMenuType[index].foodName),
                  subtitle:
                      Text('เริ่มต้น ${foodMenuType[index].foodPrice} บาท'),
                  trailing: IconButton(
                    icon: Icon(Icons.favorite_border_sharp),
                    onPressed: () {
                      AppLog.tap('set favorite this menu');
                    },
                  )),
            );
          });
        },
      ),
    );
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
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Builder(builder: (context) {
              if (canExpand) {
                if (foodMenu.expandStatus[filterOption] == true) {
                  return Text(
                    'collapse',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  );
                } else {
                  return Text(
                    'expand',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
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
