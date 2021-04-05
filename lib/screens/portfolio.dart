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
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  User loggedInUser;
  var money;
  Map crypto = {};
  var price = "000.00";
  String symbol;
  String name = 'coin name';
  String searchValue;
  String doc;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    getFromDB();
    grabData("bitcoin");
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

  void getFromDB() async {
    try {
      DocumentSnapshot variable =
          await FirebaseFirestore.instance.collection('users').doc(doc).get();
      money = variable['money'];
      crypto = variable['cryptocurrencies'];
    } catch (e) {
      print(e);
    }
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
    final cryptos = Container(
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
          border: Border.all(width: 10, color: Colors.black38),
          borderRadius: const BorderRadius.all(const Radius.circular(8))),
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
          ],
        )),
      ),
    );
    final appBarHead = AppBar(
      title: const Text('Portfolio'),
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
                child: Text(money.toString()),
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                )),
            ListTile(
              title: Text('Search'),
              onTap: () {
                Navigator.pushNamed(context, ConsumeAPI.id);
              },
            )
          ],
        ),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 45.0),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('You have $money dollars')),
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
