import 'dart:convert';

import 'package:bookmrk/constant/constant.dart';
import 'package:bookmrk/model/category_product_model.dart';
import 'package:bookmrk/provider/category_provider.dart';
import 'package:bookmrk/res/utility.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class CategoryAPI {
  /// api to list all the categories.
  static Future getAllCategoryList() async {
    String url =
        "$kBaseURL/categories/main_categories/1595922619X5f1fd8bb5f332/MOB/1";

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

    dynamic data = jsonDecode(response.body);
    return data;
  }

  /// api to get all products from category..
  static Future getCategoryProducts(
      String categorySlug, String userId, String isFilter,
      {int pageCount}) async {
    // print("MY API CALL COUNT ${pageCount}");
    // print("MY SLUG $categorySlug");
    String url =
        "$kBaseURL/categories/categories_by_subcategories_product/1595922619X5f1fd8bb5f332/MOB/$userId/$categorySlug/$isFilter/15/0/0/0/0";
    // "$kBaseURL/categories/categories_by_subcategories_product/1595922619X5f1fd8bb5f332/MOB/$userId/$categorySlug";
// print("URL $url");
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
    dynamic data = jsonDecode(response.body);
    // print("CATEGORY RESPONSE ${response.body}");
    return data;
  }

  /// get list of category with subcategory ....
  static Future getListOfCategoryWithSubCategory(String userId) async {
    String url =
        "$kBaseURL/categories/main_categories_view_with_subcategory/1595922619X5f1fd8bb5f332/MOB/$userId";
    Map<String, String> header = {
      "Client-Service": "frontend-client",
      "Auth-Key": "simplerestapi",
      "Content-Type": "application/x-www-form-urlencoded",
    };

    http.Response response = await http.get(url, headers: header);
    return jsonDecode(response.body);
  }

  /// category filter publisher, class, subjects...
  static Future getFilterCategory(
      {String userId,
      String filterType,
      String filterSlug,
      String filterMap,
      String page,
      String perPage,
      String isFilterData}) async {
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
      "filter_type": "$filterType",
      "filter_slug": "$filterSlug",
      "count": "NO",
      "per_page": "$perPage",
      "page": "$page",
      "filters": "$isFilterData",
    };
    print("REQUEST PAGINATION $body");
    print("API URL--> $url");
    http.Response response = await http.post(url,
        headers: header, body: body, encoding: Encoding.getByName('utf-8'));
    print("FILTER PUBLISHER RESPONSE1 ---> ${response.body}");
    return jsonDecode(response.body);
  }

  static Future postCategoryBySubCategoryProduct({
    String userId,
    String categorySlug,
    String isFilterData,
    String perPage,
    String page,
    String filterMap,
  }) async {
    // String url = "$kBaseURL/purchase/add_to_cart";

    String url =
        "$kBaseURL/categories/categories_by_subcategories_product_post";
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
      "cat_slug": "$categorySlug",
      "count": "$isFilterData",
      "per_page": "$perPage",
      "page": "$page",
      "filters": "$filterMap"
    };
    print("FILTER REQUEST1 ---> ${body}");

    http.Response response = await http.post(
      url,
      headers: header,
      body: body,
      encoding: Encoding.getByName('utf-8'),
    );
    print("FILTER RESPONSE1 ---> ${response.body}");
    return jsonDecode(response.body);
  }

  static Future postFilterDataList({
    String userId,
    String categorySlug,
    String isFilterData,
    String perPage,
    String page,
    String filterMap,
  }) async {
    // String url = "$kBaseURL/purchase/add_to_cart";

    String url =
        "$kBaseURL/categories/categories_by_subcategories_product_post";
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
      "cat_slug": "$categorySlug",
      "count": "$isFilterData",
      "per_page": "$perPage",
      "page": "$page",
      "filters": "$filterMap"
    };
    print("FILTER REQUEST1 ---> ${body}");

    http.Response response = await http.post(
      url,
      headers: header,
      body: body,
      encoding: Encoding.getByName('utf-8'),
    );
    print("FILTER RESPONSE1 ---> ${response.body}");
    return jsonDecode(response.body);
  }

  static Future<List<Product>> getProduct(
      BuildContext context,
      offset,
      limit,
      String selectedSubCategory,
      CategoryProvider categoryProvider,
      bool isFilterData) async {
    var listFilter = [];
    int userId = prefs.read<int>('userId');
    try {
      listFilter = prefs.read(selectedSubCategory) == null
          ? []
          : prefs.read(selectedSubCategory)[0] ?? [];
    } catch (e) {
      print("ERROR $e");
    }

    String url =
        '$kBaseURL/categories/categories_by_subcategories_product_post';
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
      "cat_slug": "$selectedSubCategory",
      "count": "NO",
      "per_page": "$limit",
      "page": "$offset",
      "filters": "$listFilter",
    };
    // print("REQUEST $body");
    http.Response response = await http.post(url,
        headers: header, body: body, encoding: Encoding.getByName('utf-8'));
    var responseData =
        CategoryProductsModel.fromJson(jsonDecode(response.body));
    var productList = CategoryProductsModel.fromJson(jsonDecode(response.body))
        .response[0]
        .product;
    var productCoutn =
        CategoryProductsModel.fromJson(jsonDecode(response.body)).count;
    Provider.of<CateGoryCounter>(context, listen: false).totalCategoryProduct =
        productCoutn;
    if (productList == null) {
      productList = List<Product>.empty();
    }
    // print("RESPONSE ${response.body.toString()}");

    return productList;
  }
}
