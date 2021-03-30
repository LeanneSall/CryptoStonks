import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  Future<http.Response> fetchAlbum() {
    return http.get(Uri.https('jsonplaceholder.typicode.com', 'albums/1'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
