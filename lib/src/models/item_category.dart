import '../helpers/helper.dart';

class ItemCategory {
  final String itemCategoryID, itemCategory, slug;

  static ItemCategory emptyCategory = ItemCategory('', '', '');

  ItemCategory(this.itemCategoryID, this.itemCategory, this.slug);

  factory ItemCategory.fromMap(Map<String, dynamic> json) {
    try {
      return ItemCategory(
          json['_id'] ?? '', json['name'] ?? '', json['slug'] ?? '');
    } catch (e) {
      log(e);
      return ItemCategory.emptyCategory;
    }
  }

  @override
  String toString() {
    // TODO: implement toString
    return itemCategory;
  }

  @override
  bool operator ==(Object other) {
    log(other);
    return other is ItemCategory && other.itemCategoryID == itemCategoryID;
  }

  @override
  // TODO: implement hashCode
  int get hashCode => itemCategoryID.hashCode;
}
