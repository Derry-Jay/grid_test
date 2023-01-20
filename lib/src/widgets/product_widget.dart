import '../models/product.dart';
import '../helpers/helper.dart';
import '../models/route_argument.dart';
import 'package:flutter/material.dart';

class ProductWidget extends StatelessWidget {
  final Product item;
  const ProductWidget({Key? key, required this.item}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final hp = Helper.of(context);
    return GestureDetector(
        onTap: () {
          hp.goTo('/productInfo',
              args: RouteArgument(
                  id: item.productID, type: TransitionType.decorative));
        },
        child: GridTile(
            footer: GridTileBar(
                backgroundColor: Colors.yellow,
                title: Text(item.product, style: hp.textTheme.headline6),
                subtitle: Text('\u{20B9}${item.price}',
                    style: const TextStyle(color: Colors.black)),
                trailing: const Icon(Icons.shopping_cart, color: Colors.black)),
            child: Image.network(item.images.first,
                fit: BoxFit.cover,
                errorBuilder: errorBuilder,
                loadingBuilder: getNetworkImageLoader)));
  }
}
