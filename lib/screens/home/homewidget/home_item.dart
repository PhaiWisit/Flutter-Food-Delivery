import 'package:flutter/material.dart';
import 'package:flutter_pos_kawpun/models/food_menu_model.dart';
import 'package:flutter_pos_kawpun/providers/food_menu_provider.dart';
import 'package:flutter_pos_kawpun/utils/textStyle.dart';
import 'package:provider/provider.dart';

class HomeItem extends StatelessWidget {
  const HomeItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var foodMenu = Provider.of<FoodMenuProvider>(context, listen: true);
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
                Text('รายการอาหาร'),
                Spacer(),
                Text('ตัวกรอง'),
                Icon(Icons.expand_more)
              ],
            ),
          ),
          Divider(),
          foodMenu.isLoading
              ? Text('loading...')
              : Container(
                  // color: Colors.amber,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLable(title: 'อาหารจานเดียว'),
                      _buildListMenu(foodMenu.foodMenu1),
                      _buildLable(title: 'เป็นกับข้าว'),
                      _buildListMenu(foodMenu.foodMenu2),
                      _buildLable(title: 'เมนูเส้น'),
                      _buildListMenu(foodMenu.foodMenu3),
                      _buildLable(title: 'เมนูยำ'),
                      _buildListMenu(foodMenu.foodMenu4),
                    ],
                  ),
                )
        ],
      ),
    );
  }

  SingleChildScrollView _buildListMenu(List<FoodMenuModel> foodMenuType) {
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
          return InkWell(
            onTap: (() {
              // tap to detail
            }),
            child: ListTile(
                leading: Container(
                  // height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: NetworkImage(foodMenuType[index].foodImageUrl),
                          fit: BoxFit.cover)),
                ),
                title: Text(foodMenuType[index].foodName),
                subtitle: Text('เริ่มต้น ${foodMenuType[index].foodPrice} บาท'),
                trailing: IconButton(
                  icon: Icon(Icons.favorite_border_sharp),
                  onPressed: () {
                    // tap to favirite this menu
                  },
                )),
          );
        },
      ),
    );
  }

  Padding _buildLable({required String title}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            'collapse',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
