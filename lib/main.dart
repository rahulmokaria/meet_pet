import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meet_pet/screens/home_page.dart';
import 'package:provider/provider.dart';

import 'providers/user_provider.dart';
import 'screens/landing_screen.dart';
import 'utils/colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyABjTX0uobXzP7UP98VygoOrdEFQ04U8jQ",
        authDomain: "meet-pet-c2294.firebaseapp.com",
        projectId: "meet-pet-c2294",
        storageBucket: "meet-pet-c2294.appspot.com",
        messagingSenderId: "566010512135",
        appId: "1:566010512135:web:02ccc35c7d8104e9ba3ba2",
        measurementId: "G-EPZP6CHY6R",
      ),
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Meet Pet',
        theme: ThemeData(
          primarySwatch: MaterialColor(0xff2e71e5, color),
        ),
        // home: const MyHomePage(title: 'Flutter Demo Home Page'),
        // home: const LandingPage(),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              // Checking if the snapshot has any data or not

              if (snapshot.hasData) {
                // if snapshot has data which means user is logged in then we check the width of screen and accordingly display the screen layout
                return const HomePage();
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }
            }
            // means connection to future hasnt been made yet
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return const LandingPage();
          },
        ),
      ),
    );
  }
}
