import 'grid_widget.dart';
import 'empty_widget.dart';
import '../models/item.dart';
import '../helpers/helper.dart';
import 'package:flutter/material.dart';

class GridItemWidget extends StatefulWidget {
  final int index;
  final Item item;
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
          onTap: () {
            // gws?.setState(() {
            //   if (gws?.gps?.flags.contains(true) ?? false) {
            //     gws?.gps?.flags[gws?.gps?.flags.indexOf(true) ?? widget.index] =
            //         false;
            //   }
            //   gws?.gps?.flags[widget.index] = true;
            // });
            // log(gws?.gps?.flags);
          },
          child: GridTile(
              footer: GridTileBar(
                  backgroundColor: Colors.yellow,
                  title: Text(widget.item.title, style: hp.textTheme.headline6),
                  subtitle: Text('\u{20B9}${widget.item.price}',
                      style: const TextStyle(color: Colors.black)),
                  trailing:
                      const Icon(Icons.shopping_cart, color: Colors.black)),
              child: widget.item.image.isEmpty
                  ? Container(
                      color: Colors.pinkAccent,
                      child: Center(
                          child: Icon(Icons.image,
                              color: Colors.pinkAccent.shade100)))
                  : Image.network(widget.item.image,
                      fit: BoxFit.cover,
                      errorBuilder: errorBuilder,
                      loadingBuilder: getNetworkImageLoader)));
    } catch (e) {
      log(e);
      return const EmptyWidget();
    }
  }
}
