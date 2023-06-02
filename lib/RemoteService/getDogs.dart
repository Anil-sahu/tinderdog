
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



class RemoteService {
  static var client = http.Client();

  static Future fetchDogs() async {
    try {
      var res = await client.get(Uri.parse("https://dog.ceo/api/breeds/image/random"));
      if (res.statusCode == 200) {
        var jsonString = res.body;
      print(jsonDecode(jsonString));
      return jsonDecode(jsonString);
      } else {}
    } catch (e) {
      debugPrint(e.toString());
    }
  }

}