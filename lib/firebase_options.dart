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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCsqFNLct_bQF0UXbU3707fKDw9Cw_LCes',
    appId: '1:786119628442:android:27d76e75dbbfcaff84b123',
    messagingSenderId: '786119628442',
    projectId: 'app-hidjab',
    storageBucket: 'app-hidjab.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBHS6WPstyP11ueEsrNavuCXSjkt40PjYY',
    appId: '1:786119628442:ios:6d4ea851c4e4414f84b123',
    messagingSenderId: '786119628442',
    projectId: 'app-hidjab',
    storageBucket: 'app-hidjab.appspot.com',
    androidClientId: '786119628442-qjjtk6j92h1j0dfvifo7r32f9jjit6cn.apps.googleusercontent.com',
    iosClientId: '786119628442-dnhflri72pcqfb30dj9ictt66hhm3ijn.apps.googleusercontent.com',
    iosBundleId: 'uz.aphidjab.hidjab',
  );
}
