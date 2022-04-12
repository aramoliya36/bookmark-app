import 'dart:convert';

import 'package:bookmrk/constant/constant.dart';
import 'package:http/http.dart' as http;

class SearchAPI {
  /// api to search products...
  static Future searchProductHomePage(String productName, String userId) async {
    // String url = "$kBaseURL/product/find_suggestion";
    String url =
        "$kBaseURL/product/find/1595922619X5f1fd8bb5f332/MOB/$userId/$productName";

    Map<String, String> header = {
      "Content-Type": "application/x-www-form-urlencoded",
      "Auth-Key": "simplerestapi",
      "client-Service": "frontend-client"
    };
    Map<String, dynamic> body = {
      "client_key": "1595922619X5f1fd8bb5f332",
      "device_type": "MOB",
      "user_id": "$userId",
      "product_find": "$productName"
    };
    print("URL SEARCH --> $url");
    print("REQUEST IS SEARCH --> $body");

    http.Response response = await http.get(url, headers: header);
    // http.Response response = await http.post(url, headers: header, body: body);

    print("RESPONSE IS SEARCH --> ${response.body}");

    return jsonDecode(response.body);
  }

  static Future searchSuggestion(String productName, String userId) async {
    String url = "$kBaseURL/product/find_suggestion";
    // String url =
    //     "$kBaseURL/product/find/1595922619X5f1fd8bb5f332/MOB/$userId/$productName";

    Map<String, String> header = {
      "Content-Type": "application/x-www-form-urlencoded",
      "Auth-Key": "simplerestapi",
      "client-Service": "frontend-client"
    };
    Map<String, dynamic> body = {
      "client_key": "1595922619X5f1fd8bb5f332",
      "device_type": "MOB",
      "user_id": "$userId",
      "product_find": "$productName"
    };
    print("URL SEARCH --> $url");
    print("REQUEST IS SEARCH --> $body");

    http.Response response = await http.post(url, headers: header, body: body);
    // http.Response response = await http.post(url, headers: header, body: body);

    print("RESPONSE IS SEARCH --> ${response.body}");

    return jsonDecode(response.body);
  }
}
