import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';

import 'empty_screen.dart';
import '../backend/api.dart';
import '../helpers/helper.dart';
import '../models/product.dart';
import '../models/route_argument.dart';
import 'package:flutter/material.dart';
import '../widgets/circular_loader.dart';

// import '../widgets/custom_button.dart';

class ProductDetailsScreen extends StatefulWidget {
  final RouteArgument rar;
  const ProductDetailsScreen({Key? key, required this.rar}) : super(key: key);

  @override
  ProductDetailsScreenState createState() => ProductDetailsScreenState();
}

class ProductDetailsScreenState extends State<ProductDetailsScreen> {
  StreamSubscription<Product>? psc;
  void customDispose() async {
    try {
      log('Stopping listening for Product.....');
      await psc?.cancel();
      log('Stopped listening to Product');
    } catch (e) {
      log(e);
    }
  }

  Widget screenBuilder(BuildContext context, AsyncSnapshot<Product> product) {
    final hp = Helper.of(context);
    Widget getImage(String i) {
      return Image.network(i,
          fit: BoxFit.cover,
          errorBuilder: errorBuilder,
          loadingBuilder: getNetworkImageLoader);
    }

    switch (product.connectionState) {
      case ConnectionState.active:
        if (product.hasData && !product.hasError) {
          final prd = product.data;
          return Scaffold(
              backgroundColor: Colors.grey.shade300,
              body: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: hp.width / 20),
                  child: SizedBox(
                      width: hp.width,
                      height: hp.height,
                      child: Column(children: [
                        CarouselSlider(
                          options: CarouselOptions(
                              height: hp.height / 6.25, autoPlay: true),
                          items: prd?.images.map<Widget>(getImage).toList(),
                        ),
                        SelectableText(prd?.description ?? '')
                      ]))),
              appBar: AppBar(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                title: SelectableText(prd?.product ?? '',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
              ));
        } else if (product.hasError) {
          return Scaffold(
              appBar: AppBar(),
              body: SelectableText(product.error?.toString() ?? ''));
        } else {
          return const EmptyScreen();
        }
      case ConnectionState.none:
        return const EmptyScreen();
      default:
        return Scaffold(
            appBar: AppBar(),
            body: CircularLoader(
                color: hp.theme.primaryColor,
                duration: const Duration(seconds: 5)));
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StreamBuilder<Product>(
        builder: screenBuilder, stream: productController.stream);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    psc = productController.stream.listen((event) {
      log('++++++++++++++++');
      log(event.images.length);
      getProductData(6, widget.rar.id ?? 0);
      log('================');
    }, onDone: () {
      log('done');
    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    getProductData(6, widget.rar.id ?? 0);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    customDispose();
    super.dispose();
  }
}
