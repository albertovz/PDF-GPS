import 'package:firebase_core/firebase_core.dart';
import 'package:paw_rescue/firebase_options.dart';

class FirebaseService {
  static Future <FirebaseService> init () async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    return FirebaseService();
  }
}