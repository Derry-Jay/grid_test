class SomeItem {
  final int itemID, userID;
  final String title;
  final bool completed;

  SomeItem(this.itemID, this.userID, this.title, this.completed);

  factory SomeItem.fromMap(Map<String, dynamic> json) {
    return SomeItem(
        json['id'], json['userId'], json['title'], json['completed']);
  }
}
