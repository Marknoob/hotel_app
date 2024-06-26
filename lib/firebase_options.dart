// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyBmZUNPEdOTs_RTMH-TmoHguj_3IRFu8g0',
    appId: '1:40448023442:web:a2acb14aa6b1aa14dfbf4b',
    messagingSenderId: '40448023442',
    projectId: 'dbproyekambw',
    authDomain: 'dbproyekambw.firebaseapp.com',
    storageBucket: 'dbproyekambw.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCseVdL3tZb2H02ykJZO-a2XsmGibbKsA8',
    appId: '1:40448023442:android:baab01b1ac502e80dfbf4b',
    messagingSenderId: '40448023442',
    projectId: 'dbproyekambw',
    storageBucket: 'dbproyekambw.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBvAf7_OTr9HzK49qaB7vGTVGg4i18eb6s',
    appId: '1:40448023442:ios:f669f27d847f51d3dfbf4b',
    messagingSenderId: '40448023442',
    projectId: 'dbproyekambw',
    storageBucket: 'dbproyekambw.appspot.com',
    iosBundleId: 'com.example.hotelApp',
  );
}
