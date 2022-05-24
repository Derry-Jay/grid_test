import 'package:flutter/material.dart';

import '../helpers/helper.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final FontWeight labelWeight;
  final VoidCallback? onPressed;
  final dynamic buttonColor, labelColor, borderColor;
  final double labelSize, widthFactor, heightFactor, elevation, radiusFactor;
  const CustomButton(
      {Key? key,
      required this.label,
      required this.labelWeight,
      required this.elevation,
      required this.labelSize,
      required this.heightFactor,
      required this.widthFactor,
      required this.radiusFactor,
      required this.onPressed,
      required this.buttonColor,
      required this.labelColor,
      required this.borderColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final hp = Helper.of(context);
    return TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
            elevation: MaterialStateProperty.all(elevation),
            backgroundColor: MaterialStateProperty.all(buttonColor is Color
                ? buttonColor
                : (buttonColor is int
                    ? Color(buttonColor)
                    : (buttonColor is String
                        ? Color(int.parse(buttonColor))
                        : Colors.grey))),
            foregroundColor: MaterialStateProperty.all(labelColor is Color
                ? labelColor
                : (labelColor is int
                    ? Color(labelColor)
                    : (labelColor is String
                        ? Color(int.parse(labelColor))
                        : Colors.grey))),
            padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                vertical: hp.height / heightFactor,
                horizontal: hp.width / widthFactor)),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.all(radiusFactor < 0.000001
                    ? Radius.zero
                    : Radius.circular(hp.radius / radiusFactor)),
                side: BorderSide(
                    color: borderColor is Color
                        ? borderColor
                        : (borderColor is int
                            ? Color(borderColor)
                            : (borderColor is String
                                ? Color(int.parse(borderColor))
                                : Colors.grey)))))),
        child: Text(label,
            style: TextStyle(fontWeight: labelWeight, fontSize: labelSize)));
  }
}
