import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mini_social_app/auth/login_or_register.dart';
import 'package:mini_social_app/pages/home_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // user  is to login in

          if (snapshot.hasData) {
            return const HomePage();
          }
          // user  is Not to login in
          else {
            return const LoginOrRegister();
          }
        },
      ),
    );
  }
}
