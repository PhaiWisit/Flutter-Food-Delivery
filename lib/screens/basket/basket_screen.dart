// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_pos_kawpun/utils/app_log.dart';
import 'package:flutter_pos_kawpun/utils/text_style.dart';
import 'package:provider/provider.dart';

import '../../providers/basket_provider.dart';
import 'package:http/http.dart' as http;

class BasketScreen extends StatelessWidget {
  static const routeName = '/basket';
  const BasketScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var basket = Provider.of<BasketProvider>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: Text('ตะกร้าของคุณ', style: textStyleTitleWhite),
      ),
      body: Column(
        children: [
          _buildHouseNumber(context),
          _buildListItem(context),
        ],
      ),
      bottomSheet: _buildBottomSheet(basket, context),
    );
  }

  Container _buildBottomSheet(BasketProvider basket, BuildContext context) {
    return Container(
      height: 70,
      padding: EdgeInsets.symmetric(horizontal: 10),
      // color: Colors.amber,
      child: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Spacer(),
          Container(
            child: Text(
              basket.totalPrice.toString() + ' บาท',
              style: textStyleNormal,
            ),
          ),
          Spacer(),
          Container(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.3,
              child: ElevatedButton(
                onPressed: null,
                child: Text('    ชำระเงิน\n(ปิดปรับปรุง)',
                    style: textStyleSmallWhite),
              )),
          SizedBox(
            width: 10,
          ),
          Container(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.3,
              child: ElevatedButton(
                onPressed: basket.sendLoading
                    ? null
                    : () {
                        if (basket.houseNumber.isNotEmpty) {
                          orderNow(context);
                        } else if (basket.basketCount == 0) {
                          const snackBar = SnackBar(
                            content: Text('ตะกร้าสินค้าว่าง กรุณาเพิ่มสินค้า '),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else {
                          const snackBar = SnackBar(
                            content: Text('กรุณาใส่บ้านเลขที่ '),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      },
                child: basket.sendLoading
                    ? Container(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator())
                    : Text('    สั่งเลย\n(เก็บเงินสด)',
                        style: textStyleSmallWhite),
              )),
        ],
      )),
    );
  }

  void orderNow(BuildContext context) async {
    var basket = Provider.of<BasketProvider>(context, listen: false);
    var basketItem = basket.basketItem;
    String sendText = 'เก็บเงินสด \nบ้านเลขที่ ${basket.houseNumber} \n\n';
    for (int i = 0; i < basket.basketCount; i++) {
      String orderNumber = (i + 1).toString();
      String orderName = basketItem[i].foodName;
      String orderExtra = basketItem[i].foodExtra;

      String orderMeat() {
        if (basketItem[i].foodMeat.isEmpty) {
          return '';
        } else {
          return '  เนื้อสัตว์ : ${basketItem[i].foodMeat} \n';
        }
      }

      String orderOption() {
        if (basketItem[i].foodOption.isEmpty) {
          return '';
        } else {
          return '  เพิ่ม : ${basketItem[i].foodOption} \n';
        }
      }

      String orderNoodle() {
        if (basketItem[i].foodNoodle.isEmpty) {
          return '';
        } else {
          return '  เส้น : ${basketItem[i].foodNoodle} \n';
        }
      }

      String orderDetail() {
        if (basketItem[i].foodDetail.isEmpty) {
          return '';
        } else {
          return '  รายละเอียด : ${basketItem[i].foodDetail} \n';
        }
      }

      String orderPrice = '  ราคา : ${basketItem[i].foodPrice} \n';

      sendText +=
          "${orderNumber}.${orderName}${orderExtra} \n${orderMeat()}${orderOption()}${orderNoodle()}${orderDetail()}${orderPrice} \n";
    }

    sendText = sendText + 'ยอดรวม : ${basket.totalPrice} บาท';

    basket.sendOrder(sendText, context);

    // AppLog.info(sendText);
  }

  Container _buildListItem(BuildContext context) {
    var basket = Provider.of<BasketProvider>(context, listen: true);
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey.shade300, borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.symmetric(horizontal: 25),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      height: MediaQuery.of(context).size.height * 0.60,
      child: ListView.separated(
          separatorBuilder: ((context, index) {
            return Divider(
              color: Colors.green,
            );
          }),
          itemCount: basket.basketItem.length,
          itemBuilder: (context, index) {
            return Dismissible(
              key: UniqueKey(),
              background: Container(
                color: Colors.red.shade300,
                child: Icon(
                  Icons.delete_forever,
                  color: Colors.white,
                  size: 40,
                ),
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(right: 20),
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              ),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                Provider.of<BasketProvider>(context, listen: false)
                    .removeItem(index);
              },
              child: ListTile(
                // leading: Text(basket.basketItem[index].foodId.toString()),
                title: Text(
                    basket.basketItem[index].foodName +
                        basket.basketItem[index].foodExtra,
                    style: textStyleNormal),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    basket.basketItem[index].foodMeat.isNotEmpty
                        ? Text(
                            'เนื้อสัตว์ : ${basket.basketItem[index].foodMeat}',
                            style: textStyleSubTitleGrey)
                        : SizedBox(),
                    basket.basketItem[index].foodNoodle.isNotEmpty
                        ? Text('เส้น : ${basket.basketItem[index].foodNoodle}',
                            style: textStyleSubTitleGrey)
                        : SizedBox(),
                    basket.basketItem[index].foodOption.isNotEmpty
                        ? Text('เพิ่ม : ${basket.basketItem[index].foodOption}',
                            style: textStyleSubTitleGrey)
                        : SizedBox(),
                    basket.basketItem[index].foodDetail.isNotEmpty
                        ? Text(
                            'รายละเอียด : ${basket.basketItem[index].foodDetail}',
                            style: textStyleSubTitleGrey)
                        : SizedBox()
                  ],
                ),
                trailing: Text(
                  basket.basketItem[index].foodPrice.toString() + ' B',
                  style: textStyleNormal,
                ),
              ),
            );
          }),
    );
  }

  Container _buildHouseNumber(BuildContext context) {
    var basket = Provider.of<BasketProvider>(context, listen: false);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      // height: MediaQuery.of(context).size.height * 0.15,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'ที่อยู่จัดส่ง ',
            style: textStyleNormal,
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            // height: 50,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    textInputAction: TextInputAction.go,
                    onSubmitted: (value) {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    onChanged: (value) {
                      basket.setHouseNumber(value);
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'บ้านเลขที่ ',
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
