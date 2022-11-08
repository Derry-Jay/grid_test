import '../backend/api.dart';
import '../helpers/helper.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  Helper get hp => Helper.of(context);

  Widget mapItem(int i) {
    return Container(
      width: hp.width / i,
      height: hp.height / (i * 2),
      color: hp.theme.dividerColor,
      // padding: const EdgeInsets.only(top: 20, bottom: 15, left: 25, right: 20),
      child: Center(
        child: Text(i.toString(),
            style:
                TextStyle(color: hp.theme.toggleableActiveColor, fontSize: 20)),
      ),
    );
  }

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
                Expanded(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: getNumbers(3).map<Widget>(mapItem).toList())),
              ])),
    ));
  }
}
