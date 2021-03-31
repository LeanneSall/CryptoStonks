import 'package:flutter/material.dart';
import 'package:cryptostonks/screens/welcome_screen.dart';
import 'package:cryptostonks/screens/consume_api.dart';
import 'package:cryptostonks/screens/register.dart';

void main() {
  runApp(CryptoStonks());
}

class CryptoStonks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData.dark().copyWith(
            textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.black54),
        )),
        initialRoute: 'register',
        routes: {
          'welcome_screen': (context) => WelcomeScreen(),
          'consume_api': (context) => ConsumeAPI(),
          'register': (context) => Register(),
        });
  }
}
