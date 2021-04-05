import 'package:http/http.dart' as http;
import 'dart:convert';

class Sell {
  Sell(this.price, this.money, this.name, this.sellAmount, this.userId);

  final price;
  final sellAmount;
  final money;
  final name;
  final userId;

  Future sellCrypto() async {}
}
