// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;


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
    apiKey: 'AIzaSyBQVs-jH2oMaCQjNtKY7IXtCo4Dv684EA4',
    appId: '1:155301256351:web:187ce306d80d91033516aa',
    messagingSenderId: '155301256351',
    projectId: 'memoria-5b859',
    authDomain: 'memoria-5b859.firebaseapp.com',
    storageBucket: 'memoria-5b859.appspot.com',
    measurementId: 'G-YFHFSNWQV8',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBdYfWBU_52Nn9_TSbBWBDEOdy_ERJQGls',
    appId: '1:155301256351:android:4f5be25a55b87f9f3516aa',
    messagingSenderId: '155301256351',
    projectId: 'memoria-5b859',
    storageBucket: 'memoria-5b859.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBgB6mQrEpnSVclYVDJ7QqxTX-BJP4tzQ8',
    appId: '1:155301256351:ios:2afaa86898c39f4c3516aa',
    messagingSenderId: '155301256351',
    projectId: 'memoria-5b859',
    storageBucket: 'memoria-5b859.appspot.com',
    iosBundleId: 'com.example.juegoMemoria',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBgB6mQrEpnSVclYVDJ7QqxTX-BJP4tzQ8',
    appId: '1:155301256351:ios:8baaa297b665fdb93516aa',
    messagingSenderId: '155301256351',
    projectId: 'memoria-5b859',
    storageBucket: 'memoria-5b859.appspot.com',
    iosBundleId: 'com.example.juegoMemoria.RunnerTests',
  );
}
