// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options_prod.dart';
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: "AIzaSyCpt29AHORPDG2rn14g4ZQTN6DaAOA0gtA",
    appId: "1:237890393456:android:bcfaf23f46672ea2ad6bb5",
    messagingSenderId: "237890393456",
    projectId: "hospital-management-bf6ef",
    authDomain: "hospital-management-bf6ef.firebaseapp.com",
    storageBucket: "hospital-management-bf6ef.appspot.com",
    measurementId: "G-7YYE2KEHDQ",
    androidClientId: "237890393456-0vd7m47vbjhpa0a039dt0gfc07saqt8o.apps.googleusercontent.com",
    iosClientId: "237890393456-apldcnje5ebnvthb3pnajcubdjfk2mv1.apps.googleusercontent.com",
    iosBundleId: "com.friendlyitsolution.doctor",
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: "AIzaSyBV78gOfHP15EaUAoWWp8LTVjG5xLIfR5I",
    appId: "1:237890393456:ios:a16e21bf3c25ff34ad6bb5",
    messagingSenderId: "237890393456",
    projectId: "hospital-management-bf6ef",
    authDomain: "hospital-management-bf6ef.firebaseapp.com",
    storageBucket: "hospital-management-bf6ef.appspot.com",
    measurementId: "G-7YYE2KEHDQ",
    androidClientId: "237890393456-0vd7m47vbjhpa0a039dt0gfc07saqt8o.apps.googleusercontent.com",
    iosClientId: "237890393456-apldcnje5ebnvthb3pnajcubdjfk2mv1.apps.googleusercontent.com",
    iosBundleId: "com.friendlyitsolution.doctor",
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: "AIzaSyB5PBnPTAdv5HRQire3CoGGhrEIdepvqrE",
    appId: "1:237890393456:web:eb8634ce90020f4dad6bb5",
    messagingSenderId: "237890393456",
    projectId: "hospital-management-bf6ef",
    authDomain: "hospital-management-bf6ef.firebaseapp.com",
    storageBucket: "hospital-management-bf6ef.appspot.com",
    measurementId: "G-7YYE2KEHDQ",
    androidClientId: "237890393456-0vd7m47vbjhpa0a039dt0gfc07saqt8o.apps.googleusercontent.com",
    iosClientId: "237890393456-apldcnje5ebnvthb3pnajcubdjfk2mv1.apps.googleusercontent.com",
    iosBundleId: "com.friendlyitsolution.doctor",
  );
}