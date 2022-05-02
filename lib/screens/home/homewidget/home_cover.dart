import 'package:flutter/material.dart';

import '../../../utils/textStyle.dart';

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
        children: [_buildCover(), _buildShopName()],
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
        height: 200,
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

  Align _buildShopName() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 0),
        // color: Colors.yellow.shade100,
        height: 100,
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
                    ' ข้าวปุ้นโภชนา (วรารักษ์) ',
                    style: textStyleTitle,
                  ),
                  Spacer(),
                  Icon(Icons.share),
                ],
              ),
            ),
            Text(
              ' อาหารตามสั่ง กับข้าว ราดหน้า และยำ ',
              style: textStyleSmall,
            ),
            Divider(),
            Row(
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
                  style: TextStyle(color: Colors.amber.shade900, fontSize: 12),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
