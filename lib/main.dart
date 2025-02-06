import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:wewon/auth/auth.dart';
import 'package:wewon/auth/login_or_register.dart';
import 'package:wewon/firebase_options.dart';
import 'package:wewon/pages/login_page.dart';
import 'package:wewon/pages/register_page.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home:  AuthPage(),
    );
  }
}

//flutter run --no-enable-impeller

