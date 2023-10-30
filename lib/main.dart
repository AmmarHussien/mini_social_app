import 'package:flutter/material.dart';
import 'package:mini_social_app/pages/login_page.dart';
import 'package:mini_social_app/theme/dark_mode.dart';
import 'package:mini_social_app/theme/light_mode.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
      theme: lightMode,
      darkTheme: darktMode,
    );
  }
}