import 'package:cloud_firestore/cloud_firestore.dart';

class Buy {
  Buy(this.price, this.money, this.name, this.buyAmount, this.userId);

  num price;
  num buyAmount;
  num ohno;
  num purchaseAmount;
  num purchase() => (purchaseAmount = buyAmount * price);
  final money;
  final name;
  final userId;

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  void updateCrypto() {
    users
        .doc(userId)
        .update({
          'cryptocurrencies': {name: buyAmount}
        })
        .then((value) => print("user updated"))
        .catchError((error) => print("failed to make transaction"));
  }

  void addCrypto() {
    users
        .doc(userId)
        .set({
          'cryptocurrencies': {name: buyAmount}
        })
        .then((value) => print("user updated"))
        .catchError((error) => print("failed to make transaction"));
  }

  void updateMoney() {
    purchase();
    users
        .doc(userId)
        .update({'money': money - purchaseAmount})
        .then((value) => print("user updated"))
        .catchError((error) => print("failed to make transaction"));
  }
}
