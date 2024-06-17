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
    apiKey: 'AIzaSyDS6FeLsM5uzlZCI1x3veaL2G4P7E3dd5c',
    appId: '1:123585257056:web:6734d94cdc8ca45d98ed05',
    messagingSenderId: '123585257056',
    projectId: 'agri-66670',
    authDomain: 'agri-66670.firebaseapp.com',
    storageBucket: 'agri-66670.appspot.com',
    measurementId: 'G-879KVJM2JC',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAMCadQ27KS9E30XYW0x9auEksQ26eXXyc',
    appId: '1:123585257056:android:50f868a6e93f4ef898ed05',
    messagingSenderId: '123585257056',
    projectId: 'agri-66670',
    storageBucket: 'agri-66670.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCFfzsanKtSN4Q9mzrqZ-0NFR-fgxAh55k',
    appId: '1:123585257056:ios:0d5702cd9dbcaf9998ed05',
    messagingSenderId: '123585257056',
    projectId: 'agri-66670',
    storageBucket: 'agri-66670.appspot.com',
    iosBundleId: 'com.example.agrigreens',
  );
}
