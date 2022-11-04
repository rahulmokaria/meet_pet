import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'screens/landing_screen.dart';
import 'utils/colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyBcFZfQSVJe6YhRT4EjSgdK5U-wqpqipLE",
          authDomain: "instagram-clone-ac874.firebaseapp.com",
          projectId: "instagram-clone-ac874",
          storageBucket: "instagram-clone-ac874.appspot.com",
          messagingSenderId: "261847143044",
          appId: "1:261847143044:web:cd1f43826d7bea622a28d1",
          measurementId: "G-V3D23C2FK7"),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'Meet Pet',
      theme: ThemeData(
        primarySwatch: MaterialColor(0xff2e71e5, color),
      ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      home: const LandingPage(),
    );
  }
}
