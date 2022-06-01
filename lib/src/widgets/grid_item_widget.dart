import '../helpers/helper.dart';
import '../screens/grid_page.dart';
import 'package:flutter/material.dart';

class GridItemWidget extends StatefulWidget {
  final List<String> content;
  final int index;
  const GridItemWidget({required this.content, required this.index, Key? key})
      : super(key: key);
  @override
  GridItemWidgetState createState() => GridItemWidgetState();
  static GridPageState? of(BuildContext context) =>
      context.findAncestorStateOfType<GridPageState>();
}

class GridItemWidgetState extends State<GridItemWidget> {
  GridPageState? get gps => GridItemWidget.of(context);
  Helper get hp => Helper.of(context);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
        child: Card(
            shape: RoundedRectangleBorder(
                side: BorderSide(
                    color: gps!.flags[widget.index]
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
                          color: gps!.flags[widget.index]
                              ? Colors.pink
                              : Colors.white,
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(hp.radius / 50),
                              topLeft: Radius.circular(hp.radius / 40))),
                      child: const Icon(Icons.check, color: Colors.white))
                ]),
                Expanded(
                    flex: 1,
                    child: Text(widget.content.first,
                        style: const TextStyle(fontWeight: FontWeight.w700))),
                Expanded(
                    flex: 2,
                    child: Text(widget.content.last,
                        style: const TextStyle(
                            fontWeight: FontWeight.w700, color: Colors.grey)))
              ],
            )),
        onTap: () {
          gps!.setState(() {
            if (gps!.flags.contains(true)) {
              gps!.flags[gps!.flags.indexOf(true)] = false;
            }
            gps!.flags[widget.index] = true;
          });
          log(gps!.flags);
        });
  }
}
