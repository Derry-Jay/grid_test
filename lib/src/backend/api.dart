import 'dart:convert';
import 'package:grid_test/src/model/some_item.dart';
import 'package:http/http.dart';
import '../helpers/helper.dart';

final client = Client();
Stream<List<SomeItem>> getData() async* {
  try {
    final url =
        Uri.tryParse('https://jsonplaceholder.typicode.com/todos') ?? Uri();
    final response = await client.get(url);
    yield response.statusCode == 200
        ? List<Map<String, dynamic>>.from(json.decode(response.body))
            .map<SomeItem>(SomeItem.fromMap)
            .toList()
        : <SomeItem>[];
  } catch (e) {
    log(e);
    yield <SomeItem>[];
  }
}

Future obtainData(Map<String, dynamic> body) async {
  try {
    final url =
        Uri.tryParse('https://jsonplaceholder.typicode.com/todos') ?? Uri();
    final response = await client.post(url, body: body);
    log(response.statusCode);
    log(response.body);
    final data = json.decode(response.body) as Map<String, dynamic>;
    // Map<String, dynamic> userMap = json.decode(response.body);
    // // var deliverystock = ShowNotification.fromMap(userMap);
    // // return deliverystock;
    // return response.statusCode == 200
    //     ? Reply.fromMap(userMap)
    //     : Reply.emptyReply;
    return data;
  } catch (e) {
    log(e);
    rethrow;
  }
}
