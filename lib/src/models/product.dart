import 'product_category.dart';
import '../helpers/helper.dart';

class Product {
  final List<String> images;
  final int productID, price;
  final ProductCategory category;
  final String product, description;

  Product(this.productID, this.product, this.description, this.category,
      this.price, this.images);
  static Product emptyProduct =
      Product(-1, '', '', ProductCategory.emptyCategory, -1, <String>[]);
  factory Product.fromMap(Map<String, dynamic> map) {
    try {
      return Product(
          map['id'] ?? -1,
          map['title'] ?? '',
          map['description'] ?? '',
          ProductCategory.fromMap(map['category'] ?? <String, dynamic>{}),
          map['price'] ?? -1,
          List<String>.from(map['images'] ?? []));
    } catch (e) {
      log(e);
      return Product.emptyProduct;
    }
  }
}
