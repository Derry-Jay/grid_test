// import '../helpers/helper.dart';
import 'package:grid_test/src/helpers/helper.dart';

import 'item_widget.dart';
import '../models/item.dart';
import 'package:flutter/material.dart';

class ItemGridWidget extends StatelessWidget {
  final List<Item> items;
  const ItemGridWidget({Key? key, required this.items}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    // final hp = Helper.of(context);
    log(items.length);
    return GridView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) => ItemWidget(item: items[index]),
      itemCount: items.length,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
    );
  }
}
