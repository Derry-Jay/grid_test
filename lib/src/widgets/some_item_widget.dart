import 'package:grid_test/src/model/some_item.dart';

import '../helpers/helper.dart';
import '../screens/first_page.dart';
import 'package:flutter/material.dart';

class SomeItemWidget extends StatefulWidget {
  final SomeItem item;
  final int index;
  const SomeItemWidget({Key? key, required this.item, required this.index})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => SomeItemWidgetState();

  static FirstPageState? of(BuildContext context) =>
      context.findAncestorStateOfType<FirstPageState>();
}

class SomeItemWidgetState extends State<SomeItemWidget> {
  FirstPageState? get fps => SomeItemWidget.of(context);
  Helper get hp => Helper.of(context);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
        child: Card(
            // shape: RoundedRectangleBorder(
            //     side: BorderSide(
            //         color: fps!.flags[widget.index]
            //             ? (fps!.flags.length - widget.index == 1
            //                 ? Colors.pink
            //                 : Colors.blue)
            //             : Colors.transparent),
            //     borderRadius:
            //         BorderRadius.all(Radius.circular(hp.radius / 40))),
            child: Column(
          children: [
            // Row(children: [
            //   const SizedBox(),
            //   Container(
            //       decoration: BoxDecoration(
            //           color: fps!.flags[widget.index]
            //               ? (fps!.flags.length - widget.index == 1
            //                   ? Colors.pink
            //                   : Colors.blue)
            //               : Colors.white,
            //           borderRadius: BorderRadius.only(
            //               bottomRight: Radius.circular(hp.radius / 50),
            //               topLeft: Radius.circular(hp.radius / 40))),
            //       child: const Icon(
            //         Icons.check,
            //         color: Colors.white,
            //       ))
            // ]),
            // Expanded(
            //     flex: 1,
            //     child: Text(widget.content.first,
            //         style: const TextStyle(fontWeight: FontWeight.w700))),
            // Expanded(
            //     flex: 2,
            //     child: Text(widget.content.last,
            //         style: const TextStyle(
            //             fontWeight: FontWeight.w700, color: Colors.grey)))
          ],
        )),
        onTap: () {
          // fps!.setState(() {
          //   if (fps!.flags.indexOf(true) != -1)
          //     fps!.flags[fps!.flags.indexOf(true)] = false;
          //   fps!.flags[widget.index] = true;
          // });
          // print(fps!.flags);
        });
  }
}
