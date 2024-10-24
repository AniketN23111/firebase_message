import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart';

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
      default:
        throw UnsupportedError('Current platform is not supported.');
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDJDzSFGjUUj1itoadFgKtmxqvb7nh1xCs',
    appId: '1:196410448057:android:00360972aac3dcbc932368',
    messagingSenderId: '196410448057',
    projectId: 'final2-cb8b0',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD-ExampleKeyFromFirebaseForiOS',
    appId: '1:196410448057:ios:exampleiosappid',
    messagingSenderId: '196410448057',
    projectId: 'final2-cb8b0',
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyD-ExampleKeyFromFirebaseForWeb',
    appId: '1:196410448057:web:examplewebappid',
    messagingSenderId: '196410448057',
    projectId: 'final2-cb8b0',
  );
}
