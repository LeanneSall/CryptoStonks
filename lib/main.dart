import 'dart:io';

import 'package:cryptostonks/screens/portfolio.dart';
import 'package:flutter/material.dart';

import 'package:cryptostonks/screens/welcome_screen.dart';
import 'package:cryptostonks/screens/consume_api.dart';
import 'package:cryptostonks/screens/register.dart';
import 'package:cryptostonks/screens/login.dart';

import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(CryptoStonks());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData.dark().copyWith(
            textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.black54),
        )),
        initialRoute: WelcomeScreen.id,
        routes: {
          WelcomeScreen.id: (context) => WelcomeScreen(),
          ConsumeAPI.id: (context) => ConsumeAPI(),
          Register.id: (context) => Register(),
          Login.id: (context) => Login(),
          Portfolio.id: (context) => Portfolio(),
        });
  }
}

class CryptoStonks extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MyApp();
  }
}

// FutureBuilder(
//       // Initialize FlutterFire:
//       future: _initialization,
//       builder: (context, snapshot) {
//         // Check for errors
//         if (snapshot.hasError) {
//           return exit(1);
//         }

//         // Once complete, show your application
//         if (snapshot.connectionState == ConnectionState.done) {
//           return MyApp();
//         }

//         // Otherwise, show something whilst waiting for initialization to complete
//         //return Loading();
//       },
