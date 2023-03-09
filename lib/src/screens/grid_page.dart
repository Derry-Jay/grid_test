import 'package:grid_test/src/widgets/custom_button.dart';

import '../helpers/helper.dart';
import '../widgets/grid_widget.dart';
import 'package:flutter/material.dart';

class GridPage extends StatefulWidget {
  const GridPage({Key? key}) : super(key: key);

  @override
  GridPageState createState() => GridPageState();
}

class GridPageState extends State<GridPage> {
  List<bool> flags = <bool>[];
  String? selectedID;
  Helper get hp => Helper.of(context);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
                backgroundColor: Colors.pinkAccent,
                foregroundColor: Colors.pinkAccent.shade100,
                title: Text('Products')),
            backgroundColor: Colors.pinkAccent.shade100,
            body: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: hp.width / 40),
                child: SizedBox(
                    width: hp.width,
                    height: hp.height,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                              flex: 2,
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    CustomButton(
                                        type: ButtonType.border,
                                        labelColor: selectedID ==
                                                '61ab1ca64a0fef3f27dc663f'
                                            ? Colors.pinkAccent.shade100
                                            : Colors.pinkAccent,
                                        buttonColor: selectedID ==
                                                '61ab1ca64a0fef3f27dc663f'
                                            ? Colors.pinkAccent
                                            : null,
                                        onPressed: () {
                                          setState(() {
                                            selectedID =
                                                '61ab1ca64a0fef3f27dc663f';
                                          });
                                        },
                                        child: Text('Men')),
                                    CustomButton(
                                        type: ButtonType.border,
                                        labelColor: selectedID ==
                                                '61ab1ce24a0fef3f27dc6647'
                                            ? Colors.pinkAccent.shade100
                                            : Colors.pinkAccent,
                                        buttonColor: selectedID ==
                                                '61ab1ce24a0fef3f27dc6647'
                                            ? Colors.pinkAccent
                                            : null,
                                        onPressed: () {
                                          setState(() {
                                            selectedID =
                                                '61ab1ce24a0fef3f27dc6647';
                                          });
                                        },
                                        child: Text('Women')),
                                    CustomButton(
                                        type: ButtonType.border,
                                        labelColor: Colors.pinkAccent,
                                        onPressed: () {
                                          setState(() {
                                            selectedID = null;
                                          });
                                        },
                                        child: Text('Clear'))
                                  ])),
                          const Flexible(flex: 7, child: GridWidget())
                        ])))));
  }
}
