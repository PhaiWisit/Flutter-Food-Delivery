import 'package:flutter/material.dart';
import 'package:flutter_pos_kawpun/screens/merchant/merchant_screen.dart';
import 'package:flutter_pos_kawpun/utils/app_log.dart';

import '../../../utils/text_style.dart';

class HomeCover extends StatelessWidget {
  const HomeCover({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.amber,
      height: 300,
      child: Stack(
        children: [_buildCover(), _buildShopName(context)],
      ),
    );
  }

  Align _buildCover() {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/cover.jpg'),
                fit: BoxFit.cover)),
        height: 180,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius:
                      BorderRadius.only(topRight: Radius.circular(30))),
              height: 50,
              width: 100,
              child: Center(
                  child: Text(
                'ส่งฟรี ',
                style: TextStyle(fontSize: 25, color: Colors.white),
              )),
            ),
          ],
        ),
      ),
    );
  }

  Align _buildShopName(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 0),
        // color: Colors.yellow.shade100,
        height: 120,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              // color: Colors.amber.shade100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.check_circle,
                    color: Colors.green,
                  ),
                  Text(
                    ' ข้าวปุ้นโภชนา ',
                    style: textStyleTitle,
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.info_outline),
                    onPressed: () {
                      Navigator.of(context).pushNamed(MerchantScreen.routeName);
                    },
                  ),
                ],
              ),
            ),
            Text(
              ' อาหารตามสั่ง กับข้าว ราดหน้า และยำ ',
              style: textStyleSmall,
            ),
            Divider(),
            GestureDetector(
              onTap: () {
                AppLog.tap('go to more discount page');
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.discount,
                    size: 14,
                    color: Colors.amber.shade900,
                  ),
                  Text(
                    ' ส่วนลดสูงสุด 35 %',
                    style: textStyleSmall,
                  ),
                  Spacer(),
                  Text(
                    'ดูทั้งหมด >',
                    style:
                        TextStyle(color: Colors.amber.shade900, fontSize: 12),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
