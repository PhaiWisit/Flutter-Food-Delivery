import 'package:flutter/material.dart';

class MerchantScreen extends StatelessWidget {
  static const routeName = '/merchant';
  const MerchantScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Merchant')),
      body: Container(
        child: Text('This is merchant screen'),
      ),
    );
  }
}
