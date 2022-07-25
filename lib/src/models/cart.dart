import 'package:grid_test/src/models/item.dart';
import 'package:flutter_cart/flutter_cart.dart';

class Cart extends FlutterCart {
  List<Item>? items;
  factory Cart() {
    return Cart();
  }

  Cart getCart({List<Item>? list}) {
    items = list;
    return Cart();
  }
}
