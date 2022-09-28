import '../helpers/helper.dart';
import 'package:flutter_cart/model/cart_model.dart';

class Item extends CartItem {
  int? index;
  final num cost;
  final int itemID, count;
  final String name, code, date;
  Item(this.cost, this.itemID, this.name, this.code, this.date, this.count,
      {this.index})
      : super(
            uuid: code,
            quantity: count,
            unitPrice: cost,
            productId: itemID,
            productName: name,
            subTotal: count * cost,
            itemCartIndex: index ?? -1);
  static Item emptyItem = Item(0, -1, '', '', '', 0);
  factory Item.fromMap(Map<String, dynamic> body) {
    try {
      return Item(body['cost'], body['itemID'], body['name'], body['code'],
          body['date'], body['count']);
    } catch (e) {
      log(e);
      return Item.emptyItem;
    }
  }
}
