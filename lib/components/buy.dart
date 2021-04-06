import 'package:cloud_firestore/cloud_firestore.dart';

class Buy {
  Buy(this.price, this.money, this.name, this.amount, this.userId,
      this.currentCrypto);

  num price;
  num amount;
  num ohno;
  num purchaseAmount;
  num purchase() => (purchaseAmount = amount * price);
  final money;
  final name;
  final userId;
  final currentCrypto;

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  void updateCrypto() {
    purchase();
    if (currentCrypto == 0) {
      users
          .doc(userId)
          .set({
            'cryptocurrencies': {name: amount}
          }, SetOptions(merge: true))
          .then((value) => print("user updated"))
          .catchError((error) => print("failed to make transaction"));
    } else {
      users
          .doc(userId)
          .set({
            'cryptocurrencies': {name: currentCrypto + amount}
          }, SetOptions(merge: true))
          .then((value) => print("user updated"))
          .catchError((error) => print("failed to make transaction"));
    }
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
