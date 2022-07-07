import 'dart:io';
import 'dart:math';
import 'dart:convert';
import 'package:http/http.dart';
import '../helpers/helper.dart';
import '../models/some_item.dart';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';

GlobalConfiguration? gc;
final httpClient = HttpClient();
ValueNotifier<List<int>?> bytes = ValueNotifier(null);

Stream<int> getValues(int seconds) async* {
  final rand = Random(0);
  while (true) {
    await Future.delayed(Duration(seconds: seconds));
    yield rand.nextInt(10);
  }
}

Stream<List<SomeItem>> receiveData(Duration duration) async* {
  final client = Client();
  try {
    while (true) {
      await Future.delayed(duration);
      final url =
          Uri.tryParse('https://jsonplaceholder.typicode.com/todos') ?? Uri();
      final response = await client.get(url);
      // client.close();
      yield response.statusCode == 200
          ? List<Map<String, dynamic>>.from(json.decode(response.body))
              .map<SomeItem>(SomeItem.fromMap)
              .toList()
          : <SomeItem>[];
    }
  } catch (e) {
    log(e);
    client.close();
    yield <SomeItem>[];
  }
}

Future<List<SomeItem>> obtainData() async {
  final client = Client();
  try {
    final url =
        Uri.tryParse('https://jsonplaceholder.typicode.com/todos') ?? Uri();
    final response = await client.get(url);
    // client.close();
    log(response.statusCode);
    log(response.body);
    // Map<String, dynamic> userMap = json.decode(response.body);
    // // var deliverystock = ShowNotification.fromMap(userMap);
    // // return deliverystock;
    // return response.statusCode == 200
    //     ? Reply.fromMap(userMap)
    //     : Reply.emptyReply;
    return response.statusCode == 200
        ? List<Map<String, dynamic>>.from(json.decode(response.body))
            .map<SomeItem>(SomeItem.fromMap)
            .toList()
        : <SomeItem>[];
  } catch (e) {
    log(e);
    client.close();
    rethrow;
  }
}
