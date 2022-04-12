import 'dart:convert';

import 'package:bookmrk/constant/constant.dart';
import 'package:bookmrk/model/filter_class_category_model.dart';
import 'package:bookmrk/model/filter_subject_category_model.dart';
import 'package:bookmrk/model/home_page_model.dart';
import 'package:bookmrk/provider/category_provider.dart';
import 'package:bookmrk/res/controller.dart';
import 'package:bookmrk/res/utility.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class HomePageApi {
  /// api to show all the details of home page.
  static Future getHomePageDetails() async {
    String url = "$kBaseURL/home/homepage/1595922619X5f1fd8bb5f332/MOB/1";

    Map<String, String> header = {
//      "Authorization": "\$1\$aRkFpEz3\$qGGbgw/.xtfSv8rvK/j5y0",
      "Client-Service": "frontend-client",
//      "User-ID": "1",
      "Auth-Key": "simplerestapi",
      "Content-Type": "application/x-www-form-urlencoded",
    };

    http.Response response = await http.get(
      url,
      headers: header,
    );
// print("ERESPONSE HOM ${jsonDecode(response.body)}");
    dynamic data = jsonDecode(response.body);
    HomePageModel homePageModel = HomePageModel.fromJson(data);
    if (homePageModel.response != null && homePageModel.response.length > 0) {
      if (homePageModel.response[0].appConfig != null &&
          homePageModel.response[0].appConfig.length > 0) {
        AppConfig appConfig = homePageModel.response[0].appConfig[0];
        Utility.isMultiFilter = appConfig.multiFilter;
        Utility.customerEmail = appConfig.email1;
        Utility.companyEmail = appConfig.email2;
        Utility.companyMobileNumber = appConfig.mobile;
        Utility.companyAddress = appConfig.address;
        Utility.termsConditionsURL = appConfig.termsAndConditionsLink;
        Utility.privacyPolicyURL = appConfig.privacyPolicyLink;
      }
    }

    return data;
  }

  /// api to update application information......
  static Future updateApplicationInfo(
    String userId,
    String deviceId,
    String osInfo,
    String modelName,
    String appVersion,
    dynamic moreInfo,
  ) async {
    String url = "$kBaseURL/login/update_app_info";

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
      "device_id": "$deviceId",
      "os_info": "$osInfo",
      "model_name": "$modelName",
      "app_version": "$appVersion",
      "more_app_info": "${jsonEncode(moreInfo)}",
    };

    http.Response response = await http.post(url, headers: header, body: body);
    return jsonDecode(response.body);
  }

  ///API TO ADD FILTER FOR SHOP BY CLASS AND SHOP BY SUBJECT....

  static Future filterCategoryProduct({
    String userId,
    String filterType,
    String filterSlug,
    String isFilterData,
    String perPage,
    String page,
    String filterMap,
    CommanGextController controller,
  }) async {
    String url = "$kBaseURL/categories/filter_categories_product_post";
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
      "filter_type": filterType,
      "filter_slug": "$filterSlug",
      "count": "$isFilterData",
      "per_page": "$perPage",
      "page": "$page",
      "filters": "$filterMap"
    };
    print("FILTER REQUEST 1---> ${body}");

    http.Response response = await http.post(
      url,
      headers: header,
      body: body,
      encoding: Encoding.getByName('utf-8'),
    );
    print("FILTER RESPONSE 1---> ${response.body}");
    return jsonDecode(response.body);
  }

  static Future subjectClassFilter({
    String userId,
    String filterType,
    String filterSlug,
    String isFilterData,
    String perPage,
    String page,
    String filterMap,
  }) async {
    String url = "$kBaseURL/categories/filter_categories_product_post";
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
      "filter_type": filterType,
      "filter_slug": "$filterSlug",
      "count": "$isFilterData",
      "per_page": "$perPage",
      "page": "$page",
      "filters": "$filterMap"
    };
    print("FILTER REQUEST 2---> ${body}");

    http.Response response = await http.post(
      url,
      headers: header,
      body: body,
      encoding: Encoding.getByName('utf-8'),
    );
    print("FILTER RESPONSE 2---> ${response.body}");
    return jsonDecode(response.body);
  }

  static Future<List<ProductClass>> getProductHome(
      BuildContext context,
      offset,
      limit,
      String filterType,
      // CategoryProvider categoryProvider,
      String isFilterData) async {
    CommanGextController commanGextController = Get.put(CommanGextController());

    var listFilter = [];
    int userId = prefs.read<int>('userId');
    String selectedSubCategory = 'class';
    try {
      print("CATEGORY ${selectedSubCategory}");
      print("STPRE PREFRANCE ${prefs.read(filterType)}");
      listFilter =
          prefs.read(filterType) == null ? [] : prefs.read(filterType)[0] ?? [];
    } catch (e) {
      print("ERROR $e");
    }
    String url = "$kBaseURL/categories/filter_categories_product_post";

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
      "filter_type": "class",
      "filter_slug": "$filterType",
      "count": "NO",
      "per_page": "$limit",
      "page": "$offset",
      "filters": "$listFilter",
    };
    print("REQUEST PAGINATION $body");
    http.Response response = await http.post(url,
        headers: header, body: body, encoding: Encoding.getByName('utf-8'));
    var responseData =
        FilterClassCategoryModel.fromJson(jsonDecode(response.body));
    var productList =
        FilterClassCategoryModel.fromJson(jsonDecode(response.body))
            .response[0]
            .product;
    var productCoutn =
        FilterClassCategoryModel.fromJson(jsonDecode(response.body)).count;

    commanGextController.isProductCount.value = productCoutn;
    if (productList == null) {
      productList = List<ProductClass>.empty();
    }
    print("RESPONSE PAGINATION ${response.body.toString()}");

    return productList;
  }

  static Future<List<ProductSubject>> getProductHomeSubject(
      BuildContext context,
      offset,
      limit,
      String filterType,
      // CateGoryCounter cateGoryCounter,
      String isFilterData,
      String isCategory,
      CommanGextController commanGextController) async {
    var listFilter = [];
    int userId = prefs.read<int>('userId');

    try {
      print("STPRE PREFRANCE STRING $isCategory");
      print("STPRE PREFRANCE ${prefs.read(isCategory)}");
      listFilter =
          prefs.read(filterType) == null ? [] : prefs.read(filterType)[0] ?? [];
    } catch (e) {
      print("ERROR $e");
    }
    String url = "$kBaseURL/categories/filter_categories_product_post";

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
      "filter_type": "subject",
      "filter_slug": "$filterType",
      "count": "NO",
      "per_page": "$limit",
      "page": "$offset",
      "filters": "$listFilter",
    };
    print("REQUEST PAGINATION SUBJECT $body");
    http.Response response = await http.post(url,
        headers: header, body: body, encoding: Encoding.getByName('utf-8'));
    var responseData =
        FilterSubjectCategoryModel.fromJson(jsonDecode(response.body));
    var productList =
        FilterSubjectCategoryModel.fromJson(jsonDecode(response.body))
            .response[0]
            .product;
    var productCoutn =
        FilterSubjectCategoryModel.fromJson(jsonDecode(response.body)).count;
    commanGextController.isProductCount.value = productCoutn;
    // cateGoryCounter.totalCategoryProduct = productCoutn;
    if (productList == null) {
      productList = List<ProductSubject>.empty();
    }
    print("RESPONSE PAGINATION SUBJECT ${response.body.toString()}");

    return productList;
  }
}
//
// FilterClassCategoryModel _filterCategoryModel =
// FilterClassCategoryModel.fromJson(response);
// return _filterCategoryModel;
