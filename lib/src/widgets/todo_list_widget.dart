import '../helpers/helper.dart';
import '../models/todo.dart';
import '../widgets/circular_loader.dart';

import '../backend/api.dart';
import 'todo_widget.dart';
import '../screens/first_page.dart';
import 'package:flutter/material.dart';

class TodoListWidget extends StatefulWidget {
  const TodoListWidget({Key? key}) : super(key: key);

  @override
  TodoListWidgetState createState() => TodoListWidgetState();

  static FirstPageState? of(BuildContext context) =>
      context.findAncestorStateOfType<FirstPageState>();
}

class TodoListWidgetState extends State<TodoListWidget> {
  FirstPageState? get fps => TodoListWidget.of(context);
  Widget listBuilder(BuildContext context, AsyncSnapshot<List<Todo>> items) {
    log(items.data);
    Widget getItem(BuildContext context, int index) {
      return TodoWidget(
          item: items.data?[index] ?? Todo.emptyTodo, index: index);
    }

    return items.hasData && !items.hasError && (items.data?.isNotEmpty ?? false)
        ? ListView.builder(itemCount: items.data?.length, itemBuilder: getItem)
        : (!items.hasData || items.hasError
            ? const CircularLoader(
                color: Colors.blue, duration: Duration(seconds: 5))
            : const Text('Nothing Found'));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Todo>>(
        builder: listBuilder, stream: receiveData(const Duration(seconds: 5)));
  }
}
