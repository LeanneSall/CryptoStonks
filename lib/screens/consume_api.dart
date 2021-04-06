import 'package:cryptostonks/components/network.dart';
import 'package:cryptostonks/components/sell.dart';
import 'package:cryptostonks/screens/portfolio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cryptostonks/screens/welcome_screen.dart';
import 'dart:developer';
import 'package:cryptostonks/apiKey.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cryptostonks/components/buy.dart';

class ConsumeAPI extends StatefulWidget {
  static String id = 'consume_api';
  @override
  _ConsumeAPIState createState() => _ConsumeAPIState();
}

class _ConsumeAPIState extends State<ConsumeAPI> {
  final _auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  User loggedInUser;
  num money = 50000;
  var crypto;
  num price = 0.00;
  String symbol;
  String name = 'coin name';
  String doc;
  String searchValue = "bitcoin";
  num currentCrypto = 0.00;
  double purchasePrice;
  num amount;
  DocumentSnapshot variable;

  //var searchCoin = 0.00;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    grabData("bitcoin");
  }

  void grabData(searchValue) async {
    try {
      var uri = Uri.https('api.alternative.me', 'v1/ticker/$searchValue/');
      Network network = Network(uri);
      //  var name = currentPrice[0]['name'];
      var cryptoData = await network.getData();
      updateUI(cryptoData);
      haveCoin();
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
        0.00;
      } else {
        name = cryptoData[0]["name"];
        price = num.parse(cryptoData[0]["price_usd"]);
        print(price);
        try {} catch (e) {
          print(e);
        }
      }
    });
  }

  void haveCoin() async {
    try {
      currentCrypto = variable['cryptocurrencies'][searchValue];
      money = variable['money'];
      if (currentCrypto == null) {
        currentCrypto = 0.00;
      }
    } catch (e) {
      //searchCoin = 0;
    }
  }

  void getCurrentUser() async {
    try {
      final User user = await _auth.currentUser;
      doc = user.uid;

      if (user != null) {
        loggedInUser = user;
        variable =
            await FirebaseFirestore.instance.collection('users').doc(doc).get();
      }
    } catch (e) {}
  }

  void pp() {
    // purchasePrice = double.parse(price);
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
      title: const Text('Search'),
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
              title: Text('Portfolio'),
              onTap: () {
                Navigator.pushNamed(context, Portfolio.id);
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
            Padding(
                padding: EdgeInsetsDirectional.only(bottom: 40),
                child: searchField),
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Name: ' + name),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Price: $price'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          "You have " + currentCrypto.toString() + " " + name),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('You have $money dollars')),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          ElevatedButton.icon(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      content: Stack(
                                          overflow: Overflow.visible,
                                          children: <Widget>[
                                            Form(
                                                child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Title(
                                                  child: Text('Buy $name'),
                                                  color: Colors.grey[300],
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: TextFormField(
                                                    onChanged: (value) => {
                                                      amount = num.parse(value)
                                                    },
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: <Widget>[
                                                    ElevatedButton(
                                                        onPressed: () {
                                                          try {
                                                            pp();
                                                            Buy(
                                                                    price,
                                                                    money,
                                                                    name.toLowerCase(),
                                                                    amount,
                                                                    doc,
                                                                    currentCrypto)
                                                                .updateCrypto();

                                                            Buy(
                                                                    price,
                                                                    money,
                                                                    name.toLowerCase(),
                                                                    amount,
                                                                    doc,
                                                                    currentCrypto)
                                                                .updateMoney();

                                                            grabData(
                                                                searchValue);
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                            Navigator.of(
                                                                    context)
                                                                .pushNamed(
                                                                    ConsumeAPI
                                                                        .id);
                                                          } catch (e) {
                                                            print(e);
                                                          }
                                                        },
                                                        child: Text('Buy')),
                                                    ElevatedButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: Text('Cancel'))
                                                  ],
                                                )
                                              ],
                                            ))
                                          ]),
                                    );
                                  });
                            },
                            label: Text('Buy'),
                            icon: Icon(Icons.add),
                          ),
                          ElevatedButton.icon(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      content: Stack(
                                          overflow: Overflow.visible,
                                          children: <Widget>[
                                            Form(
                                                child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Title(
                                                  child: Text('Sell $name'),
                                                  color: Colors.grey[300],
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: TextFormField(
                                                      onChanged: (value) {
                                                    amount = num.parse(value);
                                                  }),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: <Widget>[
                                                    ElevatedButton(
                                                        onPressed: () {
                                                          pp();
                                                          Sell(
                                                            price,
                                                            money,
                                                            name.toLowerCase(),
                                                            amount,
                                                            doc,
                                                            currentCrypto,
                                                          ).updateCrypto();

                                                          Sell(
                                                                  price,
                                                                  money,
                                                                  name.toLowerCase(),
                                                                  amount,
                                                                  doc,
                                                                  currentCrypto)
                                                              .updateMoney();

                                                          grabData(searchValue);
                                                          Navigator.of(context)
                                                              .pop();
                                                          Navigator.of(context)
                                                              .pushNamed(
                                                                  ConsumeAPI
                                                                      .id);
                                                        },
                                                        child: Text('Sell')),
                                                    ElevatedButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: Text('Cancel'))
                                                  ],
                                                )
                                              ],
                                            ))
                                          ]),
                                    );
                                  });
                            },
                            label: Text('Sell'),
                            icon: Icon(Icons.delete),
                          )
                        ])
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
