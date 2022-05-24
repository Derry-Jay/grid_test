import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:grid_test/src/helpers/helper.dart';

enum LoaderType {
  Normal,
  RotatingPlain,
  DoubleBounce,
  Wave,
  WanderingCubes,
  FadingFour,
  FadingCube,
  Pulse,
  ChasingDots,
  ThreeBounce,
  Circle,
  CubeGrid,
  FadingCircle,
  RotatingCircle,
  FoldingCube,
  PumpingHeart,
  DualRing,
  HourGlass,
  PouringHourGlass,
  FadingGrid,
  Ring,
  Ripple,
  SpinningCircle,
  SquareCircle
}

class CircularLoader extends StatefulWidget {
  final double heightFactor;
  final LoaderType loaderType;
  final Color color;
  const CircularLoader(
      {Key? key,
      required this.heightFactor,
      required this.loaderType,
      required this.color})
      : super(key: key);

  @override
  CircularLoaderState createState() => CircularLoaderState();
}

class CircularLoaderState extends State<CircularLoader>
    with SingleTickerProviderStateMixin {
  Animation<double>? animation;
  AnimationController? animationController;
  Duration timing = const Duration(milliseconds: 600);
  Helper get hp => Helper.of(context);

  void initState() {
    super.initState();
    assignState();
  }

  @override
  void dispose() {
    animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final opacity = animation == null
        ? 1.0
        : (animation!.value > 100.0 ? 1.0 : animation!.value / 100);
    final lc;
    switch (widget.loaderType) {
      case LoaderType.Normal:
        lc = CircularProgressIndicator(color: widget.color);
        break;
      case LoaderType.ChasingDots:
        lc = SpinKitChasingDots(color: widget.color);
        break;
      case LoaderType.Circle:
        lc = SpinKitCircle(color: widget.color);
        break;
      case LoaderType.Ring:
        lc = SpinKitRing(color: widget.color);
        break;
      case LoaderType.CubeGrid:
        lc = SpinKitCubeGrid(color: widget.color);
        break;
      case LoaderType.DoubleBounce:
        lc = SpinKitDoubleBounce(color: widget.color);
        break;
      case LoaderType.DualRing:
        lc = SpinKitDualRing(color: widget.color);
        break;
      case LoaderType.FadingCircle:
        lc = SpinKitFadingCircle(color: widget.color);
        break;
      case LoaderType.FadingCube:
        lc = SpinKitFadingCube(color: widget.color);
        break;
      case LoaderType.FadingFour:
        lc = SpinKitFadingFour(color: widget.color);
        break;
      case LoaderType.FadingGrid:
        lc = SpinKitFadingGrid(color: widget.color);
        break;
      case LoaderType.FoldingCube:
        lc = SpinKitFoldingCube(color: widget.color);
        break;
      case LoaderType.HourGlass:
        lc = SpinKitHourGlass(color: widget.color);
        break;
      case LoaderType.PouringHourGlass:
        lc = SpinKitPouringHourglass(color: widget.color);
        break;
      case LoaderType.Pulse:
        lc = SpinKitPulse(color: widget.color);
        break;
      case LoaderType.PumpingHeart:
        lc = SpinKitPumpingHeart(color: widget.color);
        break;
      case LoaderType.Ripple:
        lc = SpinKitRipple(color: widget.color);
        break;
      case LoaderType.RotatingCircle:
        lc = SpinKitRotatingCircle(color: widget.color);
        break;
      case LoaderType.RotatingPlain:
        lc = SpinKitRotatingPlain(color: widget.color);
        break;
      case LoaderType.SpinningCircle:
        lc = SpinKitSpinningCircle(color: widget.color);
        break;
      case LoaderType.SquareCircle:
        lc = SpinKitSquareCircle(color: widget.color);
        break;
      case LoaderType.ThreeBounce:
        lc = SpinKitThreeBounce(color: widget.color);
        break;
      case LoaderType.WanderingCubes:
        lc = SpinKitWanderingCubes(color: widget.color);
        break;
      case LoaderType.Wave:
        lc = SpinKitWave(color: widget.color);
        break;
      default:
        lc = CircularProgressIndicator(color: widget.color);
        break;
    }
    return Opacity(
        opacity: opacity,
        child: SizedBox(
            height: hp.height / widget.heightFactor, child: Center(child: lc)));
  }

  void getData() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    CurvedAnimation curve =
        CurvedAnimation(parent: animationController!, curve: Curves.easeOut);
    animation = Tween<double>(begin: hp.height / widget.heightFactor, end: 0)
        .animate(curve)
      ..addListener(reloadIfMounted);
  }

  void goFrontIfMounted() {
    if (mounted) animationController!.forward();
  }

  void reloadIfMounted() {
    if (mounted) setState(() {});
  }

  void assignState() {
    Future.delayed(Duration.zero, getData);
    Timer(Duration(seconds: 15), goFrontIfMounted);
  }
}
