import '../helpers/helper.dart';
import '../models/some_item.dart';
import 'package:flutter/material.dart';

class SomeItemWidget extends StatefulWidget {
  final SomeItem item;
  final int index;
  const SomeItemWidget({Key? key, required this.item, required this.index})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => SomeItemWidgetState();
}

class SomeItemWidgetState extends State<SomeItemWidget> {
  Helper get hp => Helper.of(context);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
        // shape: RoundedRectangleBorder(
        //     side: BorderSide(
        //         color: fps!.flags[widget.index]
        //             ? (fps!.flags.length - widget.index == 1
        //                 ? Colors.pink
        //                 : Colors.blue)
        //             : Colors.transparent),
        //     borderRadius:
        //         BorderRadius.all(Radius.circular(hp.radius / 40))),
        child: InkWell(
      child: SizedBox(
          width: hp.width,
          height: hp.height / 8,
          child: Column(
            children: [
              Row(children: [
                Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(hp.radius / 50),
                            topLeft: Radius.circular(hp.radius / 40))),
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                    ))
              ]),
              Expanded(
                  flex: 1,
                  child: Text(widget.item.title,
                      style: const TextStyle(fontWeight: FontWeight.w700))),
              Expanded(
                  flex: 2,
                  child: Text(widget.item.itemID.toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, color: Colors.grey)))
            ],
          )),
    ));
  }
}
