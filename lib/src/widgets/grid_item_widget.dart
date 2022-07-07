import 'grid_widget.dart';
import 'empty_widget.dart';
import '../helpers/helper.dart';
import '../models/some_item.dart';
import 'package:flutter/material.dart';

class GridItemWidget extends StatefulWidget {
  final int index;
  final SomeItem item;
  const GridItemWidget({required this.item, required this.index, Key? key})
      : super(key: key);

  static GridWidgetState? of(BuildContext context) =>
      context.findAncestorStateOfType<GridWidgetState>();

  @override
  GridItemWidgetState createState() => GridItemWidgetState();
}

class GridItemWidgetState extends State<GridItemWidget> {
  Helper get hp => Helper.of(context);
  GridWidgetState? get gws => GridItemWidget.of(context);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    try {
      return GestureDetector(
          child: Card(
              shape: RoundedRectangleBorder(
                  side: BorderSide(
                      color: (gws?.gps?.flags[widget.index] ?? false)
                          ? Colors.pink
                          : Colors.transparent),
                  borderRadius:
                      BorderRadius.all(Radius.circular(hp.radius / 40))),
              child: Column(
                children: [
                  Row(children: [
                    const SizedBox(),
                    Container(
                        decoration: BoxDecoration(
                            color: (gws?.gps?.flags[widget.index] ?? false)
                                ? Colors.pink
                                : Colors.white,
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(hp.radius / 50),
                                topLeft: Radius.circular(hp.radius / 40))),
                        child: const Icon(Icons.check, color: Colors.white))
                  ]),
                  Expanded(
                      flex: 1,
                      child: Text(widget.item.itemID.toString(),
                          style: const TextStyle(fontWeight: FontWeight.w700))),
                  Expanded(
                      flex: 2,
                      child: Text(widget.item.title,
                          style: const TextStyle(
                              fontWeight: FontWeight.w700, color: Colors.grey)))
                ],
              )),
          onTap: () {
            // gps!.setState(() {
            //   if (gps!.flags.contains(true)) {
            //     gps!.flags[gps!.flags.indexOf(true)] = false;
            //   }
            //   gps!.flags[widget.index] = true;
            // });
            // log(gps!.flags);
          });
    } catch (e) {
      log(e);
      return const EmptyWidget();
    }
  }
}
