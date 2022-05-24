import 'dart:math';
import 'package:flutter/material.dart';
import 'package:grid_test/src/middle_tier/api.dart';

class GridPage extends StatefulWidget {
  const GridPage({Key? key}) : super(key: key);

  @override
  GridPageState createState() => GridPageState();
}

class GridPageState extends State<GridPage> {
  MediaQueryData get dimensions => MediaQuery.of(context);
  Size get size => dimensions.size;
  double get height => size.height;
  double get width => size.width;
  double get radius => sqrt(pow(width, 2) + pow(height, 2));
  List<bool> flags = [false, false, false];
  Widget valueBuilder(BuildContext context, AsyncSnapshot<int> value) {
    return Text(value.data.toString());
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(),
            backgroundColor: Colors.pinkAccent.shade100,
            body: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: width / 50),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Value'),
                      StreamBuilder<int>(
                          builder: valueBuilder,
                          stream: getValues(2),
                          initialData: 0)
                    ]))));
  }
}
