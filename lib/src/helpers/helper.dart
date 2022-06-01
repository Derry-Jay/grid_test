import 'dart:ui';
import 'dart:math';
import 'dart:async';
import 'dart:typed_data';
import '/generated/l10n.dart';
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
import 'package:global_configuration/global_configuration.dart';

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
  dualRing,
  hourGlass,
  pouringHourGlass,
  fadingGrid,
  ring,
  ripple,
  spinningCircle,
  squareCircle
}

enum ButtonType { raised, text, border }

enum AlertType { normal, cupertino }

WidgetsBinding? wb;

Stream<Barcode>? bcs;

StreamSubscription<Barcode>? bcsp;

List getList(Map<String, dynamic> data) {
  return data['data'] ?? [];
}

int getIntData(Map<String, dynamic> data) {
  return (data['data'] as int);
}

double getDoubleData(Map<String, dynamic> data) {
  return (data['data'] as double);
}

bool getBoolData(Map<String, dynamic> data) {
  return (data['data'] as bool);
}

getObjectData(Map<String, dynamic> data) {
  return data['data'] ?? <String, dynamic>{};
}

Future<Uint8List> getBytesFromAsset(String path, {int? width}) async {
  ByteData data = await rootBundle.load(path);
  Codec codec = await instantiateImageCodec(data.buffer.asUint8List(),
      targetWidth: width);
  FrameInfo fi = await codec.getNextFrame();
  return (await fi.image.toByteData(format: ImageByteFormat.png))!
      .buffer
      .asUint8List();
}

void log(Object? object) {
  if (kDebugMode) print(object);
}

List<Icon> getStarsList(double rate, {double size = 18}) {
  var list = <Icon>[];
  list = List.generate(rate.floor(), (index) {
    return Icon(Icons.star, size: size, color: const Color(0xFFFFB24D));
  });
  if (rate - rate.floor() > 0) {
    list.add(Icon(Icons.star_half, size: size, color: const Color(0xFFFFB24D)));
  }
  list.addAll(
      List.generate(5 - rate.floor() - (rate - rate.floor()).ceil(), (index) {
    return Icon(Icons.star_border, size: size, color: const Color(0xFFFFB24D));
  }));
  return list;
}

Future<List<String>> getLocalStorageKeys() async {
  final prefs = await sharedPrefs;
  return prefs.getKeys().toList();
}

bool parseBool(String? source) {
  return source != null &&
      source.isNotEmpty &&
      (source.toLowerCase() == 'true' ||
          source.toUpperCase() == 'TRUE' ||
          ((int.tryParse(source) ?? 0) > 0));
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
  String path = Uri.parse(GlobalConfiguration().getValue('base_url')).path;
  if (!path.endsWith('/')) {
    path += '/';
  }
  Uri uri = Uri(
      scheme: Uri.parse(GlobalConfiguration().getValue('base_url')).scheme,
      host: Uri.parse(GlobalConfiguration().getValue('base_url')).host,
      port: Uri.parse(GlobalConfiguration().getValue('base_url')).port,
      path: path + path);
  return uri;
}

Color getColorFromHex(String hex) {
  if (hex.contains('#')) {
    return Color(int.parse(hex.replaceAll('#', '0xFF')));
  } else {
    return Color(int.parse('0xFF$hex'));
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
      return AlignmentDirectional.bottomEnd;
    default:
      return AlignmentDirectional.bottomEnd;
  }
}

String putDateToString(DateTime dt) => '${dt.month}/${dt.year}';

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

double getTax(orderamount) {
  return (5 * orderamount) / 100;
}

bool predicate(Route<dynamic> route) {
  log(route);
  return false;
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

void hideLoader(Duration time, {LoaderType? type}) {
  Timer(time, () {
    try {
      overlayLoader(time, type: type).remove();
    } catch (e) {
      log(e);
    }
  }).cancel();
}

Widget errorBuilder(BuildContext context, Object object, StackTrace? trace) {
  final size = MediaQuery.of(context).size;
  return Image.asset('assets/images/loading.gif',
      matchTextDirection: true,
      height: size.height / 12.8,
      width: size.width / 6.4,
      fit: BoxFit.fill);
}

Widget getPageLoader(Size size) {
  return Image.asset('assets/images/loading_trend.gif',
      width: size.width, fit: BoxFit.fill, height: size.height);
}

Widget getPageLoader1(Size size) {
  return Image.asset('assets/images/loader1.gif',
      width: size.width, fit: BoxFit.fill, height: size.height);
}

Widget getPlaceHolder(BuildContext context, String url) {
  final size = MediaQuery.of(context).size;
  return Image.asset('assets/images/loading.gif',
      height: size.height / 12.8, width: size.width / 6.4, fit: BoxFit.fill);
}

Widget getPlaceHolderNoImage(BuildContext context, String url) {
  final size = MediaQuery.of(context).size;
  return Image.asset('assets/images/noImage.png',
      height: size.height / 12.8, width: size.width / 6.4, fit: BoxFit.fill);
}

Widget getErrorWidgetNoImage(BuildContext context, String url, dynamic error) {
  final size = MediaQuery.of(context).size;
  return Image.asset('assets/images/noImage.png',
      height: size.height / 12.8, width: size.width / 6.4, fit: BoxFit.fill);
}

Widget getErrorWidget(BuildContext context, String url, dynamic error) {
  final size = MediaQuery.of(context).size;
  return Image.asset('assets/images/noImage.png',
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

class Helper extends ChangeNotifier {
  late BuildContext buildContext;
  DateTime? currentBackPressTime;
  String imgBaseUrl = '';
  Connectivity con = Connectivity();
  S get loc => S.of(buildContext);
  ThemeData get theme => Theme.of(buildContext);
  OverlayState? get ol => Overlay.of(buildContext);
  NavigatorState get nav => Navigator.of(buildContext);
  MediaQueryData get dimensions => MediaQuery.of(buildContext);
  ModalRoute<Object?>? get route => ModalRoute.of(buildContext);
  Size get size => dimensions.size;
  double get pixelRatio => dimensions.devicePixelRatio;
  double get textScaleFactor => dimensions.textScaleFactor;
  double get height => size.height;
  double get width => size.width;
  double get aspectRatio => size.aspectRatio;
  double get radius => sqrt(pow(height, 2) + pow(width, 2));
  ScaffoldState get sct => Scaffold.of(buildContext);
  ScaffoldMessengerState get smcT => ScaffoldMessenger.of(buildContext);
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

  void showStatusBar() async {
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top]);
    st!.setState(() {});
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

  void goTo(String route) async {
    Navigator.pushNamed(buildContext, route);
  }

  void goBack({dynamic result}) {
    Navigator.pop(buildContext, result);
  }

  void addLoader(Duration time, {LoaderType? type}) {
    if (ol != null && ol!.mounted) {
      ol!.insert(overlayLoader(time, type: type));
    }
  }

  Future<bool> showPleaseWait() {
    return revealToast('Please Wait....', length: Toast.LENGTH_LONG);
  }

  Future<bool?> showDialogBox(
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
      {String? action,
      String? title,
      AlertType? type,
      bool? dismissive,
      EdgeInsets? titlePadding,
      EdgeInsets? actionPadding,
      EdgeInsets? buttonPadding,
      TextStyle? titleStyle,
      TextStyle? actionStyle,
      TextStyle? optionStyle,
      ScrollController? scrollController,
      ScrollController? actionScrollController,
      Duration? insetDuration,
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

  Future<bool> showSimplePopup(String option, VoidCallback onActionDone,
      {String? action,
      String? title,
      AlertType? type,
      bool? dismissive,
      EdgeInsets? titlePadding,
      EdgeInsets? actionPadding,
      EdgeInsets? buttonPadding,
      TextStyle? titleStyle,
      TextStyle? actionStyle,
      TextStyle? optionStyle,
      ScrollController? scrollController,
      ScrollController? actionScrollController,
      Duration? insetDuration,
      Curve? insetAnimation}) {
    return revealDialogBox([option], [onActionDone],
        type: type,
        dismissive: dismissive,
        titleStyle: titleStyle,
        actionStyle: actionStyle,
        titlePadding: titlePadding,
        buttonPadding: buttonPadding,
        actionPadding: actionPadding,
        action: action,
        title: title,
        scrollController: scrollController,
        actionScrollController: actionScrollController,
        insetAnimation: insetAnimation,
        insetDuration: insetDuration,
        optionStyle: optionStyle);
  }

  Future<T?> appearDialogBox<T>(
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
        ? showCupertinoDialog<T>(
            context: buildContext,
            builder: dialogBuilder,
            barrierLabel: barrierLabel,
            routeSettings: routeSettings,
            barrierDismissible: dismissive ?? false)
        : showDialog<T>(
            context: buildContext,
            builder: dialogBuilder,
            barrierLabel: barrierLabel,
            routeSettings: routeSettings,
            barrierDismissible: dismissive ?? false);
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
        ? await appearDialogBox<T>(
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

  List<String> getFirstAndLastName(String name) {
    List<String> ls = [];
    if (name != '') {
      ls.add(name.trim().split(' ')[0]);
      ls.add(name.trim().split(' ')[name.trim().split(' ').length - 1]);
    }
    return ls;
  }

  void navigateTo(String route,
      {dynamic arguments, FutureOr<dynamic> Function(dynamic)? onGoBack}) {
    Navigator.pushNamed(buildContext, route, arguments: arguments)
        .then(onGoBack ?? doNothing);
  }

  String? validatePhoneNumber(String phone) {
    return (phone.length == 10 && int.tryParse(phone) != null
        ? null
        : loc.not_a_valid_phone);
  }

  String? validatePassword(String password) {
    RegExp re =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$&*~]).{8,}$');
    return password.isNotEmpty &&
            password.length >= 6 &&
            password.length <= 12 &&
            re.hasMatch(password)
        ? null
        : loc.wrong_email_or_password;
  }

  String? validateEmail(String email) {
    RegExp re = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
    return re.hasMatch(email) && re.allMatches(email).length == 1
        ? null
        : loc.not_a_valid_email;
  }

  String? validateName(String value) =>
      value.isEmpty ? loc.not_a_valid_full_name : null;

  void getConnectStatus({VoidCallback? vcb}) async {
    final connectivityResult = await con.checkConnectivity();
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
    }
    // I am connected to a mobile network.
    else if (vcb != null) {
      await SystemChannels.platform.invokeMethod(vcb.toString());
    }
  }

  String putDateTimeToString(DateTime element, String sep) {
    int ds = (element.millisecond * 1000) + element.microsecond;
    String str = element.year.toString();
    str +=
        ('$sep${element.month}$sep${element.day}|${element.hour}:${element.minute}:${element.second}.$ds');
    return str;
  }

  FutureOr<dynamic> doNothing(dynamic value) {
    // if (element != null) {
    log(value);
    // } else {(element.month == null ? "" : )(element.day == null ? "" : )(element.hour == null ? "" : )(element.minute == null ? "" : )(element.second == null ? "" : )
    // log("Year : ");
    // log("Month : ");
    // log("Country Name : ");
    // log((element.year == null ? "" : )
    //     "Admin Area : ");
    // log("Sub Admin Area : ");
    //   return "";
    // }
  }

  void navigateWithoutGoBack(String route, {dynamic arguments}) {
    Navigator.pushNamedAndRemoveUntil(buildContext, route, predicate,
            arguments: arguments)
        .then(doNothing);
  }

  void popAndPush(String route, {dynamic result, dynamic arguments}) {
    Navigator.pushReplacementNamed(buildContext, route,
            result: result, arguments: arguments)
        .then(doNothing);
  }
}
