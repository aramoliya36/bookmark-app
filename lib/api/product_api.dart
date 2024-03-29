import 'dart:convert';

import 'package:bookmrk/constant/constant.dart';
import 'package:bookmrk/res/utility.dart';
import 'package:http/http.dart' as http;

class ProductAPI {
  /// api to get all the information of the single product...
  static Future getProductDetails(String productSlug, String userId) async {
    print("SLUG 1 $productSlug");

    String url =
        "$kBaseURL/product/detail/1595922619X5f1fd8bb5f332/MOB/$userId/$productSlug";
    // https://www.bookmrk.in/stage/api_/product/detail/1595922619X5f1fd8bb5f332/MOB/0/st-paul-s-college-bookset-class---1-2021-22-
    Map<String, String> header = {
      "Content-Type": "application/x-www-form-urlencoded",
      "Auth-Key": "simplerestapi",
      "Client-Service": "frontend-client",
    };

    http.Response response = await http.get(url, headers: header);

    return jsonDecode(response.body);
  }

  /// product variation stock details...
  static Future getVariationDetails(
      String userId, String productId, dynamic variation) async {
    String url = "$kBaseURL/product/variations_stock_info";
    Map<String, String> header = {
      "Authorization": "\$1\$aRkFpEz3\$qGGbgw/.xtfSv8rvK/j5y0",
      "Client-Service": "frontend-client",
      "Auth-Key": "simplerestapi",
      "Content-Type": "application/x-www-form-urlencoded",
    };

    Map<String, String> body = {
      "client_key": "1595922619X5f1fd8bb5f332",
      "device_type": "MOB",
      "user_id": "$userId",
      "product_id": "$productId",
      "variations_stock": jsonEncode(variation),
    };

    http.Response response = await http.post(url,
        headers: header, body: body, encoding: Encoding.getByName('utf-8'));
    return jsonDecode(response.body);
  }

  /// pre payment api call.....
  static Future prePaymentAPICall(String userId, String appVersion,
      String paymentMethod, String paymentSource) async {
    String url = "$kBaseURL/payment_call/payment_pre_post";
    Map<String, String> header = {
      "Authorization": "\$1\$aRkFpEz3\$qGGbgw/.xtfSv8rvK/j5y0",
      "Client-Service": "frontend-client",
      "Auth-Key": "simplerestapi",
      "Content-Type": "application/x-www-form-urlencoded",
    };

    Map<String, String> body = {
      "client_key": "1595922619X5f1fd8bb5f332",
      "device_type": "MOB",
      "user_id": "$userId",
      "app_version": "$appVersion",
      "payment_method": "$paymentMethod",
      "payment_source": "$paymentSource",
      "coupon_code": "${Utility.couponCode}",
    };
    print("PAYMENT PROCEED API REQUEST $body");
    http.Response response = await http.post(url, headers: header, body: body);
    return jsonDecode(response.body);
  }

  /// final payment status.....
  static Future finalPaymentStatus(String userId, String orderCost,
      String orderNo, String orderStatus, dynamic paymentResponse) async {
    String url = "$kBaseURL/payment_call/payment_final_status";
    Map<String, String> header = {
      "Authorization": "\$1\$aRkFpEz3\$qGGbgw/.xtfSv8rvK/j5y0",
      "Client-Service": "frontend-client",
      "Auth-Key": "simplerestapi",
      "Content-Type": "application/x-www-form-urlencoded",
    };

    Map<String, String> body = {
      "client_key": "1595922619X5f1fd8bb5f332",
      "device_type": "MOB",
      "user_id": "$userId",
      "order_total_cost": "$orderCost",
      "order_no": "$orderNo",
      "order_status": "$orderStatus",
      "payment_response": "${jsonEncode(paymentResponse)}",
    };

    http.Response response = await http.post(url, headers: header, body: body);
    return jsonDecode(response.body);
  }
}
