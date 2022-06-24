import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class DefaultFirebaseConfig {
  static FirebaseOptions get platformOptions {
    if (kIsWeb) {
      // Web
      return const FirebaseOptions(
          //apiKey: "AIzaSyBVYhseA8mmz1mci8L5rjtQ6SioWn1Igzs",
          apiKey: "AIzaSyBVYhseA8mmz1mci8L5rjtQ6SioWn1Igzs",
          //authDomain: "csci567s22-e9e5d.firebaseapp.com",
          authDomain: "testing-e9e5d.firebaseapp.com",
          //projectId: "csci567s22",
          projectId: "testing-e9e5d",
          //storageBucket: "csci567s22.appspot.com",
          storageBucket: "testing-e9e5d.appspot.com",
          //messagingSenderId: "452029871180",
          messagingSenderId: "833930797379",
          //appId: "1:452029871180:web:dd8cb1357858a799f930e9"
          appId: "1:833930797379:android:a68ebf94d26f6c576f8ff6"
          //   );
          // } else if (Platform.isIOS || Platform.isMacOS) {
          //   // iOS and MacOS
          //   return const FirebaseOptions(
          //     appId: '1:448618578101:ios:0b650370bb29e29cac3efc',
          //     apiKey: 'AIzaSyAgUhHU8wSJgO5MVNy95tMT07NEjzMOfz0',
          //     projectId: 'react-native-firebase-testing',
          //     messagingSenderId: '448618578101',
          //     iosBundleId: 'io.flutter.plugins.firebasecoreexample',
          );
    } else {
      // Android
      return const FirebaseOptions(
        appId: "1:833930797379:android:a68ebf94d26f6c576f8ff6",
        apiKey: "AIzaSyBVYhseA8mmz1mci8L5rjtQ6SioWn1Igzs",
        projectId: "testing-e9e5d",
        messagingSenderId: "833930797379",
      );
    }
  }
}
