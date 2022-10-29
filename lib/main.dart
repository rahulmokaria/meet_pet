import 'package:flutter/material.dart';
import 'package:meet_pet/screens/landing_screen.dart';

import 'screens/home_page.dart';
import 'utils/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: MaterialColor(0xff2e71e5, color),
      ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      home: const LandingPage(),
    );
  }
}
