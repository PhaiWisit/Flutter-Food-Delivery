import 'package:flutter/material.dart';
import 'package:flutter_pos_kawpun/screens/merchant/merchantwidget/google_maps.dart';
import 'package:flutter_pos_kawpun/utils/text_style.dart';

class MerchantScreen extends StatelessWidget {
  static const routeName = '/merchant';
  const MerchantScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('รายละเอียดร้านค้า')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            MapSample(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Text(
                    'ร้านข้าวปุ้นโภชนา',
                    style: textStyleHead,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'ที่อยู่ร้าน',
                    style: textStyleTitle,
                  ),
                  Text(
                    '29/724 วรารักษ์ คลองสาม คลองหลวง ปทุมธานี',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: textStyleTitle,
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'เบอร์ติดต่อ',
                    style: textStyleTitle,
                  ),
                  Text(
                    '0987654321',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: textStyleTitle,
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'เวลาทำการจัดส่ง',
                    style: textStyleTitle,
                  ),
                  Text(
                    'ทุกวัน 8:00 - 22:00 น',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: textStyleTitle,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
