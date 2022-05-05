import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/basket_provider.dart';

class BasketScreen extends StatelessWidget {
  static const routeName = '/basket';
  const BasketScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var basket = Provider.of<BasketProvider>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: Text('ตะกร้าของคุณ'),
      ),
      body: ListView.builder(
          itemCount: basket.basketItem.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Text(basket.basketItem[index].foodId.toString()),
              title: Text(basket.basketItem[index].foodName +
                  basket.basketItem[index].foodExtra),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('เนื้อสัตว์ : ${basket.basketItem[index].foodMeat}'),
                  basket.basketItem[index].foodNoodle.isNotEmpty
                      ? Text('เส้น : ${basket.basketItem[index].foodNoodle}')
                      : SizedBox(),
                  basket.basketItem[index].foodOption.isNotEmpty
                      ? Text('เพิ่ม : ${basket.basketItem[index].foodOption}')
                      : SizedBox(),
                  basket.basketItem[index].foodDetail.isNotEmpty
                      ? Text(
                          'รายละเอียด : ${basket.basketItem[index].foodDetail}')
                      : SizedBox()
                ],
              ),
              trailing:
                  Text(basket.basketItem[index].foodPrice.toString() + ' B'),
            );
          }),
    );
  }
}
