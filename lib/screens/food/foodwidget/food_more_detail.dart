import 'package:flutter/material.dart';
import 'package:flutter_pos_kawpun/utils/text_style.dart';
import 'package:provider/provider.dart';

import '../../../providers/basket_provider.dart';

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
          _buildTextField(context),
          Divider(),
        ],
      ),
    );
  }

  Widget _buildTextField(BuildContext context) {
    var basket = Provider.of<BasketProvider>(context, listen: true);
    const maxLines = 3;

    return Container(
      margin: EdgeInsets.all(12),
      height: maxLines * 24.0,
      child: TextField(
        maxLines: maxLines,
        textInputAction: TextInputAction.go,
        onSubmitted: (value) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        onChanged: (value) {
          if (value.isEmpty) {
            basket.setFoodDetail('');
          } else {
            basket.setFoodDetail(value);
          }
        },
        decoration: InputDecoration(
          hintText: "เช่น ไม่เผ็ด ไม่ใส่กะเพรา",
          fillColor: Color.fromARGB(255, 235, 235, 235),
          filled: true,
        ),
      ),
    );
  }
}
