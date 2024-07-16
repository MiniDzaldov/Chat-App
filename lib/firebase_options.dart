import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseOptions{
  static FirebaseOptions get currentPlatform{
    return android;
  }
  
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCId9sbjxFRAs9fV3UOb7A_aVwoIV01LvY',
    appId: '1:450231573909:android:ce4b51e626e5afc2982a9c',
    projectId: 'chat-app-504d1',
    messagingSenderId: '450231573909',
    storageBucket: 'chat-app-504d1.appspot.com'
  );
}