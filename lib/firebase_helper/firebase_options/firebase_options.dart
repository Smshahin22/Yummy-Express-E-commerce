import 'dart:io';

import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseConfig {
  static FirebaseOptions get platformOptions {
    if (Platform.isIOS) {
      // iOS and MacOS
      return const FirebaseOptions(
        appId: '',
        apiKey: '',
        projectId: '',
        messagingSenderId: '',
        iosBundleId: '',
      );
    } else {
      // Android
      return const FirebaseOptions(
        appId: '1:544796539694:android:03cc37fd0de4d5a27058bf',
        apiKey: 'AIzaSyASF5mv9jYsJ9QjHRMyJpw4OrhXZUjsmFI',
        projectId: 'yummy-express-74700',
        messagingSenderId: '544796539694',
      );
    }
  }
}