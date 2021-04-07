import 'package:cryptostonks/screens/consume_api.dart';
import 'package:flutter/material.dart';
import 'package:cryptostonks/components/network.dart';
import 'package:cryptostonks/screens/portfolio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cryptostonks/screens/welcome_screen.dart';
import 'dart:developer';
import 'package:cryptostonks/apiKey.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Portfolio extends StatefulWidget {
  static String id = 'portfolio';
  @override
  _PortfolioState createState() => _PortfolioState();
}

class _PortfolioState extends State<Portfolio> {
  final _auth = FirebaseAuth.instance;
  FirebaseFirestore firestore;
  User loggedInUser;
  dynamic variable;
  User user;

  @override
  void initState() {
    super.initState();
    loading(true);
  }

  bool loading(bool) {
    if (loading == true) {
      CircularProgressIndicator();
    }
  }

  void func() {
    loading(true);
    final doc =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    String hello = doc['doc'];
    FirebaseFirestore.instance
        .collection('users')
        .doc(hello)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      documentSnapshot['cryptocurrencies'].forEach((key, value) {});
    });
    loading == false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[],
      ),
    );
  }
}
