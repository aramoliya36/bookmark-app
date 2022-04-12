import 'dart:convert';

import 'package:bookmrk/constant/constant.dart';
import 'package:http/http.dart' as http;

class OrderHistoryAPI {
  /// get order details ...
  static Future getOrderHistoryDetails(String userId, String status) async {
    String url =
        "$kBaseURL/purchase/purchase_history/1595922619X5f1fd8bb5f332/MOB/$status/$userId";
    Map<String, String> header = {
      "Authorization": "\$1\$aRkFpEz3\$qGGbgw/.xtfSv8rvK/j5y0",
      "Client-Service": "frontend-client",
      "Auth-Key": "simplerestapi",
      "Content-Type": "application/x-www-form-urlencoded",
    };

    http.Response response = await http.get(url, headers: header);
    return jsonDecode(response.body);
  }

  /// get order details from the order id ....
  static Future getOrderDetailsFromOrderId(
      String orderId, String userId) async {
    String url =
        "$kBaseURL/purchase/purchase_history_by_order_no/1595922619X5f1fd8bb5f332/MOB/$userId/$orderId";
    Map<String, String> header = {
      "Authorization": "\$1\$aRkFpEz3\$qGGbgw/.xtfSv8rvK/j5y0",
      "Client-Service": "frontend-client",
      "Auth-Key": "simplerestapi",
      "Content-Type": "application/x-www-form-urlencoded",
    };

    http.Response response = await http.get(url, headers: header);

    return jsonDecode(response.body);
  }

  /// cancel order api.....
  static Future cancelOrderFromOrderId(
      String orderId, String subOrderId) async {
    int userId = prefs.read<int>('userId');

    String url = "$kBaseURL/purchase/order_cancel_user";
    print("URL $url");
    Map<String, String> header = {
      "Authorization": "\$1\$aRkFpEz3\$qGGbgw/.xtfSv8rvK/j5y0",
      "Client-Service": "frontend-client",
      "Auth-Key": "simplerestapi",
      "Content-Type": "application/x-www-form-urlencoded",
    };

    Map<String, dynamic> body = {
      "client_key": "1595922619X5f1fd8bb5f332",
      "device_type": "MOB",
      "user_id": "$userId",
      "order_no": "$orderId",
      "sub_order_no": "$subOrderId"
    };
    print("REQUEST CANCEL ORDER PARAMETER $body");
    http.Response response = await http.post(
      url,
      headers: header,
      body: body,
      encoding: Encoding.getByName('utf-8'),
    );
    print("RESPONSE CANCEL ORDER ${response.body}");

    return jsonDecode(response.body);
  }

  /// cancel order api.....
  static Future cancelOrderRequestFromOrderId(
      String orderId, String subOrderId) async {
    int userId = prefs.read<int>('userId');

    String url = "$kBaseURL/purchase/order_req_cancel_user";
    print("URL $url");
    Map<String, String> header = {
      "Authorization": "\$1\$aRkFpEz3\$qGGbgw/.xtfSv8rvK/j5y0",
      "Client-Service": "frontend-client",
      "Auth-Key": "simplerestapi",
      "Content-Type": "application/x-www-form-urlencoded",
    };

    Map<String, dynamic> body = {
      "client_key": "1595922619X5f1fd8bb5f332",
      "device_type": "MOB",
      "user_id": "$userId",
      "order_no": "$orderId",
      "sub_order_no": "$subOrderId"
    };
    print("REQUEST CANCEL ORDER PARAMETER $body");
    http.Response response = await http.post(
      url,
      headers: header,
      body: body,
      encoding: Encoding.getByName('utf-8'),
    );
    print("RESPONSE CANCEL ORDER ${response.body}");

    return jsonDecode(response.body);
  }

  /// api to get tracking details of order ....
  static Future getTrackingDetailsOfOrder(String userId, String orderId) async {
    String url =
        "$kBaseURL/purchase/purchase_history_track_details_by_sub_order_no/1595922619X5f1fd8bb5f332/MOB/$userId/$orderId";

    Map<String, String> header = {
      "Authorization": "\$1\$aRkFpEz3\$qGGbgw/.xtfSv8rvK/j5y0",
      "Client-Service": "frontend-client",
      "Auth-Key": "simplerestapi",
      "Content-Type": "application/x-www-form-urlencoded",
    };

    http.Response response = await http.get(url, headers: header);
    return jsonDecode(response.body);
  }
}
