class Reply {
  final bool success;
  final String message;
  Reply(this.success, this.message);
  factory Reply.fromMap(Map<String, dynamic> json) {
    return Reply(json['success'] ?? false, json['message'] ?? '');
  }
}
