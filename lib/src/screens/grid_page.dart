import '../helpers/helper.dart';
import '../widgets/grid_widget.dart';
import 'package:flutter/material.dart';

class GridPage extends StatefulWidget {
  const GridPage({Key? key}) : super(key: key);

  @override
  GridPageState createState() => GridPageState();
}

class GridPageState extends State<GridPage> {
  Helper get hp => Helper.of(context);
  List<bool> flags = <bool>[];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(),
            backgroundColor: Colors.pinkAccent.shade100,
            body: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: hp.width / 50),
                child: SizedBox(
                    width: hp.width,
                    height: hp.height,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Flexible(child: Text('Value')),
                          Flexible(child: GridWidget())
                        ])))));
  }
}
