import 'package:flutter/material.dart';
import 'package:grid_test/src/widgets/map_widget.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(body: const MapWidget(), appBar: AppBar()));
  }
}
