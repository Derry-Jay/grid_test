import 'package:flutter/material.dart';
import '../helpers/helper.dart';
import 'custom_button.dart';

class MyButton extends StatelessWidget {
  final String label;
  final FontWeight labelWeight;
  final VoidCallback? onPressed;
  final double labelSize, widthFactor, heightFactor, elevation, radiusFactor;
  const MyButton(
      {Key? key,
      required this.label,
      required this.labelWeight,
      required this.elevation,
      required this.labelSize,
      required this.heightFactor,
      required this.widthFactor,
      required this.radiusFactor,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hp = Helper.of(context);
    return CustomButton(
        // fontSize: fontSize,
        label: label,
        labelWeight: labelWeight,
        elevation: elevation,
        labelSize: labelSize,
        heightFactor: heightFactor,
        widthFactor: widthFactor,
        radiusFactor: radiusFactor,
        onPressed: onPressed,
        buttonColor: hp.theme.primaryColor,
        labelColor: Colors.white,
        borderColor: hp.theme.scaffoldBackgroundColor);
  }
}
