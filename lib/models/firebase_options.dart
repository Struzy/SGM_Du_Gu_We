import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions werden für diese Plattform nicht unterstützt.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDnOKl18AsK_K3tP7Oogul-aYS1fC0xrt8',
    appId: '1:785053102637:android:f89d7a1c61f303b1727ea4',
    messagingSenderId: '785053102637',
    projectId: 'flutterfire-e2e-tests',
    databaseURL:
        'https://sgm-duguwe-default-rtdb.europe-west1.firebasedatabase.app/',
    storageBucket: 'gs://sgm-duguwe.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: '',
    appId: '',
    messagingSenderId: '',
    projectId: '',
    databaseURL:
        '',
    storageBucket: '',
    androidClientId:
        '',
    iosClientId:
        '',
    iosBundleId: '',
  );
}
