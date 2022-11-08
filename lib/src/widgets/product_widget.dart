import '../models/product.dart';
import '../helpers/helper.dart';
import 'package:flutter/material.dart';

class ProductWidget extends StatelessWidget {
  final Product item;
  const ProductWidget({Key? key, required this.item}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final hp = Helper.of(context);
    return GridTile(
        footer: GridTileBar(
          backgroundColor: Colors.white,
          title: Text(
            item.product,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          subtitle: Text('\u{20B9}${item.price}'),
          trailing: const Icon(Icons.shopping_cart),
        ),
        child: Image.network(item.images.first, fit: BoxFit.cover));
  }
}
