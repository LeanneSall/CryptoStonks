import 'package:cryptostonks/components/network.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cryptostonks/screens/welcome_screen.dart';
import 'dart:developer';
import 'package:cryptostonks/apiKey.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ConsumeAPI extends StatefulWidget {
  static String id = 'consume_api';
  @override
  _ConsumeAPIState createState() => _ConsumeAPIState();
}

class _ConsumeAPIState extends State<ConsumeAPI> {
  final _auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  User loggedInUser;
  var money;
  Map crypto = {};
  var price = "000.00";
  String symbol;
  String name = 'Please Search';
  String searchValue;
  String doc;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    grabData("");
  }

  void grabData(searchValue) async {
    try {
      var uri = Uri.https('api.alternative.me', 'v1/ticker/$searchValue/');
      Network network = Network(uri);
      //  var name = currentPrice[0]['name'];
      var cryptoData = await network.getData();
      updateUI(cryptoData);
    } catch (e) {
      var data = null;
      updateUI(data);
    }
    // print(currentPrice);
  }

  void updateUI(dynamic cryptoData) {
    setState(() {
      if (cryptoData == null) {
        name:
        "";
        price:
        'error';
      } else {
        name = cryptoData[0]["name"];
        price = cryptoData[0]["price_usd"];
      }
    });
  }

  void getCurrentUser() async {
    try {
      final User user = await _auth.currentUser;
      doc = user.uid;

      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {}
  }

  Widget build(BuildContext context) {
    final searchField = TextField(
      onChanged: (value) {
        searchValue = value;
      },
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "search",
          suffixIcon: IconButton(
              onPressed: () {
                grabData(searchValue);
              },
              icon: Icon(Icons.search)),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final appBarHead = AppBar(
      title: const Text('CryptoStonks'),
      // automaticallyImplyLeading: false,

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
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
                child: Text('50,000'),
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                )),
            ListTile(
              title: Text('Portfolio'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 45.0),
            searchField,
            Container(
              margin: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                  border: Border.all(width: 10, color: Colors.black38),
                  borderRadius:
                      const BorderRadius.all(const Radius.circular(8))),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Card(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Name: ' + name),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Price: ' + price),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('You have 0 ' + name),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('You have \$50,000 dollars')),
                  ],
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
