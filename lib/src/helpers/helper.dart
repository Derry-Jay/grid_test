import 'dart:ui';
import 'dart:math';
import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:grid_test/route_generator.dart';
import 'package:location/location.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:screenshot/screenshot.dart';
import 'package:flutter_uxcam/flutter_uxcam.dart';
import '../backend/api.dart';
import '/generated/l10n.dart';
import '../widgets/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import '../widgets/circular_loader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPrefs = SharedPreferences.getInstance();

final isIOS = defaultTargetPlatform == TargetPlatform.iOS;

final isMac = defaultTargetPlatform == TargetPlatform.macOS;

final isAndroid = defaultTargetPlatform == TargetPlatform.android;

final isWindows = defaultTargetPlatform == TargetPlatform.windows;

final isLinux = defaultTargetPlatform == TargetPlatform.linux;

final isFuchsia = defaultTargetPlatform == TargetPlatform.fuchsia;

final isWeb =
    !(isAndroid || isIOS || isMac || isWindows || isLinux || isFuchsia);

final dF = isAndroid || isFuchsia || isLinux || isWindows;

final isPortable = isAndroid || isIOS;

final assetImagePath = gc?.getValue<String>('asset_image_path') ?? '';

ARKitController? arkitController;

ScreenshotController con = ScreenshotController();

Location location = Location();

FlutterUxConfig uxc = FlutterUxConfig(userAppKey: '6fkwpg17zc9ma8e');

DateTime? currentBackPressTime;

String imgBaseUrl = '';

Connectivity conn = Connectivity();

WidgetsBinding? wb;

Location place = Location();

RouteGenerator rg = RouteGenerator();

LocationPermission? perm;

PermissionStatus? status;

GoogleMapController? mapCon;

Completer<GoogleMapController> completer = Completer<GoogleMapController>();

DeviceInfoPlugin dip = DeviceInfoPlugin();

enum LoaderType {
  normal,
  rotatingPlain,
  doubleBounce,
  wave,
  wanderingCubes,
  fadingFour,
  fadingCube,
  pulse,
  chasingDots,
  threeBounce,
  circle,
  cubeGrid,
  fadingCircle,
  rotatingCircle,
  foldingCube,
  pumpingHeart,
  hourGlass,
  pouringHourGlass,
  pouringHourGlassRefined,
  fadingGrid,
  ring,
  ripple,
  spinningCircle,
  spinningLines,
  squareCircle,
  dualRing,
  pianoWave,
  dancingSquare,
  threeInOut
}

enum ButtonType { raised, text, border }

enum AlertType { normal, cupertino }

List<Stream<Barcode>> css = <Stream<Barcode>>[];

List<StreamSubscription<Barcode>> scs = <StreamSubscription<Barcode>>[];

void log(Object? object) {
  if (kDebugMode) print(object);
}

void rollbackOrientations() async {
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

void lockScreenRotation() async {
  await SystemChrome.setPreferredOrientations([
    // DeviceOrientation.landscapeRight,
    // DeviceOrientation.landscapeLeft,
    DeviceOrientation.portraitUp,
  ]);
}

void showStatusBar() async {
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.top]);
}

void invokeVCB(VoidCallback vcb) {
  log('object');
  vcb.call();
  log('object2');
}

void getLocationPermission() async {
  final locPerm = await location.hasPermission();
  status = locPerm == PermissionStatus.granted ||
          locPerm == PermissionStatus.grantedLimited
      ? locPerm
      : await location.requestPermission();
  if (!(status == PermissionStatus.granted ||
      status == PermissionStatus.grantedLimited)) {
    getLocationPermission();
  }
}

void getGPSPermission() async {
  final getPerm = await Geolocator.checkPermission();
  perm = getPerm == LocationPermission.always ||
          getPerm == LocationPermission.whileInUse
      ? getPerm
      : (await Geolocator.requestPermission());
  if (!(perm == LocationPermission.always ||
      perm == LocationPermission.whileInUse)) {
    getGPSPermission();
  }
}

void hideLoader(Duration time, {LoaderType? type}) {
  Timer(time, () {
    try {
      overlayLoader(time, type: type).remove();
    } catch (e) {
      log(e);
    }
  }).cancel();
}

void getAppVersion() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  log(packageInfo.version);
}

void doNothing() {}

bool Function(Route<dynamic>) getRoutePredicate(String routeName) {
  return ModalRoute.withName(routeName);
}

OverlayEntry overlayLoader(Duration time, {LoaderType? type}) {
  Widget loaderBuilder(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Positioned(
        top: 0,
        left: 0,
        width: size.width,
        height: size.height,
        child: Material(
            color: theme.primaryColor.withOpacity(0.85),
            child: CircularLoader(
                duration: time,
                loaderType: type,
                // heightFactor: 16,
                // widthFactor: 16,
                color: theme.primaryColor)));
  }

  return OverlayEntry(builder: loaderBuilder);
}

List<String> getFirstAndLastName(String name) {
  List<String> ls = [];
  if (name.isNotEmpty) {
    ls.add(name.trim().split(' ')[0]);
    ls.add(name.trim().split(' ')[name.trim().split(' ').length - 1]);
  }
  return ls;
}

String putDateTimeToString(DateTime element, String sep) {
  int ds = (element.millisecond * 1000) + element.microsecond;
  String str = element.year.toString();
  str +=
      ('$sep${element.month}$sep${element.day}|${element.hour}:${element.minute}:${element.second}.$ds');
  return str;
}

Widget errorBuilder(BuildContext context, Object object, StackTrace? trace) {
  final hpe = Helper.of(context);
  log(object);
  log(trace);
  return Icon(Icons.error,
      size: hpe.height / 16, color: hpe.theme.secondaryHeaderColor);
}

Widget getPageLoader(Size size) {
  return Image.asset('${assetImagePath}loading_trend.gif',
      width: size.width, fit: BoxFit.fill, height: size.height);
}

Widget getPageLoader1(Size size) {
  return Image.asset('${assetImagePath}loader1.gif',
      width: size.width, fit: BoxFit.fill, height: size.height);
}

Widget getPlaceHolder(BuildContext context, String url) {
  final size = MediaQuery.of(context).size;
  return Image.asset('${assetImagePath}loading.gif',
      height: size.height / 12.8, width: size.width / 6.4, fit: BoxFit.fill);
}

Widget getPlaceHolderNoImage(BuildContext context, String url) {
  final size = MediaQuery.of(context).size;
  return Image.asset('${assetImagePath}noImage.png',
      height: size.height / 12.8, width: size.width / 6.4, fit: BoxFit.fill);
}

Widget getErrorWidgetNoImage(BuildContext context, String url, dynamic error) {
  final size = MediaQuery.of(context).size;
  return Image.asset('${assetImagePath}noImage.png',
      height: size.height / 12.8, width: size.width / 6.4, fit: BoxFit.fill);
}

Widget getErrorWidget(BuildContext context, String url, dynamic error) {
  final size = MediaQuery.of(context).size;
  return Image.asset('${assetImagePath}noImage.png',
      height: size.height / 12.8, width: size.width / 6.4, fit: BoxFit.fill);
}

Future<bool> revealToast(String content,
    {double? fontSize, ToastGravity? gravity, Toast? length}) async {
  try {
    final p = await Fluttertoast.showToast(
            msg: content,
            fontSize: fontSize,
            gravity: gravity,
            toastLength: length) ??
        false;
    return p;
  } catch (e) {
    rethrow;
  }
}

TimeOfDay getTime(String s) {
  if (s.isEmpty || ':'.allMatches(s).length != 2) {
    return const TimeOfDay(hour: 0, minute: 0);
  } else {
    final a = s.trim().split(':');
    return TimeOfDay(
        hour: (int.tryParse(a.first) ?? 0), minute: (int.tryParse(a[1]) ?? 0));
  }
}

bool hasOnlyZeroes(List<num> list) {
  if (list.isEmpty) {
    return true;
  } else {
    bool val = true;
    for (num i in list) {
      if (i != 0) {
        val = false;
        break;
      } else {
        continue;
      }
    }
    return val;
  }
}

num getSumOfNumList(List<num> list) {
  if (list.isEmpty) {
    return num.tryParse('0') ?? 0;
  } else {
    num s = 0;
    for (num i in list) {
      s += i;
    }
    return s;
  }
}

num getLargestNumber(List<num> list) {
  if (list.isEmpty) {
    return -1;
  } else if (list.length == 1) {
    return list.first;
  } else {
    num val = list.first;
    for (num i in list) {
      if (i > val) val = i;
    }
    return val;
  }
}

int largestFactorUnderTen(int no, {int lmt = 10}) {
  int fact = 0;
  for (int i = 2; i < no; i++) {
    if (i > (lmt - 1)) {
      break;
    } else if (no % i == 0) {
      fact = i;
    }
  }
  return fact;
}

bool compareDates(DateTime a, DateTime b) {
  return a.year == b.year &&
      a.month == b.month &&
      a.day == b.day &&
      a.hour == b.hour &&
      a.minute == b.minute &&
      a.second == b.second &&
      a.millisecond == b.millisecond &&
      a.microsecond == b.microsecond;
}

double getTax(num orderamount) {
  return (5 * orderamount) / 100;
}

bool predicate(Route<dynamic> route) {
  log(route);
  return false;
}

List<Icon> getStarsList(double rate, {double size = 18}) {
  final list = List<Icon>.generate(rate.floor(), (index) {
    return Icon(Icons.star, size: size, color: const Color(0xFFFFB24D));
  });
  if (rate - rate.floor() > 0) {
    list.add(Icon(Icons.star_half, size: size, color: const Color(0xFFFFB24D)));
  }
  list.addAll(List<Icon>.generate(
      5 - rate.floor() - (rate - rate.floor()).ceil(), (index) {
    return Icon(Icons.star_border, size: size, color: const Color(0xFFFFB24D));
  }));
  return list;
}

Future<List<String>> getLocalStorageKeys() async {
  final prefs = await sharedPrefs;
  return prefs.getKeys().toList();
}

bool parseBool(String? source) {
  return (source?.isNotEmpty ?? false) &&
      (source?.toLowerCase() == 'true' ||
          source?.toUpperCase() == 'TRUE' ||
          source?.toLowerCase() == 'yes' ||
          source?.toUpperCase() == 'YES' ||
          source?.toLowerCase() == 'ok' ||
          source?.toUpperCase() == 'OK' ||
          ((int.tryParse(source ?? '0') ?? 0) > 0));
}

String limitString(String text, {int limit = 24, String hiddenText = '...'}) {
  return text.substring(0, min<int>(limit, text.length)) +
      (text.length > limit ? hiddenText : '');
}

String getCreditCardNumber(String number) {
  String result = '';
  if (number.isNotEmpty && number.length == 16) {
    result = number.substring(0, 4);
    result += ' ${number.substring(4, 8)}';
    result += ' ${number.substring(8, 12)}';
    result += ' ${number.substring(12, 16)}';
  }
  return result;
}

Uri getUri(String path) {
  String path =
      Uri.tryParse(gc?.getValue<String>('base_url') ?? '')?.path ?? '';
  if (!path.endsWith('/')) {
    path += '/';
  }
  Uri uri = Uri(
      scheme: Uri.tryParse(gc?.getValue<String>('base_url') ?? '')?.scheme,
      host: Uri.tryParse(gc?.getValue<String>('base_url') ?? '')?.host,
      port: Uri.tryParse(gc?.getValue('base_url') ?? '')?.port,
      path: path + path);
  return uri;
}

Color getColorFromHex(String hex) {
  try {
    if (hex.contains('#')) {
      return Color(int.tryParse(hex.replaceAll('#', '0xFF')) ?? 0x00000000);
    } else {
      return Color(int.tryParse('0xFF$hex') ?? 0x00000000);
    }
  } catch (e) {
    log(e);
    return const Color(0x00000000);
  }
}

BoxFit getBoxFit(String boxFit) {
  switch (boxFit) {
    case 'cover':
      return BoxFit.cover;
    case 'fill':
      return BoxFit.fill;
    case 'contain':
      return BoxFit.contain;
    case 'fit_height':
      return BoxFit.fitHeight;
    case 'fit_width':
      return BoxFit.fitWidth;
    case 'none':
      return BoxFit.none;
    case 'scale_down':
      return BoxFit.scaleDown;
    default:
      return BoxFit.cover;
  }
}

AlignmentDirectional getAlignmentDirectional(String alignmentDirectional) {
  switch (alignmentDirectional) {
    case 'top_start':
      return AlignmentDirectional.topStart;
    case 'top_center':
      return AlignmentDirectional.topCenter;
    case 'top_end':
      return AlignmentDirectional.topEnd;
    case 'center_start':
      return AlignmentDirectional.centerStart;
    case 'center':
      return AlignmentDirectional.topCenter;
    case 'center_end':
      return AlignmentDirectional.centerEnd;
    case 'bottom_start':
      return AlignmentDirectional.bottomStart;
    case 'bottom_center':
      return AlignmentDirectional.bottomCenter;
    case 'bottom_end':
    default:
      return AlignmentDirectional.bottomEnd;
  }
}

List<double> getVector(LatLng point) {
  final latRad = (point.latitude * 11) / 630; // convert to radians
  final longRad = (point.longitude * 11) / 630; // convert to radians
  return <double>[
    (cos(latRad) * cos(longRad)),
    (cos(latRad) * sin(longRad)),
    sin(latRad)
  ];
}

List<double> getCoords(LatLng point) {
  final latRad = (point.latitude * 11) / 630; // convert to radians
  final longRad = (point.longitude * 11) / 630; // convert to radians
  return <double>[(cos(latRad) * cos(longRad)), (cos(latRad) * sin(longRad))];
}

double getDoubleData(Map<String, dynamic> data) {
  return (data['data'] as double);
}

bool getBoolData(Map<String, dynamic> data) {
  return (data['data'] as bool);
}

String getData(List<int> values) {
  return base64.encode(values);
}

Uint8List putData(String value) {
  return base64.decode(value);
}

Uint8List fromIntList(List<int> list) {
  return putData(getData(list));
}

double haversineDistance(LatLng a, LatLng b) {
  double dLat = ((b.latitude - a.latitude).abs() * 11) / 630;
  double dLong = ((b.longitude - a.longitude).abs() * 11) / 630;
  final v1 = 1 + cos(dLat);
  final v2 = 2 *
      cos((a.latitude * 11) / 630) *
      cos((b.latitude * 11) / 630) *
      cos(dLong);
  return (12.742 * asin(sqrt(((v1 - v2).abs()) / 2)));
}

double getAngle(LatLng a, LatLng b) {
  // double dLat = ((b.latitude - a.latitude).abs() * 11) / 630;
  double dLon = ((b.longitude - a.longitude).abs() * 11) / 630;
  final y = sin(dLon) * cos(b.longitude);
  final x = cos(a.latitude) * sin(b.latitude) -
      sin(a.latitude) * cos(b.latitude) * cos(dLon);
  return atan2(y, x);
}

Widget imageFromBytesBuilder(
    BuildContext context, List<int>? pic, Widget? child) {
  try {
    return Image.memory(Uint8List.fromList(pic!));
  } catch (e) {
    log(e);
    return (child ?? const EmptyWidget());
  }
}

Future<Uint8List> getBytesFromAsset(String path, {int? width}) async {
  ByteData data = await rootBundle.load(path);
  final codec = await instantiateImageCodec(data.buffer.asUint8List(),
      targetWidth: width);
  FrameInfo fi = await codec.getNextFrame();
  return (await fi.image.toByteData(format: ImageByteFormat.png))!
      .buffer
      .asUint8List();
}

String putDateToString(DateTime dt) => '${dt.month}/${dt.year}';

class Helper extends ChangeNotifier {
  late BuildContext buildContext;
  S get loc => S.of(buildContext);
  ThemeData get theme => Theme.of(buildContext);
  OverlayState? get ol => Overlay.of(buildContext);
  NavigatorState get nav => Navigator.of(buildContext);
  MediaQueryData get dimensions =>
      MediaQuery.maybeOf(buildContext) ?? MediaQuery.of(buildContext);
  ModalRoute<Object?>? get route => ModalRoute.of(buildContext);
  AnimatedListState get als =>
      AnimatedList.maybeOf(buildContext) ?? AnimatedList.of(buildContext);
  ScaffoldState get sct =>
      Scaffold.maybeOf(buildContext) ?? Scaffold.of(buildContext);
  SliverAnimatedListState get slas =>
      SliverAnimatedList.maybeOf(buildContext) ??
      SliverAnimatedList.of(buildContext);
  ScaffoldMessengerState get smcT =>
      ScaffoldMessenger.maybeOf(buildContext) ??
      ScaffoldMessenger.of(buildContext);
  Size get size => dimensions.size;
  double get pixelRatio => dimensions.devicePixelRatio;
  double get textScaleFactor =>
      (MediaQuery.textScaleFactorOf(buildContext) +
          dimensions.textScaleFactor) /
      2;
  double get height => size.height;
  double get width => size.width;
  double get aspectRatio => size.aspectRatio;
  double get radius => sqrt(pow(height, 2) + pow(width, 2));
  State? get st => buildContext.findAncestorStateOfType();
  TextTheme get textTheme => theme.textTheme;
  double get factor => pow(
          (pow(aspectRatio, 3) + pow(textScaleFactor, 3) + pow(pixelRatio, 3)),
          1 / 3)
      .toDouble();

  bool get isMobile => isPortable && size.shortestSide < 600;

  bool get isTablet => isPortable && size.shortestSide >= 600;
  Helper.of(BuildContext context) {
    buildContext = context;
  }

  String trans(String text) {
    switch (text) {
      case 'App\\Notifications\\StatusChangedOrder':
        return loc.order_status_changed;
      case 'App\\Notifications\\NewOrder':
        return loc.new_order_from_client;
      case 'km':
        return loc.km;
      case 'mi':
        return loc.mi;
      default:
        return '';
    }
  }

  void onChange() {
    notifyListeners();
  }

  Future<DateTime> getDatePicker(TextEditingController tc) async {
    final today = DateTime.now();
    final picked = await showDatePicker(
            context: buildContext,
            initialDate: today,
            firstDate: DateTime(today.year, today.month),
            lastDate: DateTime(today.year + 100, today.month)) ??
        today;
    tc.text = putDateToString(picked);
    return picked;
  }

  Future<bool> onWillPop() async {
    DateTime now = DateTime.now();
    if (currentBackPressTime != null &&
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      final p = await Fluttertoast.showToast(msg: loc.tapAgainToLeave) ?? true;
      return Future.value(!p);
    }
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    return Future.value(true);
  }

  void reload(VoidCallback vcb) {
    st?.setState(vcb);
  }

  void goTo(String routeName, {dynamic args, VoidCallback? vcb}) async {
    try {
      if (route != null && route!.settings.name != routeName) {
        final p = await nav.pushNamed(routeName, arguments: args);
        log(p);
        if (vcb != null) {
          reload(vcb);
        }
      } else {
        log(routeName);
      }
    } catch (e) {
      log(e);
    }
  }

  void gotoOnce(String routeName,
      {dynamic args, dynamic result, VoidCallback? vcb}) async {
    try {
      if (route?.settings.name != routeName) {
        final p = await nav.pushReplacementNamed(routeName,
            arguments: args, result: result);
        if (vcb != null) {
          reload(vcb);
        }
        log(p);
      } else {
        log(routeName);
      }
    } catch (e) {
      log(e);
    }
  }

  void gotoForever(String routeName, {dynamic args}) async {
    try {
      if (route?.settings.name != routeName) {
        final p = await nav.pushNamedAndRemoveUntil(routeName, predicate,
            arguments: args);
        log(p);
      } else {
        log(routeName);
      }
    } catch (e) {
      log(e);
    }
  }

  void goBackForeverTo(String routeName) {
    try {
      nav.popUntil(getRoutePredicate(routeName));
    } catch (e) {
      log(e);
    }
  }

  void goBack({dynamic result}) {
    try {
      log(result);
      nav.pop(result);
    } catch (e) {
      log(e);
    }
  }

  void goBackEmpty() {
    goBack();
  }

  void addLoader(Duration time, {LoaderType? type}) {
    if (ol?.mounted ?? false) {
      ol?.insert(overlayLoader(time, type: type));
    }
  }

  void getConnectStatus({VoidCallback? vcb}) async {
    final connectivityResult = await conn.checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      final f1 = await revealDialogBox([
        'Try Again'
      ], [
        () {
          goBack(result: connectivityResult == ConnectivityResult.none);
          getConnectStatus();
        }
      ],
          action: 'You are Off-Line!!!!!',
          type: AlertType.cupertino,
          dismissive: false);
      if (!f1) goBack();
    } else {
      // I am connected to a mobile network.
      vcb?.call();
    }
  }

  Future<bool> showPleaseWait() {
    return revealToast('Please Wait....', length: Toast.LENGTH_LONG);
  }

  Future<bool?> appearDialogBox(
      {Widget? title,
      AlertType? type,
      Widget? content,
      bool? dismissive,
      String? barrierLabel,
      List<Widget>? actions,
      TextStyle? titleStyle,
      Curve? insetAnimation,
      TextStyle? actionStyle,
      Duration? insetDuration,
      EdgeInsets? titlePadding,
      EdgeInsets? actionPadding,
      EdgeInsets? buttonPadding,
      EdgeInsets? contentPadding,
      RouteSettings? routeSettings,
      ScrollController? scrollController,
      MainAxisAlignment? actionsAlignment,
      ScrollController? actionScrollController}) {
    Widget dialogBuilder(BuildContext context) {
      switch (type) {
        case AlertType.cupertino:
          return CupertinoAlertDialog(
              title: title,
              content: content,
              actions: actions ?? <Widget>[],
              scrollController: scrollController,
              actionScrollController: actionScrollController,
              insetAnimationCurve: insetAnimation ?? Curves.decelerate,
              insetAnimationDuration:
                  insetDuration ?? const Duration(milliseconds: 100));
        case AlertType.normal:
        default:
          return AlertDialog(
              title: title,
              content: content,
              actions: actions,
              titlePadding: titlePadding,
              titleTextStyle: titleStyle,
              buttonPadding: buttonPadding,
              contentTextStyle: actionStyle,
              actionsAlignment: actionsAlignment,
              actionsPadding: actionPadding ?? EdgeInsets.zero,
              contentPadding: contentPadding ??
                  EdgeInsets.symmetric(
                      horizontal: width / 25, vertical: height / 100));
      }
    }

    return type == AlertType.cupertino
        ? showCupertinoDialog<bool>(
            context: buildContext,
            builder: dialogBuilder,
            barrierLabel: barrierLabel,
            routeSettings: routeSettings,
            barrierDismissible: dismissive ?? false)
        : showDialog<bool>(
            context: buildContext,
            builder: dialogBuilder,
            barrierLabel: barrierLabel,
            routeSettings: routeSettings,
            barrierDismissible: dismissive ?? false);
  }

  Future<bool> revealDialogBox(List<String> options, List<VoidCallback> actions,
      {String? title,
      String? action,
      AlertType? type,
      bool? dismissive,
      Curve? insetAnimation,
      TextStyle? titleStyle,
      TextStyle? actionStyle,
      TextStyle? optionStyle,
      Duration? insetDuration,
      EdgeInsets? titlePadding,
      EdgeInsets? actionPadding,
      EdgeInsets? buttonPadding,
      ScrollController? scrollController,
      ScrollController? actionScrollController}) async {
    Widget optionsMap(String e) {
      final child = Text(e, style: optionStyle);
      final onTap = actions[options.indexOf(e)];
      log(type);
      switch (type) {
        case AlertType.cupertino:
          return CupertinoDialogAction(
              onPressed: onTap, textStyle: actionStyle, child: child);
        case AlertType.normal:
        default:
          return TextButton(onPressed: onTap, child: child);
      }
    }

    return options.length == actions.length &&
            options.isNotEmpty &&
            actions.isNotEmpty
        ? (await showDialogBox(
                type: type,
                dismissive: dismissive,
                titleStyle: titleStyle,
                actionStyle: actionStyle,
                titlePadding: titlePadding,
                buttonPadding: buttonPadding,
                actionPadding: actionPadding,
                insetDuration: insetDuration,
                insetAnimation: insetAnimation,
                scrollController: scrollController,
                actionScrollController: actionScrollController,
                actions: options.map<Widget>(optionsMap).toList(),
                title: title == null ? null : Text(title),
                content: action == null ? null : Text(action)) ??
            false)
        : options.length == actions.length &&
            options.isNotEmpty &&
            actions.isNotEmpty;
  }

  Future<bool> showSimpleYesNo(
      {bool? flag,
      bool? reverse,
      String? title,
      String? action,
      AlertType? type,
      bool? dismissive,
      Curve? insetAnimation,
      TextStyle? titleStyle,
      TextStyle? actionStyle,
      TextStyle? optionStyle,
      Duration? insetDuration,
      EdgeInsets? titlePadding,
      EdgeInsets? actionPadding,
      EdgeInsets? buttonPadding,
      ScrollController? scrollController,
      ScrollController? actionScrollController}) {
    VoidCallback mapAction(String action) {
      return () {
        goBack(result: parseBool(action));
      };
    }

    final options = [
      (flag ?? true) ? 'YES' : 'OK',
      (flag ?? true) ? 'NO' : 'Cancel'
    ];
    final actions = ((reverse ?? false) ? options.reversed : options)
        .map<VoidCallback>(mapAction)
        .toList();
    return revealDialogBox(options, actions,
        type: type,
        title: title,
        action: action,
        dismissive: dismissive,
        titleStyle: titleStyle,
        actionStyle: actionStyle,
        optionStyle: optionStyle,
        titlePadding: titlePadding,
        insetDuration: insetDuration,
        buttonPadding: buttonPadding,
        actionPadding: actionPadding,
        insetAnimation: insetAnimation,
        scrollController: scrollController,
        actionScrollController: actionScrollController);
  }

  Future<bool> showSimplePopup(String option, VoidCallback onActionDone,
      {String? action,
      String? title,
      AlertType? type,
      bool? dismissive,
      Curve? insetAnimation,
      TextStyle? titleStyle,
      TextStyle? actionStyle,
      TextStyle? optionStyle,
      Duration? insetDuration,
      EdgeInsets? titlePadding,
      EdgeInsets? actionPadding,
      EdgeInsets? buttonPadding,
      ScrollController? scrollController,
      ScrollController? actionScrollController}) {
    return revealDialogBox([option], [onActionDone],
        type: type,
        title: title,
        action: action,
        dismissive: dismissive,
        titleStyle: titleStyle,
        actionStyle: actionStyle,
        optionStyle: optionStyle,
        titlePadding: titlePadding,
        buttonPadding: buttonPadding,
        actionPadding: actionPadding,
        insetDuration: insetDuration,
        insetAnimation: insetAnimation,
        scrollController: scrollController,
        actionScrollController: actionScrollController);
  }

  Future<T?> showDialogBox<T>(
      {Widget? child,
      Widget? title,
      AlertType? type,
      Widget? content,
      bool? dismissive,
      String? barrierLabel,
      List<Widget>? actions,
      TextStyle? titleStyle,
      Curve? insetAnimation,
      TextStyle? actionStyle,
      Duration? insetDuration,
      EdgeInsets? titlePadding,
      EdgeInsets? actionPadding,
      EdgeInsets? buttonPadding,
      EdgeInsets? contentPadding,
      RouteSettings? routeSettings,
      ScrollController? scrollController,
      MainAxisAlignment? actionsAlignment,
      ScrollController? actionScrollController}) {
    Widget dialogBuilder(BuildContext context) {
      switch (type) {
        case AlertType.cupertino:
          return CupertinoAlertDialog(
              title: title,
              content: content,
              actions: actions ?? <Widget>[],
              scrollController: scrollController,
              actionScrollController: actionScrollController,
              insetAnimationCurve: insetAnimation ?? Curves.decelerate,
              insetAnimationDuration:
                  insetDuration ?? const Duration(milliseconds: 100));
        case AlertType.normal:
          return AlertDialog(
              title: title,
              content: content,
              actions: actions,
              titlePadding: titlePadding,
              titleTextStyle: titleStyle,
              buttonPadding: buttonPadding,
              contentTextStyle: actionStyle,
              actionsAlignment: actionsAlignment,
              actionsPadding: actionPadding ?? EdgeInsets.zero,
              contentPadding: contentPadding ??
                  EdgeInsets.symmetric(
                      horizontal: width / 25, vertical: height / 100));
        default:
          return child ?? const EmptyWidget();
      }
    }

    switch (type) {
      case AlertType.cupertino:
        return showCupertinoDialog<T>(
            context: buildContext,
            builder: dialogBuilder,
            barrierLabel: barrierLabel,
            barrierDismissible: dismissive ?? false,
            routeSettings: routeSettings ?? route?.settings);
      case AlertType.normal:
      default:
        return showDialog<T>(
            context: buildContext,
            builder: dialogBuilder,
            barrierLabel: barrierLabel,
            barrierDismissible: dismissive ?? false,
            routeSettings: routeSettings ?? route?.settings);
    }
  }

  Future<T?> manifestDialogBox<T>(
      List<String> options, List<VoidCallback> actions,
      {String? title,
      String? action,
      AlertType? type,
      bool? dismissive,
      TextStyle? titleStyle,
      TextStyle? actionStyle,
      TextStyle? optionStyle,
      Duration? insetDuration,
      EdgeInsets? titlePadding,
      EdgeInsets? actionPadding,
      EdgeInsets? buttonPadding,
      ScrollController? scrollController,
      ScrollController? actionScrollController,
      Curve? insetAnimation}) async {
    Widget optionsMap(String e) {
      final child = Text(e, style: optionStyle);
      final onTap = actions[options.indexOf(e)];
      log(type);
      switch (type) {
        case AlertType.cupertino:
          return CupertinoDialogAction(
              onPressed: onTap, textStyle: actionStyle, child: child);
        case AlertType.normal:
        default:
          return CustomButton(
              type: ButtonType.text, onPressed: onTap, child: child);
      }
    }

    return options.length == actions.length &&
            options.isNotEmpty &&
            actions.isNotEmpty
        ? await showDialogBox<T>(
            type: type,
            dismissive: dismissive,
            titleStyle: titleStyle,
            actionStyle: actionStyle,
            titlePadding: titlePadding,
            buttonPadding: buttonPadding,
            actionPadding: actionPadding,
            insetDuration: insetDuration,
            insetAnimation: insetAnimation,
            scrollController: scrollController,
            title: title == null ? null : Text(title),
            content: action == null ? null : Text(action),
            actionScrollController: actionScrollController,
            actions: options.map<Widget>(optionsMap).toList())
        : null;
  }

  String? validatePhoneNumber(String? phone) {
    return (phone != null && phone.length == 10 && int.tryParse(phone) != null
        ? null
        : loc.not_a_valid_phone);
  }

  String? validatePassword(String? password) {
    RegExp re =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$&*~]).{8,}$');
    return password != null &&
            password.isNotEmpty &&
            password.length >= 6 &&
            password.length <= 12 &&
            re.hasMatch(password)
        ? null
        : loc.wrong_email_or_password;
  }

  String? validateEmail(String? email) {
    RegExp re = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
    return email != null &&
            email.isNotEmpty &&
            re.hasMatch(email) &&
            re.allMatches(email).length == 1
        ? null
        : loc.not_a_valid_email;
  }

  String? validateName(String? value) =>
      value != null || value!.isEmpty ? loc.not_a_valid_full_name : null;
}
