import 'dart:async';
import 'empty_widget.dart';
import '../models/item.dart';
import '../backend/api.dart';
import 'circular_loader.dart';
import 'grid_item_widget.dart';
import '../helpers/helper.dart';
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
  StreamSubscription<List<Item>>? isc;
  GridPageState? get gps => GridWidget.of(context);
  void customDispose() async {
    try {
      log('Stopping listening for Item List.....');
      await isc?.cancel();
      log('Stopped listening to Item List');
    } catch (e) {
      log(e);
    }
  }

  Widget gridBuilder(BuildContext context, AsyncSnapshot<List<Item>> items) {
    final hp = Helper.of(context);
    // final gp = GridWidget.of(context);

    bool filter(Item element) {
      return element.category.itemCategoryID == gps?.selectedID;
    }

    Widget itemBuilder(BuildContext context, int index) {
      try {
        final lst = gps?.selectedID == null
            ? items.data
            : items.data?.where(filter).toSet().toList();
        return GridItemWidget(
            item: lst?[index] ?? Item.emptyItem, index: index);
      } catch (e) {
        log(e);
        return const EmptyWidget();
      }
    }

    try {
      switch (items.connectionState) {
        case ConnectionState.active:
          if (items.hasData &&
              !items.hasError &&
              (items.data?.isNotEmpty ?? false)) {
            final lst = gps?.selectedID == null
                ? items.data
                : items.data?.where(filter).toSet();
            return GridView.builder(
                itemCount: lst?.length,
                itemBuilder: itemBuilder,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: hp.height / 32,
                    crossAxisSpacing: hp.width / 16,
                    childAspectRatio: (hp.width * 1.28) / hp.height,
                    crossAxisCount: 2));
          } else if (items.hasError) {
            return SelectableText(items.error?.toString() ?? '');
          } else {
            return const EmptyWidget();
          }
        case ConnectionState.none:
          return const EmptyWidget();
        default:
          return const CircularLoader(
              color: Colors.pinkAccent, duration: Duration(seconds: 5));
      }
    } catch (e) {
      log(e);
      return const EmptyWidget();
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Item>>(
        builder: gridBuilder, stream: itemsController.stream);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isc = itemsController.stream.listen((event) {
      log('++++++++++++++++');
      log(event.length);
      obtainItems(6);
      log('================');
    }, onDone: () {
      log('done');
    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    obtainItems(6);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    customDispose();
    super.dispose();
  }
}
