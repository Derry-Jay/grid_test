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
    try {
      log('Stopping listening for Product List.....');
      await psc?.cancel();
      log('Stopped listening to Product List');
    } catch (e) {
      log(e);
    }
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
        case ConnectionState.active:
          if (products.hasData &&
              !products.hasError &&
              (products.data?.isNotEmpty ?? false)) {
            return GridView.builder(
                itemBuilder: getItem,
                itemCount: products.data?.length,
                padding: EdgeInsets.symmetric(
                    vertical: hp.height / 40, horizontal: hp.width / 20),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: hp.height / 32,
                    crossAxisSpacing: hp.width / 16,
                    childAspectRatio: (hp.width * 1.28) / hp.height,
                    crossAxisCount: 2));
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
      return SelectableText(e.toString());
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
      log('++++++++++++++++');
      log(event.length);
      getProducts(6);
      log('================');
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
