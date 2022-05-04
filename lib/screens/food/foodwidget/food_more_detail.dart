import 'package:flutter/material.dart';
import 'package:flutter_pos_kawpun/utils/text_style.dart';

class FoodMoreDetail extends StatelessWidget {
  const FoodMoreDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'รายละเอียดเพิ่มเติม',
                style: textStyleTitle,
              ),
            ],
          ),
          _buildTextField(),
          Divider(),
        ],
      ),
    );
  }

  Widget _buildTextField() {
    final maxLines = 3;

    return Container(
      margin: EdgeInsets.all(12),
      height: maxLines * 24.0,
      child: TextField(
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: "เช่น ไม่เผ็ด ไม่ใส่กะเพรา",
          fillColor: Color.fromARGB(255, 235, 235, 235),
          filled: true,
        ),
      ),
    );
  }
}
