// import 'dart:async';
// import '../helpers/helper.dart';
// import 'package:flutter/material.dart';


// class TimerAndStopwatchScreen extends StatefulWidget {
//   const TimerAndStopwatchScreen({super.key});

//   @override
//   State<TimerAndStopwatchScreen> createState() =>
//       TimerAndStopwatchScreenState();
// }

// class TimerAndStopwatchScreenState extends State<TimerAndStopwatchScreen> {
//   Duration timerDuration = const Duration(minutes: 10),
//       myDuration = const Duration();
//   Timer? timer;
//   bool countDown = true;
//   Helper get hp => Helper.of(context);

//   void reset() {
//     mounted
//         ? setState(
//             () => myDuration = countDown ? timerDuration : const Duration())
//         : doNothing();
//   }

//   void startTimer() {
//     timer = Timer.periodic(const Duration(seconds: 1), addTime);
//   }

//   void addTime(Timer tm) {
//     int addOrDiffSecs = countDown ? -1 : 1;
//     mounted
//         ? setState(() {
//             final sec = myDuration.inSeconds + addOrDiffSecs;
//             if (sec < 0) {
//               timer?.cancel();
//             } else {
//               myDuration = Duration(seconds: sec);
//             }
//           })
//         : doNothing();
//   }

//   void stopTimer({bool isReset = true}) {
//     if (isReset) {
//       reset();
//     }
//     mounted ? setState(timer?.cancel ?? doNothing) : doNothing();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: SizedBox(
//             height: hp.height,
//             width: hp.width,
//             child: Column(
//               children: [
//                 Expanded(child: Row(children: [
//                   Text('${myDuration.}'),
//                     Text(':'),
//                     Text(),
//                     Text(':'),
//                     Text(),
//                     Text('.'),
//                     Text(),
//                 ],))
//               ],
//             )));
//   }
// }
