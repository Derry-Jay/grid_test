import '../helpers/helper.dart';

class Base {
  final int status;
  final String message;
  final List<dynamic> data;

  Base(this.status, this.message, this.data);

  static Base emptyBase = Base(404, '', []);

  factory Base.fromMap(Map<String, dynamic> map) {
    try {
      return Base(map['status'] ?? 404, map['message'] ?? '',
          (map['data'] as List?) ?? []);
    } catch (e) {
      log(e);
      return Base.emptyBase;
    }
  }
}
