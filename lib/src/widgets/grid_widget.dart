import 'empty_widget.dart';
import '../backend/api.dart';
import 'circular_loader.dart';
import 'grid_item_widget.dart';
import '../helpers/helper.dart';
import '../models/some_item.dart';
import '../screens/grid_page.dart';
import 'package:flutter/material.dart';

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
    final hp = Helper.of(context);
    Widget itemBuilder(BuildContext context, int index) {
      try {
        return GridItemWidget(
            item: items.data?[index] ?? SomeItem.emptyItem, index: index);
      } catch (e) {
        log(e);
        return const EmptyWidget();
      }
    }

    // log(largestFactorUnderTen(200));

    try {
      switch (items.connectionState) {
        case ConnectionState.done:
          if (items.hasData && !items.hasError) {
            if ((gps?.flags.isEmpty ?? true) &&
                (items.data?.isNotEmpty ?? false)) {
              gps?.flags = List<bool>.filled(items.data?.length ?? 0, false);
            }
            return items.data?.isNotEmpty ?? false
                ? GridView.builder(
                    itemBuilder: itemBuilder,
                    itemCount: items.data?.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4))
                : const Text('Nothing');
          } else if (items.hasError) {
            return Text(items.error?.toString() ?? '');
          } else {
            return const EmptyWidget();
          }
        case ConnectionState.none:
          return const EmptyWidget();
        default:
          return CircularLoader(
              color: hp.theme.primaryColor,
              duration: const Duration(seconds: 5));
      }
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
