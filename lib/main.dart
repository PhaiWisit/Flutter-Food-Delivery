// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pos_kawpun/providers/food_provider.dart';
import 'package:flutter_pos_kawpun/screens/food/food_screen.dart';
import 'package:flutter_pos_kawpun/screens/home/home_screen.dart';
import 'package:flutter_pos_kawpun/screens/merchant/merchant_screen.dart';
import 'package:provider/provider.dart';

import 'models/food_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => FoodProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Kawpun Demo',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: HomeScreen(),
        // home: TestGetListMenu(),
        routes: {
          MerchantScreen.routeName: (context) => MerchantScreen(),
          FoodScreen.routeName: (context) => FoodScreen(),
        },
      ),
    );
  }
}

class TestGetListMenu extends StatefulWidget {
  const TestGetListMenu({
    Key? key,
  }) : super(key: key);
  // final String title;
  @override
  State<TestGetListMenu> createState() => _TestGetListMenuState();
}

class _TestGetListMenuState extends State<TestGetListMenu> {
  List _items = [];
  late List<FoodModel> foodMenuModel;

  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/data/kawpun_food.json');
    final data = await json.decode(response);

    setState(() {
      foodMenuModel = foodMenuModelFromJson(response);
      _items = foodMenuModel;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Kawpun Phochana',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            ElevatedButton(
              child: const Text('Load Data'),
              onPressed: readJson,
            ),

            // Display the data loaded from sample.json
            _items.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                      itemCount: _items.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: const EdgeInsets.all(10),
                          child: ListTile(
                            leading: Container(
                                height: 50,
                                width: 50,
                                child: Image.network(
                                    foodMenuModel[index].foodImageUrl)),
                            // // Text(_items[index]["food_id"]),
                            title: Text(foodMenuModel[index].foodName),
                            subtitle: Text(foodMenuModel[index].foodMeat),
                          ),
                        );
                      },
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
