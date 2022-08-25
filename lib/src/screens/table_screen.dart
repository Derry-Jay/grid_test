import 'package:flutter/material.dart';
import '../widgets/some_item_list_widget.dart';
import 'package:grid_test/src/helpers/helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  Helper get hp => Helper.of(context);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(title: const Text('Rotator')),
      body: SizedBox(
          height: hp.height,
          width: hp.width,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(flex: 2, child: SomeItemListWidget()),
              ])),
    ));
  }
}
