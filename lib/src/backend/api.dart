import 'dart:io';
import 'dart:math';
import 'dart:async';
import 'dart:convert';
import 'package:grid_test/src/models/base.dart';

import '../models/city.dart';
import '../models/county.dart';
import '../models/item.dart';
import '../models/todo.dart';
import '../models/product.dart';
import '../helpers/helper.dart';
import 'package:http/http.dart';
import 'package:global_configuration/global_configuration.dart';

GlobalConfiguration? gc;
final httpClient = HttpClient();
StreamController<List<Product>> productsController =
    StreamController<List<Product>>.broadcast(onListen: () {
  log('Waiting to listen for Product List.....');
  log('Started listening to Product List');
}, onCancel: () {
  log('Stopped listening to Product List');
});

StreamController<Product> productController =
    StreamController<Product>.broadcast(onListen: () {
  log('Waiting to listen for Product.....');
  log('Started listening to Product');
}, onCancel: () {
  log('Stopped listening to Product');
});

StreamController<List<Item>> itemsController =
    StreamController<List<Item>>.broadcast(onListen: () {
  log('Waiting to listen for Item List.....');
  log('Started listening to Item List');
}, onCancel: () {
  log('Stopped listening to Item List');
});

void getProducts(int seconds) async {
  try {
    await Future.delayed(Duration(seconds: seconds), () async {
      final cl = Client();
      final res = await cl.get(
          Uri.tryParse('https://api.escuelajs.co/api/v1/products') ?? Uri());
      cl.close();
      final list = res.statusCode == 200
          ? List<Map<String, dynamic>>.from(json.decode(res.body) as List)
              .map<Product>(Product.fromMap)
              .toList()
          : <Product>[];
      log('------------------------');
      log(list.length);
      log('________________________');
      list.isEmpty ? doNothing() : productsController.add(list);
    });
  } catch (e) {
    log(e);
  }
}

void getProductData(int seconds, int productID) async {
  try {
    await Future.delayed(Duration(seconds: seconds), () async {
      final client = Client();
      final response = await client.get(
          Uri.tryParse('https://api.escuelajs.co/api/v1/products/$productID') ??
              Uri());
      client.close();
      final product = response.statusCode == 200
          ? Product.fromMap(json.decode(response.body) as Map<String, dynamic>)
          : Product.emptyProduct;
      product.isEmpty ? doNothing() : productController.add(product);
    });
  } catch (e) {
    log(e);
  }
}

void obtainItems(int seconds) async {
  try {
    await Future.delayed(Duration(seconds: seconds), () async {
      final client = Client();
      final url =
          Uri.tryParse('https://api.storerestapi.com/products') ?? Uri();
      final response = await client.get(url);
      client.close();
      log(response.statusCode);
      log(response.body);
      final jstr = json.decode(response.body) as Map<String, dynamic>;
      final lst = response.statusCode == 200
          ? List<Map<String, dynamic>>.from(jstr['data'] as List)
              .map<Item>(Item.fromMap)
              .toList()
          : <Item>[];
      log('------------------------');
      log(lst.length);
      log('________________________');
      lst.isEmpty ? doNothing() : itemsController.add(lst);
    });
  } catch (e) {
    log(e);
  }
}

Iterable<int> getNumbers(int number) sync* {
  log('generator started');
  for (int i = 1; i <= number; i++) {
    yield i;
  }
  log('generator ended');
}

Iterable<int> getNumbersRecursive(int number) sync* {
  log('generator $number started');
  if (number > 0) {
    yield* getNumbersRecursive(number - 1);
  } else {
    yield number;
  }
  log('generator $number ended');
}

Stream<int> getValues(int seconds) async* {
  final rand = Random(0);
  while (true) {
    await Future.delayed(Duration(seconds: seconds));
    yield rand.nextInt(10);
  }
}

Stream<List<Todo>> receiveData(Duration duration) async* {
  try {
    while (true) {
      await Future.delayed(duration);
      final client = Client();
      final url =
          Uri.tryParse('https://jsonplaceholder.typicode.com/todos') ?? Uri();
      final response = await client.get(url);
      client.close();
      yield response.statusCode == 200
          ? List<Map<String, dynamic>>.from(json.decode(response.body) as List)
              .map<Todo>(Todo.fromMap)
              .toList()
          : <Todo>[];
    }
  } catch (e) {
    log(e);
    yield <Todo>[];
  }
}

Future<List<County>> obtainStates() async {
  try {
    final request = await httpClient.getUrl(
        Uri.tryParse('https://apptest.pw/bookMygold/User/States.php') ?? Uri());
    final response = await request.close();
    final resStr = await response.transform(utf8.decoder).join();
    final base = Base.fromMap(json.decode(resStr) as Map<String, dynamic>);
    log(resStr);
    return response.statusCode == 200 && base.status == 200
        ? List<Map<String, dynamic>>.from(base.data)
            .map<County>(County.fromMap)
            .toList()
        : <County>[];
  } catch (e) {
    log(e);
    return <County>[];
  }
}

Future<List<City>> getCities(int stateID) async {
  try {
    final clt = Client();
    log(stateID);
    final url = Uri.tryParse(
            'https://apptest.pw/bookMygold/User/Cities.php?state=$stateID') ??
        Uri();
    final req = await httpClient.getUrl(url);
    final res = await req.close();
    final resStr = await res.transform(utf8.decoder).join();
    log(resStr);
    final base = Base.fromMap(json.decode(resStr) as Map<String, dynamic>);
    return res.statusCode == 200 && base.status == 200
        ? List<Map<String, dynamic>>.from(base.data)
            .map<City>(City.fromMap)
            .toList()
        : <City>[];
  } catch (e) {
    log(e);
    return <City>[];
  }
}
