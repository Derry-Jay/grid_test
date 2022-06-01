import '../helpers/helper.dart';
import '../widgets/circular_loader.dart';

import '../backend/api.dart';
import 'some_item_widget.dart';
import '../models/some_item.dart';
import '../screens/first_page.dart';
import 'package:flutter/material.dart';

class SomeItemListWidget extends StatefulWidget {
  const SomeItemListWidget({Key? key}) : super(key: key);

  @override
  SomeItemListWidgetState createState() => SomeItemListWidgetState();

  static FirstPageState? of(BuildContext context) =>
      context.findAncestorStateOfType<FirstPageState>();
}

class SomeItemListWidgetState extends State<SomeItemListWidget> {
  FirstPageState? get fps => SomeItemListWidget.of(context);
  Widget listBuilder(
      BuildContext context, AsyncSnapshot<List<SomeItem>> items) {
    log(items.data);
    Widget getItem(BuildContext context, int index) {
      return SomeItemWidget(item: items.data![index], index: index);
    }

    return items.hasData && !items.hasError && items.data!.isNotEmpty
        ? ListView.builder(itemCount: items.data?.length, itemBuilder: getItem)
        : (!items.hasData || items.hasError
            ? const CircularLoader(
                color: Colors.blue, duration: Duration(seconds: 5))
            : const Text('Nothing Found'));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<SomeItem>>(
        builder: listBuilder, stream: getData(const Duration(seconds: 5)));
  }
}
