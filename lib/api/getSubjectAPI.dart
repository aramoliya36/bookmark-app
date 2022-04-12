import 'dart:convert';

import 'package:bookmrk/constant/constant.dart';
import 'package:bookmrk/model/filterCategoriesResponse.dart';
import 'package:http/http.dart' as http;

class GetSubjectAPI {
  static Future getSubjectPageList() async {
    int userId = prefs.read<int>('userId');

    String url =
        "$kBaseURL/categories/filter_categories/1595922619X5f1fd8bb5f332/MOB/$userId";

    Map<String, String> header = {
//      "Authorization": "\$1\$aRkFpEz3\$qGGbgw/.xtfSv8rvK/j5y0",
      "Client-Service": "frontend-client",
//      "User-ID": "1",
      "Auth-Key": "simplerestapi",
      "Content-Type": "application/x-www-form-urlencoded",
    };
    print("URL $url");
    http.Response response = await http.get(
      url,
      headers: header,
    );
    print("SUBJECT RESPONSE ${response.body}");
    dynamic data = jsonDecode(response.body);
    FilterCategoriesResponse filterCategoriesResponse =
        FilterCategoriesResponse.fromJson(data);
    return filterCategoriesResponse;
  }
}
