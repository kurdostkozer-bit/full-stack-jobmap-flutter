import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
        return windows;
      case TargetPlatform.linux:
        return linux;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBbgZWSURL69DbijE2eqhjnn8WSyQjwfw4',
    appId: '1:636597585856:web:628ce1300c1eabd51d2a25',
    messagingSenderId: '636597585856',
    projectId: 'jobmap-90f38',
    authDomain: 'jobmap-90f38.firebaseapp.com',
    storageBucket: 'jobmap-90f38.firebasestorage.app',
    measurementId: 'G-CQZHKLCH89',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCqDfOqWFD6-Ih7B0wOnAZFNvCTwoNIOOc',
    appId: '1:636597585856:android:c622c581fdb3e2b31d2a25',
    messagingSenderId: '636597585856',
    projectId: 'jobmap-90f38',
    storageBucket: 'jobmap-90f38.firebasestorage.app',
  );
  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCLIHXyat-QdnHpZ_oOZ1s072HJ3Yx3SjY',
    appId: '1:636597585856:ios:bbb75130431be16f1d2a25',
    messagingSenderId: '636597585856',
    projectId: 'jobmap-90f38',
    storageBucket: 'jobmap-90f38.firebasestorage.app',
    iosClientId: '636597585856-8mut7gqkncb3tkj2vqgbelu9t5tbscq7.apps.googleusercontent.com',
    iosBundleId: 'com.example.jobmap',
  );
  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCLIHXyat-QdnHpZ_oOZ1s072HJ3Yx3SjY',
    appId: '1:636597585856:ios:bbb75130431be16f1d2a25',
    messagingSenderId: '636597585856',
    projectId: 'jobmap-90f38',
    storageBucket: 'jobmap-90f38.firebasestorage.app',
    iosClientId: '636597585856-8mut7gqkncb3tkj2vqgbelu9t5tbscq7.apps.googleusercontent.com',
    iosBundleId: 'com.example.jobmap',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBbgZWSURL69DbijE2eqhjnn8WSyQjwfw4',
    appId: '1:636597585856:web:835c18ff67fe8ffe1d2a25',
    messagingSenderId: '636597585856',
    projectId: 'jobmap-90f38',
    authDomain: 'jobmap-90f38.firebaseapp.com',
    storageBucket: 'jobmap-90f38.firebasestorage.app',
    measurementId: 'G-60652GJ6P1',
  );
  static const FirebaseOptions linux = FirebaseOptions(
    apiKey: 'AIzaSyD_YOUR_LINUX_API_KEY',
    appId: '1:YOUR_PROJECT_NUMBER:linux:YOUR_LINUX_APP_ID',
    messagingSenderId: 'YOUR_PROJECT_NUMBER',
    projectId: 'your-project-id',
    storageBucket: 'your-project-id.appspot.com',
  );
}
