import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:glass_login/auth/screens/homepage.dart';
import 'package:glass_login/auth/screens/root.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({Key? key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        //user is logged in
        if (!snapshot.hasData) {
          // Ganti dengan widget kustom Anda
          return AuthenticationScreen();
        }
        {
        return  HomePage();
        }
        
      },
    );
  }
}