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
    apiKey: 'AIzaSyBQbudN54Xma7E0nNcWSATRK6hZnCnXklQ',
    appId: '1:13432400380:web:de7e98196e5ea54b312a79',
    messagingSenderId: '13432400380',
    projectId: 'pbl5-f7469',
    authDomain: 'pbl5-f7469.firebaseapp.com',
    databaseURL: 'https://pbl5-f7469-default-rtdb.firebaseio.com',
    storageBucket: 'pbl5-f7469.appspot.com',
    measurementId: 'G-1DL82SMGPE',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAkFRi37qMVWrutEu3k6anMKNpglgwDja8',
    appId: '1:13432400380:android:a9c1f6be05891545312a79',
    messagingSenderId: '13432400380',
    projectId: 'pbl5-f7469',
    databaseURL: 'https://pbl5-f7469-default-rtdb.firebaseio.com',
    storageBucket: 'pbl5-f7469.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDyFJQGU-ekGfi7lyfeF9QBfr_Zb3U7sPU',
    appId: '1:13432400380:ios:a35d75a48d563bda312a79',
    messagingSenderId: '13432400380',
    projectId: 'pbl5-f7469',
    databaseURL: 'https://pbl5-f7469-default-rtdb.firebaseio.com',
    storageBucket: 'pbl5-f7469.appspot.com',
    iosClientId: '13432400380-voj6g0vo0r3od3qjhjntu8s1vm3baa7c.apps.googleusercontent.com',
    iosBundleId: 'com.example.app',
  );
}
