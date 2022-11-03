import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'screens/landing_screen.dart';
import 'utils/colors.dart';

void main() {
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
