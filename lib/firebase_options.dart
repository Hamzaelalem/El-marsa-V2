// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDBfGHHGVASPEm1ipzz-F3luiWQMeIJI38',
    appId: '1:479537609270:web:98882bdc6dafef9c93b697',
    messagingSenderId: '479537609270',
    projectId: 'el-marsa-df7c0',
    authDomain: 'el-marsa-df7c0.firebaseapp.com',
    storageBucket: 'el-marsa-df7c0.appspot.com',
    measurementId: 'G-9529ZQLS75',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBfXTYOFvDhg3dF09QANMz6yOSnPkweFzQ',
    appId: '1:479537609270:android:15f4fc6f0ad49aa293b697',
    messagingSenderId: '479537609270',
    projectId: 'el-marsa-df7c0',
    storageBucket: 'el-marsa-df7c0.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDjoC0OiyX5F73aABHhphn52xoGf3H8XEE',
    appId: '1:479537609270:ios:17a7e12eff3dce2493b697',
    messagingSenderId: '479537609270',
    projectId: 'el-marsa-df7c0',
    storageBucket: 'el-marsa-df7c0.appspot.com',
    androidClientId: '479537609270-5jhtbjsl4mok4ttl4mol1ipl1ms14int.apps.googleusercontent.com',
    iosClientId: '479537609270-fmraer7i2grtso63msf3lggnti1ib414.apps.googleusercontent.com',
    iosBundleId: 'com.example.elMarsa',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDjoC0OiyX5F73aABHhphn52xoGf3H8XEE',
    appId: '1:479537609270:ios:5c2b731c3f9f47c693b697',
    messagingSenderId: '479537609270',
    projectId: 'el-marsa-df7c0',
    storageBucket: 'el-marsa-df7c0.appspot.com',
    androidClientId: '479537609270-5jhtbjsl4mok4ttl4mol1ipl1ms14int.apps.googleusercontent.com',
    iosClientId: '479537609270-sti55u54jjbgqj27l0la8gqps5dl467s.apps.googleusercontent.com',
    iosBundleId: 'com.example.elMarsa.RunnerTests',
  );
}