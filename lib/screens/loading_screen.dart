import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  void getData(searchValue) async {}

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Text("Loading Screen"),
    );
  }
}
