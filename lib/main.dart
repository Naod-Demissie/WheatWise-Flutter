import 'package:flutter/material.dart';
import 'package:wheatwise/features/auth/screens/login_screen.dart';
import 'package:wheatwise/features/page_navigator/screens/page_navigator.dart';
import 'package:wheatwise/features/splash/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: const ColorScheme.light(),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
      // home: const SplashScreen(),
      // home: const PageNavigator(),
      debugShowCheckedModeBanner: false,
    );
  }
}
