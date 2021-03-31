import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';

class ConsumeAPI extends StatefulWidget {
  static String id = 'consume_api';
  @override
  _ConsumeAPIState createState() => _ConsumeAPIState();
}

class _ConsumeAPIState extends State<ConsumeAPI> {
  final _auth = FirebaseAuth.instance;
  User loggedInUser;
  double currentPrice;
  String symbol;
  String name;

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

  void getData() async {
    http.Response response = await http.get(Uri.https(
        "https://api.coingecko.com",
        "/api/v3/coins/dopecoin?tickers=true&market_data=true&community_data=true&developer_data=true&sparkline=true"));

    if (response.statusCode == 200) {
      String data = response.body;

      var decodedData = jsonDecode(data);

      currentPrice = decodedData['market_data']['current_price']['cad'];
      symbol = decodedData['symbol'];
      name = decodedData['name'];
    }
  }

  final appHeadBar = AppBar(
    title: const Text('CryptoStonks'),
    automaticallyImplyLeading: false,
    elevation: 5.0,
    leading: Icon(
      Icons.menu,
    ),
    actions: <Widget>[
      Padding(
        padding: EdgeInsets.only(right: 20.0),
        child: Icon(
          Icons.search,
          size: 26.0,
        ),
      ),
      Padding(
        padding: EdgeInsets.only(right: 20.0),
        child: Icon(Icons.favorite),
      ),
    ],
  );

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appHeadBar,
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(top: 20.0, right: 20.0),
                child: SizedBox(
                  child: Text(currentPrice.toString()),
                ))
          ],
        ),
      ),
    );
  }
}
