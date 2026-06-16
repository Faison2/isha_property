import 'package:flutter/material.dart';
import 'package:isha/screens/splash/splash_screen.dart';

void main() {
  runApp(const StayConnectApp());
}

class StayConnectApp extends StatelessWidget {
  const StayConnectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StayConnect',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFC87941)),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}