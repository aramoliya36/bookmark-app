import 'dart:convert';
import 'package:bookmrk/constant/constant.dart';
import 'package:bookmrk/model/help_response_model.dart';
import 'package:http/http.dart' as http;

class HelpArticleSectionAPI {
  static Future getHelpArticle() async {
    http: //bookmrk.in/stage/api_/app/help_article_section/1595922619X5f1fd8bb5f332/MOB
    String url =
        "$kBaseURL/app/help_article_section/1595922619X5f1fd8bb5f332/MOB";
    Map<String, String> header = {
      "Authorization": "\$1\$aRkFpEz3\$qGGbgw/.xtfSv8rvK/j5y0",
      "Client-Service": "frontend-client",
      "Auth-Key": "simplerestapi",
      "Content-Type": "application/x-www-form-urlencoded",
    };
    http.Response response = await http.get(
      url,
      headers: header,
    );
    print("RESPONSE HELP${response.body}");
    dynamic data = jsonDecode(response.body);

    return HelpResponseModel.fromJson(data);
  }
}
