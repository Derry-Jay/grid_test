import '../helpers/helper.dart';

class Todo {
  final String title;
  final bool completed;
  final int todoID, userID;

  Todo(this.todoID, this.userID, this.title, this.completed);

  static Todo emptyTodo = Todo(-1, -1, '', false);

  factory Todo.fromMap(Map<String, dynamic> json) {
    try {
      return Todo(json['id'] ?? -1, json['userId'] ?? -1, json['title'] ?? '',
          json['completed'] ?? false);
    } catch (e) {
      log(e);
      return Todo.emptyTodo;
    }
  }
}
