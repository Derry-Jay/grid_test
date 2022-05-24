import 'empty_widget.dart';
import '../helpers/helper.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Widget? child;
  final ButtonType type;
  final double? elevation;
  final OutlinedBorder? shape;
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry? padding;
  final Color? buttonColor, labelColor;
  const CustomButton(
      {Key? key,
      this.child,
      this.shape,
      this.padding,
      this.elevation,
      this.onPressed,
      this.labelColor,
      this.buttonColor,
      required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final style = ButtonStyle(
        elevation: MaterialStateProperty.all<double?>(elevation),
        backgroundColor: MaterialStateProperty.all<Color?>(buttonColor),
        foregroundColor: MaterialStateProperty.all<Color?>(labelColor),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry?>(padding),
        shape: MaterialStateProperty.all<OutlinedBorder?>(shape));
    switch (type) {
      case ButtonType.raised:
        return ElevatedButton(style: style, onPressed: onPressed, child: child);
      case ButtonType.border:
        return OutlinedButton(
            style: style,
            onPressed: onPressed,
            child: child ?? const EmptyWidget());
      case ButtonType.text:
        return TextButton(
            style: style,
            onPressed: onPressed,
            child: child ?? const EmptyWidget());
    }
  }
}
