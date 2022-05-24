import 'custom_button.dart';
import '../helpers/helper.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final double? elevation;
  final VoidCallback? onPressed;
  final ButtonType type;
  const MyButton({Key? key, this.onPressed, required this.type, this.elevation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomButton(
        elevation: elevation,
        onPressed: onPressed,
        buttonColor: Colors.black,
        labelColor: Colors.white,
        type: type);
  }
}
