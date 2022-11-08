import '../helpers/helper.dart';

class ProductCategory {
  final int productCategoryID;
  final String productCategory, imageLink;

  ProductCategory(this.productCategoryID, this.productCategory, this.imageLink);
  static ProductCategory emptyCategory = ProductCategory(-1, '', '');
  factory ProductCategory.fromMap(Map<String, dynamic> map) {
    try {
      return ProductCategory(
          map['id'] ?? -1, map['name'] ?? '', map['image'] ?? '');
    } catch (e) {
      log(e);
      return ProductCategory.emptyCategory;
    }
  }

  @override
  String toString() {
    // TODO: implement toString
    return productCategory;
  }

  @override
  bool operator ==(Object other) {
    log(other);
    return other is ProductCategory &&
        other.productCategoryID == productCategoryID;
  }

  @override
  // TODO: implement hashCode
  int get hashCode => productCategoryID.hashCode;
}
