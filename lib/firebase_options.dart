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
        return windows;
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
    apiKey: 'AIzaSyC9T8CQDBOUjSVhJlpuODZFWyw3jBtsPv8',
    appId: '1:437763878498:web:157b771604cb49baa5ab3b',
    messagingSenderId: '437763878498',
    projectId: 'totalxtest',
    authDomain: 'totalxtest-64d77.firebaseapp.com',
    storageBucket: 'totalxtest.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBqL0Brv-lbftxhFW1Pd7ZR9zKBBw26M1U',
    appId: '1:437763878498:android:363c429fb24d4caea5ab3b',
    messagingSenderId: '437763878498',
    projectId: 'totalxtest',
    storageBucket: 'totalxtest.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDiyPt2efnciZZOQ2_IAeJv8ZQ9_48Lsak',
    appId: '1:437763878498:ios:ee8228d987615371a5ab3b',
    messagingSenderId: '437763878498',
    projectId: 'totalxtest',
    storageBucket: 'totalxtest.firebasestorage.app',
    iosBundleId: 'com.example.totalxtestapp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyC9T8CQDBOUjSVhJlpuODZFWyw3jBtsPv8',
    appId: '1:437763878498:web:899ef012c31203bea5ab3b',
    messagingSenderId: '437763878498',
    projectId: 'totalxtest',
    authDomain: 'totalxtest-64d77.firebaseapp.com',
    storageBucket: 'totalxtest.firebasestorage.app',
  );
}
