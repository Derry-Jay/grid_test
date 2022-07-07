class SomeItem {
  final int itemID, userID;
  final String title;
  final bool completed;

  SomeItem(this.itemID, this.userID, this.title, this.completed);

  static SomeItem emptyItem = SomeItem(-1, -1, '', false);

  factory SomeItem.fromMap(Map<String, dynamic> json) {
    return SomeItem(json['id'] ?? -1, json['userId'] ?? -1, json['title'] ?? '',
        json['completed'] ?? false);
  }
}
