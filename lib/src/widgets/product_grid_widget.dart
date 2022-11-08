import 'dart:async';
import 'empty_widget.dart';
import 'product_widget.dart';
import '../backend/api.dart';
import 'circular_loader.dart';
import '../models/product.dart';
import '../helpers/helper.dart';
import 'package:flutter/material.dart';

class ProductGridWidget extends StatefulWidget {
  const ProductGridWidget({Key? key}) : super(key: key);

  @override
  ProductGridWidgetState createState() => ProductGridWidgetState();
}

class ProductGridWidgetState extends State<ProductGridWidget> {
  StreamSubscription<List<Product>>? psc;
  void customDispose() async {
    await psc?.cancel();
  }

  Widget gridBuilder(
      BuildContext context, AsyncSnapshot<List<Product>> products) {
    Widget getItem(BuildContext context, int index) {
      return ProductWidget(item: products.data?[index] ?? Product.emptyProduct);
    }

    final hp = Helper.of(context);

    try {
      log(products.connectionState);
      switch (products.connectionState) {
        case ConnectionState.done:
          if (products.hasData && !products.hasError) {
            return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: getItem);
          } else if (products.hasError) {
            return SelectableText(products.error?.toString() ?? '');
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
    // TODO: implement build
    return StreamBuilder<List<Product>>(
        builder: gridBuilder, stream: productsController.stream);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    psc = productsController.stream.listen((event) {
      log(event.length);
    }, onDone: () {
      log('done');
    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    getProducts(6);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    customDispose();
    super.dispose();
  }
}
