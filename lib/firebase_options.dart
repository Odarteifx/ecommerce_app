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
        return macos;
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
    apiKey: 'AIzaSyD9YPvc963JqVO-ID_tfbsb4Li3qkX7nV4',
    appId: '1:901803702180:web:ddb196a92d100e9cbbf331',
    messagingSenderId: '901803702180',
    projectId: 'awesome-eccommerce-app',
    authDomain: 'awesome-eccommerce-app.firebaseapp.com',
    storageBucket: 'awesome-eccommerce-app.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBSrDXRkDsf5btNVk6rvZCYG317eVtglOo',
    appId: '1:901803702180:android:9a1f1c7eec4d341abbf331',
    messagingSenderId: '901803702180',
    projectId: 'awesome-eccommerce-app',
    storageBucket: 'awesome-eccommerce-app.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDW-f7BAj8BF-MMpKCM7LH4Q9mPAj9-rQ0',
    appId: '1:901803702180:ios:ae7a17cdc8dd610dbbf331',
    messagingSenderId: '901803702180',
    projectId: 'awesome-eccommerce-app',
    storageBucket: 'awesome-eccommerce-app.appspot.com',
    iosBundleId: 'com.example.ecommerceApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDW-f7BAj8BF-MMpKCM7LH4Q9mPAj9-rQ0',
    appId: '1:901803702180:ios:ae7a17cdc8dd610dbbf331',
    messagingSenderId: '901803702180',
    projectId: 'awesome-eccommerce-app',
    storageBucket: 'awesome-eccommerce-app.appspot.com',
    iosBundleId: 'com.example.ecommerceApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyD9YPvc963JqVO-ID_tfbsb4Li3qkX7nV4',
    appId: '1:901803702180:web:7d7c987f779c6e85bbf331',
    messagingSenderId: '901803702180',
    projectId: 'awesome-eccommerce-app',
    authDomain: 'awesome-eccommerce-app.firebaseapp.com',
    storageBucket: 'awesome-eccommerce-app.appspot.com',
  );
}
