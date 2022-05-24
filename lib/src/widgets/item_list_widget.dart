import 'item_widget.dart';
import '../models/item.dart';
import 'package:flutter/material.dart';

class ItemListWidget extends StatelessWidget {
  final List<Item> items;
  const ItemListWidget({Key? key, required this.items}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(
        shrinkWrap: true,
        itemBuilder: (context, index) => ItemWidget(item: items[index]),
        itemCount: items.length);
  }
}
