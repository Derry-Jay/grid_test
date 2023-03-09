import 'item_category.dart';
import '../helpers/helper.dart';

class Item {
  final int price;
  final ItemCategory category;
  final String itemID, title, description, image, slug;

  Item(this.itemID, this.title, this.price, this.category, this.description,
      this.slug, this.image);

  static Item emptyItem =
      Item('', '', -1, ItemCategory.emptyCategory, '', '', '');

  factory Item.fromMap(Map<String, dynamic> json) {
    try {
      return Item(
          json['_id'] ?? '',
          json['title'] ?? '',
          json['price'] ?? -1,
          ItemCategory.fromMap(json['category'] ?? <String, dynamic>{}),
          json['description'] ?? '',
          json['slug'] ?? '',
          json['image'] ?? '');
    } catch (e) {
      log(e);
      return Item.emptyItem;
    }
  }

  @override
  bool operator ==(Object other) {
    log(other);
    return other is Item &&
        itemID == other.itemID &&
        category == other.category;
  }

  @override
  // TODO: implement hashCode
  int get hashCode => itemID.hashCode + category.itemCategoryID.hashCode;
}
