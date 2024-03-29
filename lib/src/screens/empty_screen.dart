import '../widgets/empty_widget.dart';
import 'package:flutter/material.dart';

class EmptyScreen extends StatelessWidget {
  const EmptyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(), body: const EmptyWidget());
  }
}
