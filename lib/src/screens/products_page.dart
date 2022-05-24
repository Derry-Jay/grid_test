import 'dart:math';
import 'package:flutter/material.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  ProductsPageState createState() => ProductsPageState();
}

class ProductsPageState extends State<ProductsPage> {
  MediaQueryData get dimensions => MediaQuery.of(context);
  Size get size => dimensions.size;
  double get height => size.height;
  double get width => size.width;
  double get radius => sqrt(pow(width, 2) + pow(height, 2));

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.all(radius / 80),
                child: Text(
                  'My Awesome Shop',
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .apply(color: Colors.blueGrey),
                ),
              ),
            ),
            // SliverGrid(
            //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //     crossAxisCount: 2,
            //     childAspectRatio: (itemWidth / itemHeight),
            //     mainAxisSpacing: 2,
            //     crossAxisSpacing: 1,
            //   ),
            //   delegate: SliverChildBuilderDelegate(
            //     (BuildContext context, int index) {
            //       final product = products[index];
            //       return Column(
            //         mainAxisAlignment: MainAxisAlignment.end,
            //         children: <Widget>[
            //           Container(
            //             height: 230,
            //             width: 200,
            //             margin: EdgeInsets.all(10),
            //             decoration: BoxDecoration(
            //               image: DecorationImage(
            //                   image: NetworkImage(
            //                     product.images[0].src,
            //                   ),
            //                   fit: BoxFit.cover),
            //               color: Colors.pinkAccent,
            //               borderRadius: BorderRadius.all(Radius.circular(10)),
            //             ),
            //             //child: Image.network(product.images[0].src, fit: BoxFit.cover,),
            //           ),
            //           Text(
            //             product.name ?? 'Loading...',
            //             style: Theme.of(context)
            //                 .textTheme
            //                 .headline1!
            //                 .apply(color: Colors.blueGrey),
            //           ),
            //           Text('\$' + product.price,
            //               style: Theme.of(context).textTheme.headline2)
            //         ],
            //       );
            //     },
            //     childCount: products.length,
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
