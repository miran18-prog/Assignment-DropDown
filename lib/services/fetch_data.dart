import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:working_with_api/models/posts.dart';
import 'package:http/http.dart' as http;

class KurdishNameServices {
  Future<KurdishNames> fetchListNames(String g, String l, String p) async {
    Uri uriLink = Uri(
      scheme: 'https',
      host: 'nawiKurdi.com',
      path: 'api',
      queryParameters: {"limit": l, "gender": g, "offset": "0", "sort": p},
    );
    http.Response response =
        await http.get(uriLink).catchError((err) => print(err.toString()));

    KurdishNames _kurdishName = KurdishNames.fromJson(response.body);
    return _kurdishName;
  }
}
