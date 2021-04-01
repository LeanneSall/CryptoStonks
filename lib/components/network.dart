import 'package:http/http.dart' as http;
import 'dart:convert';

class Network {
  Network(this.uri);

  final Uri uri;

  Future getData() async {
    http.Response response = await http.get(uri);

    var data = json.decode(response.body);
    //var name = currentPrice['data']['1']['name'];

    return data;
  }
}
