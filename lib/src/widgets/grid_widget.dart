import 'package:grid_test/src/helpers/helper.dart';
import 'package:grid_test/src/widgets/empty_widget.dart';

import 'circular_loader.dart';
import '../backend/api.dart';
import '../models/some_item.dart';
import '../screens/grid_page.dart';
import 'package:flutter/material.dart';
import '../widgets/grid_item_widget.dart';

class GridWidget extends StatefulWidget {
  const GridWidget({Key? key}) : super(key: key);

  static GridPageState? of(BuildContext context) =>
      context.findAncestorStateOfType<GridPageState>();

  @override
  GridWidgetState createState() => GridWidgetState();
}

class GridWidgetState extends State<GridWidget> {
  GridPageState? get gps => GridWidget.of(context);
  Widget gridBuilder(
      BuildContext context, AsyncSnapshot<List<SomeItem>> items) {
    Widget itemBuilder(BuildContext context, int index) {
      try {
        return GridItemWidget(
            item: items.data?[index] ?? SomeItem.emptyItem, index: index);
      } catch (e) {
        log(e);
        return const EmptyWidget();
      }
    }

    if (gps?.flags.isEmpty ?? false) {
      gps?.flags = List<bool>.filled(items.data?.length ?? 0, false);
    }

    // log(largestFactorUnderTen(200));

    try {
      return items.hasData &&
              !items.hasError &&
              (items.data?.isNotEmpty ?? false)
          ? GridView.builder(
              itemCount: items.data?.length,
              itemBuilder: itemBuilder,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:
                      largestFactorUnderTen(items.data?.length ?? 2) < 2
                          ? 2
                          : largestFactorUnderTen(items.data?.length ?? 2)))
          : (!items.hasData || items.hasError
              ? const CircularLoader(
                  color: Colors.blue, duration: Duration(seconds: 5))
              : const Text('Nothing Found'));
    } catch (e) {
      log(e);
      return const EmptyWidget();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<SomeItem>>(
        builder: gridBuilder, future: obtainData());
  }
}
