import 'dart:developer';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseConfig {
  static FirebaseOptions? get platformOptions {
    if (Platform.isAndroid) {
      // Web
      return const FirebaseOptions(
          apiKey: 'AIzaSyBIwe7RRu4Cge5i_oYea5UO6MF5c68rkdo',
          appId: '1:894280733558:android:3da3ed325ed86c00',
          messagingSenderId: '894280733558',
          projectId: 'certon-ccf37'
          // apiKey: 'AIzaSyAgUhHU8wSJgO5MVNy95tMT07NEjzMOfz0',
          // authDomain: 'react-native-firebase-testing.firebaseapp.com',
          // databaseURL: 'https://react-native-firebase-testing.firebaseio.com',
          // projectId: 'react-native-firebase-testing',
          // storageBucket: 'react-native-firebase-testing.appspot.com',
          // messagingSenderId: '448618578101',
          // appId: '1:448618578101:web:0b650370bb29e29cac3efc',
          // measurementId: 'G-F79DJ0VFGS',
          );
    } else if (Platform.isIOS) {
      // iOS and MacOS
      return const FirebaseOptions(
          apiKey: 'AIzaSyD9Bec9V0wPZeETmwhTzdSV49r2yVDNkFk',
          appId: '1:894280733558:ios:234eea6dd885eb35',
          messagingSenderId: '894280733558',
          projectId: 'certon-ccf37'
          // appId: '1:448618578101:ios:cc6c1dc7a65cc83c',
          // apiKey: 'AIzaSyAHAsf51D0A407EklG1bs-5wA7EbyfNFg0',
          // projectId: 'react-native-firebase-testing',
          // messagingSenderId: '448618578101',
          // iosBundleId: 'com.invertase.testing',
          // iosClientId:
          //     '448618578101-28tsenal97nceuij1msj7iuqinv48t02.apps.googleusercontent.com',
          // androidClientId:
          //     '448618578101-a9p7bj5jlakabp22fo3cbkj7nsmag24e.apps.googleusercontent.com',
          // databaseURL: 'https://react-native-firebase-testing.firebaseio.com',
          // storageBucket: 'react-native-firebase-testing.appspot.com',
          );
    } else {
      log("Analytics Dart-only initializer doesn't work on Android, please make sure to add the config file.");
      return null;
    }
  }
}
