import 'dart:async';
import 'package:flutter/material.dart';
import 'package:grid_test/src/helpers/helper.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CircularLoader extends StatefulWidget {
  final Color color;
  final Duration duration;
  final LoaderType? loaderType;
  final double? heightFactor, widthFactor, sizeFactor;
  const CircularLoader(
      {Key? key,
      this.sizeFactor,
      this.loaderType,
      this.widthFactor,
      this.heightFactor,
      required this.color,
      required this.duration})
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

  @override
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
    Widget lc;
    switch (widget.loaderType) {
      case LoaderType.normal:
        lc = CircularProgressIndicator(color: widget.color);
        break;
      case LoaderType.chasingDots:
        lc = SpinKitChasingDots(color: widget.color);
        break;
      case LoaderType.circle:
        lc = SpinKitCircle(color: widget.color);
        break;
      case LoaderType.ring:
        lc = SpinKitRing(color: widget.color);
        break;
      case LoaderType.cubeGrid:
        lc = SpinKitCubeGrid(color: widget.color);
        break;
      case LoaderType.doubleBounce:
        lc = SpinKitDoubleBounce(color: widget.color);
        break;
      case LoaderType.dualRing:
        lc = SpinKitDualRing(color: widget.color);
        break;
      case LoaderType.fadingCircle:
        lc = SpinKitFadingCircle(color: widget.color);
        break;
      case LoaderType.fadingCube:
        lc = SpinKitFadingCube(color: widget.color);
        break;
      case LoaderType.fadingFour:
        lc = SpinKitFadingFour(color: widget.color);
        break;
      case LoaderType.fadingGrid:
        lc = SpinKitFadingGrid(color: widget.color);
        break;
      case LoaderType.foldingCube:
        lc = SpinKitFoldingCube(color: widget.color);
        break;
      case LoaderType.hourGlass:
        lc = SpinKitHourGlass(color: widget.color);
        break;
      case LoaderType.pouringHourGlass:
        lc = SpinKitPouringHourGlass(color: widget.color);
        break;
      case LoaderType.pulse:
        lc = SpinKitPulse(color: widget.color);
        break;
      case LoaderType.pumpingHeart:
        lc = SpinKitPumpingHeart(color: widget.color);
        break;
      case LoaderType.ripple:
        lc = SpinKitRipple(color: widget.color);
        break;
      case LoaderType.rotatingCircle:
        lc = SpinKitRotatingCircle(color: widget.color);
        break;
      case LoaderType.rotatingPlain:
        lc = SpinKitRotatingPlain(color: widget.color);
        break;
      case LoaderType.spinningCircle:
        lc = SpinKitSpinningCircle(color: widget.color);
        break;
      case LoaderType.squareCircle:
        lc = SpinKitSquareCircle(color: widget.color);
        break;
      case LoaderType.threeBounce:
        lc = SpinKitThreeBounce(color: widget.color);
        break;
      case LoaderType.wanderingCubes:
        lc = SpinKitWanderingCubes(color: widget.color);
        break;
      case LoaderType.wave:
        lc = SpinKitWave(color: widget.color);
        break;
      default:
        lc = CircularProgressIndicator(color: widget.color);
        break;
    }
    return AnimatedOpacity(
        opacity: animation == null
            ? 1 /*hp.factor / 2*/
            : (animation!.value > 100.0 ? 1.0 : animation!.value / 100),
        duration: widget.duration,
        child: Center(
            widthFactor: widget.widthFactor,
            heightFactor: widget.heightFactor,
            child: lc));
  }

  void getData() {
    animationController =
        AnimationController(duration: const Duration(milliseconds: 300), vsync: this);
    CurvedAnimation curve =
        CurvedAnimation(parent: animationController!, curve: Curves.easeOut);
    animation = Tween<double>(
            begin: hp.height / (widget.heightFactor ?? hp.factor), end: 0)
        .animate(curve)
      ..addListener(reloadIfMounted);
  }

  void goFrontIfMounted() async {
    if (mounted) {
      await animationController!.forward();
    }
  }

  void reloadIfMounted() {
    if (mounted) setState(() {});
  }

  void assignState() async {
    await Future.delayed(Duration.zero, getData);
    Timer(widget.duration, goFrontIfMounted).cancel();
  }
}
