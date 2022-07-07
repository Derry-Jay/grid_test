import 'package:flutter_cart/flutter_cart.dart';
import 'package:flutter_cart/model/cart_response_wrapper.dart';
import 'package:flutter_cart/model/cart_model.dart';
import 'package:grid_test/src/models/item.dart';

class Cart implements FlutterCart{
  @override
  late CartResponseWrapper message;
  // CartItemElement _cartItemElement;

  @override
  addToCart({productId, unitPrice, String? productName, int quantity = 1, uniqueCheck, productDetailsObject}) {
    // TODO: implement addToCart
    throw UnimplementedError();
  }

  @override
  // TODO: implement cartItem
  List<Item> get cartItem => throw UnimplementedError();

  @override
  decrementItemFromCart(int index) {
    // TODO: implement decrementItemFromCart
    throw UnimplementedError();
  }

  @override
  deleteAllCart() {
    // TODO: implement deleteAllCart
    throw UnimplementedError();
  }

  @override
  deleteItemFromCart(int index) {
    // TODO: implement deleteItemFromCart
    throw UnimplementedError();
  }

  @override
  int? findItemIndexFromCart(cartId) {
    // TODO: implement findItemIndexFromCart
    throw UnimplementedError();
  }

  @override
  getCartItemCount() {
    // TODO: implement getCartItemCount
    throw UnimplementedError();
  }

  @override
  CartItem? getSpecificItemFromCart(cartId) {
    // TODO: implement getSpecificItemFromCart
    throw UnimplementedError();
  }

  @override
  getTotalAmount() {
    // TODO: implement getTotalAmount
    throw UnimplementedError();
  }

  @override
  incrementItemToCart(int index) {
    // TODO: implement incrementItemToCart
    throw UnimplementedError();
  }
  
}
