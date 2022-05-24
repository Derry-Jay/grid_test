import 'package:grid_test/src/widgets/some_item_widget.dart';

import '../backend/api.dart';
import '../model/some_item.dart';
import 'package:flutter/material.dart';

class SomeItemListWidget extends StatefulWidget {
  const SomeItemListWidget({Key? key}) : super(key: key);

  @override
  State<SomeItemListWidget> createState() => _SomeItemListWidgetState();
}

class _SomeItemListWidgetState extends State<SomeItemListWidget> {
  Widget listBuilder(
      BuildContext context, AsyncSnapshot<List<SomeItem>> items) {
    Widget getItem(BuildContext context, int index) {
      return SomeItemWidget(item: items.data![index], index: index);
    }

    return items.hasData && !items.hasError
        ? ListView.builder(itemCount: items.data?.length, itemBuilder: getItem)
        : const Text('');
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<SomeItem>>(
        builder: listBuilder, stream: getData());
  }
}
