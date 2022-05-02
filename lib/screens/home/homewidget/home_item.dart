import 'package:flutter/material.dart';
import 'package:flutter_pos_kawpun/providers/food_menu_provider.dart';
import 'package:provider/provider.dart';

class HomeItem extends StatelessWidget {
  const HomeItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var foodMenu = Provider.of<FoodMenuProvider>(context, listen: true);
    return Padding(
      padding: const EdgeInsets.only(top: 0, left: 10, right: 10, bottom: 0),
      child: Column(
        children: [
          Container(
            height: 40,
            // color: Colors.amber,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [Text('ตัวกรอง'), Icon(Icons.expand_more)],
            ),
          ),
          foodMenu.isLoading
              ? Text('loading...')
              : Container(
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                    itemCount: foodMenu.foodMenuList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        // margin: const EdgeInsets.all(10),
                        child: ListTile(
                          leading: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                // color: Colors.amber,
                                image: DecorationImage(
                                    image: NetworkImage(foodMenu
                                        .foodMenuList[index].foodImageUrl),
                                    fit: BoxFit.cover)),
                          ),
                          title: Text(foodMenu.foodMenuList[index].foodName),
                          subtitle: Text(
                              'เริ่มต้น ${foodMenu.foodMenuList[index].foodPrice} บาท'),
                          trailing: Icon(Icons.favorite_border_sharp),
                        ),
                      );
                    },
                  ),
                )
        ],
      ),
    );
  }
}
