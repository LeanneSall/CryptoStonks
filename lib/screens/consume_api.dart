import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cryptostonks/screens/welcome_screen.dart';
import 'dart:developer';
import 'package:cryptostonks/apiKey.dart';

class ConsumeAPI extends StatefulWidget {
  static String id = 'consume_api';
  @override
  _ConsumeAPIState createState() => _ConsumeAPIState();
}

class _ConsumeAPIState extends State<ConsumeAPI> {
  final _auth = FirebaseAuth.instance;
  User loggedInUser;
  var currentPrice = "";
  String symbol = 'BTC';
  String name;
  String searchValue;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final User user = await _auth.currentUser;

      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {}
  }

  Widget build(BuildContext context) {
    Future<String> getData(searchValue) async {
      var uri = Uri.https('api.alternative.me', 'v2/ticker/$searchValue/');
      http.Response response = await http.get(uri);

      String data = response.body;
      currentPrice = jsonDecode(data);

      return currentPrice;
      // print(currentPrice);
    }

    final searchField = TextField(
      onChanged: (value) {
        searchValue = value;
      },
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "search",
          suffixIcon: IconButton(
              onPressed: () {
                getData(searchValue);
              },
              icon: Icon(Icons.search)),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final appBarHead = AppBar(
      title: const Text('CryptoStonks'),
      automaticallyImplyLeading: false,
      elevation: 5.0,
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 20.0),
          child: Icon(Icons.favorite),
        ),
        FlatButton.icon(
          onPressed: () async {
            try {
              await _auth.signOut();
              Navigator.pushNamed(context, WelcomeScreen.id);
            } catch (e) {
              print(e);
            }
          },
          icon: Icon(Icons.person),
          label: Text('logout'),
        ),
      ],
    );

    return Scaffold(
      appBar: appBarHead,
      body: Container(
        child: Column(
          children: <Widget>[
            SizedBox(height: 45.0),
            searchField,
            ListTile(title: Text(currentPrice))
          ],
        ),
      ),
    );
  }
}
