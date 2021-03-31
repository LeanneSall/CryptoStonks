import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  void getData() async {
    http.Response response = await http.get(Uri.https(
        "https://api.coingecko.com",
        "/api/v3/coins/dopecoin?tickers=true&market_data=true&community_data=true&developer_data=true&sparkline=true"));

    if (response.statusCode == 200) {
      String data = response.body;

      var decodedData = jsonDecode(data);

      double currentPrice = decodedData['market_data']['current_price']['cad'];
      String symbol = decodedData['symbol'];
      String name = decodedData['name'];

      print(currentPrice.toString());
      print(symbol);
    }
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold(body: Container(child: Text('Hello World')));
  }
}
