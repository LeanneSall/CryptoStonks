import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Sell {
  Sell(this.price, this.money, this.name, this.amount, this.userId,
      this.currentCrypto);
  num price;
  num amount;
  num ohno;
  num sellAmount;
  num sell() => (sellAmount = amount * price);
  num dataCrypto;
  num sellCrypto() => (dataCrypto = currentCrypto - amount);
  final money;
  final name;
  final userId;
  num currentCrypto;

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  void updateCrypto() {
    sell();
    // sellCrypto();
    if (currentCrypto == 0) {
      print('user not updated, no crypto to sell');
    } else if (currentCrypto < amount) {
      print('trying to sell crpyto you dont have');
    } else {
      users
          .doc(userId)
          .set({
            'cryptocurrencies': {name: currentCrypto - amount}
          }, SetOptions(merge: true))
          .then((value) => print("user updated"))
          .catchError((error) => print("failed to make transaction"));
    }
  }

  void updateMoney() {
    sell();
    users
        .doc(userId)
        .update({'money': money + sellAmount})
        .then((value) => print("user updated"))
        .catchError((error) => print("failed to make transaction"));
  }
}
