import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wewon/auth/login_or_register.dart';
import 'package:wewon/pages/healer_dealer_page.dart';
import 'package:wewon/pages/launcher_page.dart';


class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData){
            return LauncherPage();
          }
          else{
            return const LoginOrRegister();
          }
        },
      ),
    );
  }
}
