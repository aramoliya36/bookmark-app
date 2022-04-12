import 'dart:convert';

import 'package:bookmrk/api/category_api.dart';
import 'package:bookmrk/constant/constant.dart';
import 'package:bookmrk/model/category_product_model.dart';
import 'package:bookmrk/model/filter_class_category_model.dart';
import 'package:bookmrk/model/filter_publisher_category_model.dart';
import 'package:bookmrk/model/publisherListModel.dart';
import 'package:bookmrk/provider/category_provider.dart';
import 'package:bookmrk/provider/homeScreenProvider.dart';
import 'package:bookmrk/provider/vendor_provider.dart';
import 'package:bookmrk/res/colorPalette.dart';
import 'package:bookmrk/res/controller.dart';
import 'package:bookmrk/widgets/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'filter.dart';

class FilterCategoryPublisher extends StatefulWidget {
  final String selectedPublisher;

  const FilterCategoryPublisher(this.selectedPublisher);

  @override
  _FilterCategoryPublisherState createState() =>
      _FilterCategoryPublisherState();
}

class _FilterCategoryPublisherState extends State<FilterCategoryPublisher> {
  ColorPalette colorPalette = ColorPalette();
  static const int PAGE_SIZE = 15;
  bool isFilterData = false;
  CommanGextController commanGextController = Get.put(CommanGextController());

  /// api to get filter category list data....
  Future getFilterCategoryListData() async {
    int userId = prefs.read<int>('userId');
    // dynamic response = await CategoryAPI.getFilterCategory(userId.toString(), 'publisher', widget.selectedPublisher);
    dynamic response = await CategoryAPI.getFilterCategory(
        userId: userId.toString(),
        filterType: 'publisher',
        filterSlug: "${widget.selectedPublisher}",
        filterMap: '',
        page: "0",
        perPage: "15",
        isFilterData: "NO");
    FilterPublisherCategoryModel _filterPublisherCategoryModel =
        FilterPublisherCategoryModel.fromJson(response);

    commanGextController.isProductCount.value =
        _filterPublisherCategoryModel.count;

    return _filterPublisherCategoryModel;
  }

  @override
  Widget build(BuildContext context) {
    print("PUBCALL");
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return FutureBuilder(
        future: getFilterCategoryListData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.response.length <= 0) {
              return Center(
                child: Text(
                  'No Products !',
                  style: TextStyle(fontSize: 18.0),
                ),
              );
            } else {
              return Column(
                children: [
                  Stack(
                    children: [
                      CachedNetworkImage(
                        imageUrl:
                            '${snapshot.data.response[0].publisher[0].publisherImg}',
                        fit: BoxFit.cover,
                        imageBuilder: (context, imageProvider) => Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20),
                          height: height / 12,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage(
                                  "${snapshot.data.response[0].publisher[0].publisherImg}"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        placeholder: (context, s) => Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20),
                          height: height / 12,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: AssetImage("assets/images/preload.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        errorWidget: (context, s, d) => Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20),
                          height: height / 12,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: AssetImage("assets/images/preload.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                        height: height / 12,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black.withOpacity(0.5),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                width: width / 2,
                                child: Text(
                                  '${snapshot.data.response[0].publisher[0].publisherName}',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 20,
                                    color: const Color(0xffffffff),
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Obx(() {
                                  return Text(
                                    '${commanGextController.isProductCount} Products',
                                    style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 20,
                                      color: const Color(0xffffffff),
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                  );
                                  return Text(
                                      "${commanGextController.isProductCount}");
                                }),
                              ),
                            ),
                            /*   Expanded(
                              flex: 2,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Selector<CateGoryCounter, int>(
                                    builder: (context, count, child) {
                                  return Text(
                                    '$count Products',
                                    style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 20,
                                      color: const Color(0xffffffff),
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                  );
                                }, selector: (context, _cateGoryCounter) {
                                  return _cateGoryCounter.totalCategoryProduct;
                                }),
                              ),
                            ),*/
                            InkWell(
                              onTap: () {
                                Get.to(FilterSettingScreen(
                                  isRefresh: () {
                                    print("IS REFRESH");
                                    // isFilterData = true;
                                    setState(() {});
                                  },
                                ), arguments: <String>[
                                  snapshot.data.response[0].publisher[0]
                                      .publisherSlug,
                                  "publisher"
                                ]);
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: SvgPicture.asset(
                                  "assets/icons/settings.svg",
                                  color: Colors.white,
                                  height: 20,
                                  width: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Expanded(
                    child: commanGextController.isProductCount > 0
                        ? Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, bottom: 70),
                            child: PagewiseGridView<ProductPub>.count(
                                key: UniqueKey(),
                                pageSize: PAGE_SIZE,
                                crossAxisCount: 2,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                                childAspectRatio: 0.75,
                                loadingBuilder: (_) =>
                                    CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation(
                                          colorPalette.navyBlue),
                                    ),
                                padding: EdgeInsets.only(bottom: 70),
                                itemBuilder: this._itemBuilder,
                                pageFuture: (pageIndex) {
                                  return getProduct(
                                      context,
                                      pageIndex * PAGE_SIZE,
                                      PAGE_SIZE,
                                      widget.selectedPublisher,
                                      isFilterData,
                                      commanGextController);
                                }),
                          )
                        : noProduct(),
                  ),
                ],
              );
            }
          } else {
            return Container(
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(colorPalette.navyBlue),
                ),
              ),
            );
          }
        });
  }

  static Future<List<ProductPub>> getProduct(
      BuildContext context,
      offset,
      limit,
      String selectedSubCategory,
      bool isFilterData,
      CommanGextController commanGextController) async {
    print("REUEST DATA$selectedSubCategory ");
    var listFilter = [];
    int userId = prefs.read<int>('userId');
    try {
      listFilter = prefs.read(selectedSubCategory) == null
          ? []
          : prefs.read(selectedSubCategory)[0] ?? [];
    } catch (e) {
      print("ERROR $e");
    }

    String url = '$kBaseURL/categories/filter_categories_product_post';
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
      "filter_type": "publisher",
      "filter_slug": "$selectedSubCategory",
      "count": "NO",
      "per_page": "$limit",
      "page": "$offset",
      "filters": "$listFilter",
    };
    print("REQUEST MY API URL  $url");
    print("REQUEST MY API $body");
    http.Response response = await http.post(url,
        headers: header, body: body, encoding: Encoding.getByName('utf-8'));
    var responseData = PublisherListModel.fromJson(jsonDecode(response.body));
    print("RESPONSE MY API ${response.body}");
    https: //www.bookmrk.in/stage/api_/categories/filter_categories_product_post
    https: //www.bookmrk.in/stage/api_/categories/filter_categories_product_post
    var productList = PublisherListModel.fromJson(jsonDecode(response.body))
        .response[0]
        .product;
    var productCoutn =
        PublisherListModel.fromJson(jsonDecode(response.body)).count;
    /*   Provider.of<CateGoryCounter>(context, listen: false).totalCategoryProduct =
        productCoutn;*/
    commanGextController.isProductCount.value = productCoutn;

    if (productList == null) {
      productList = List<ProductPub>.empty();
    }

    // print("RESPONSE ${response.body.toString()}");
    print("PRODUCT LIST LEN ${productList.length}");
    return productList;
  }

  Widget _itemBuilder(context, ProductPub product, _) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: GestureDetector(
        onTap: () {
          // Provider.of<HomeScreenProvider>(context, listen: false)
          //     .selectedTitle = "${product.productName}";
          Provider.of<HomeScreenProvider>(context, listen: false)
              .drawerSelectedTitle = "${product.productName}";
          Provider.of<HomeScreenProvider>(context, listen: false)
              .selectedProductSlug = "${product.productSlug}";
          Provider.of<VendorProvider>(context, listen: false)
              .selectedVendorName = "${product.vendorSlug}";
          // Provider.of<HomeScreenProvider>(context, listen: false)  DK..
          //     .selectedString = "ProductInfo";

          Provider.of<HomeScreenProvider>(context, listen: false)
              .selectedString = "DrawerProductInfo";
        },
        child: ProductBox(
            expanded: true,
            height: Get.height,
            width: Get.width,
            title: "${product.productName}",
            image: "${product.productImg}",
            description: "${product.vendorCompanyName}",
            price: product.productSalePrice,
            stock: "${product.productStockStatus}",
            discount: "${product.productDiscount}"),
      ),
    );
  }

  Widget noProduct() {
    return Center(
      key: UniqueKey(),
      child: Text(
        'No Products !',
        style: TextStyle(fontSize: 18.0),
      ),
    );
  }
}
