import 'package:bookmrk/api/category_api.dart';
import 'package:bookmrk/api/home_page_api.dart';
import 'package:bookmrk/constant/constant.dart';
import 'package:bookmrk/model/category_filter_model.dart';
import 'package:bookmrk/model/filter_class_category_model.dart';
import 'package:bookmrk/model/no_data_model.dart';
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

import 'filter.dart';

class FilterCategoryClass extends StatefulWidget {
  final String selectedClass;

  const FilterCategoryClass(this.selectedClass);

  @override
  _FilterCategoryClassState createState() => _FilterCategoryClassState();
}

class _FilterCategoryClassState extends State<FilterCategoryClass> {
  ColorPalette colorPalette = ColorPalette();
  static const int PAGE_SIZE = 15;
  CommanGextController commanGextController = Get.put(CommanGextController());

  /// api to get filter category list data....
  Future getFilterCategoryListData() async {
    int userId = prefs.read<int>('userId');
    dynamic response = await HomePageApi.filterCategoryProduct(
        userId: userId.toString(),
        filterType: 'class',
        filterSlug: "${widget.selectedClass}",
        filterMap: '',
        page: "0",
        perPage: "15",
        isFilterData: "NO");
    // userId.toString(), 'class', widget.selectedClass);
    FilterClassCategoryModel _filterCategoryModel =
        FilterClassCategoryModel.fromJson(response);
    commanGextController.isProductCount.value = _filterCategoryModel.count;

    return _filterCategoryModel;
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return FutureBuilder(
        future: getFilterCategoryListData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.response.length <= 0) {
              return Center(
                child: Text(
                  'No Products 111!',
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
                            '${snapshot.data.response[0].responseClass[0].classImg}',
                        fit: BoxFit.cover,
                        imageBuilder: (context, imageProvider) => Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20),
                          height: height / 12,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage(
                                  "${snapshot.data.response[0].responseClass[0].classImg}"),
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
                                  '${snapshot.data.response[0].responseClass[0].className}',
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
                                  print(
                                      "IS GET COUNT ${commanGextController.isProductCount}");
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
                            InkWell(
                              onTap: () {
                                Get.to(FilterSettingScreen(
                                  isRefresh: () {
                                    print("IS REFRESH");
                                    // isFilterData = true;
                                    setState(() {});
                                  },
                                ), arguments: <String>[
                                  snapshot.data.response[0].responseClass[0]
                                      .classSlug,
                                  'class'
                                ]);
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: SvgPicture.asset(
                                  "assets/icons/settings.svg",
                                  color: Colors.white,
                                  height: 20,
                                  width: 20,
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        height: Get.height,
                        child: Obx(() {
                          return commanGextController.isProductCount.value >= 0
                              ? PagewiseGridView<ProductClass>.count(
                                  key: UniqueKey(),
                                  pageSize: PAGE_SIZE,
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                  childAspectRatio: 0.75,
                                  padding: EdgeInsets.only(bottom: 70),
                                  itemBuilder: this._itemBuilder,
                                  pageFuture: (pageIndex) {
                                    print(
                                        "SELECTED CLASS${widget.selectedClass}");
                                    return HomePageApi.getProductHome(
                                        context,
                                        pageIndex * PAGE_SIZE,
                                        PAGE_SIZE,
                                        widget.selectedClass,
                                        // _categoryProvider,
                                        "NO");
                                  })
                              : noProduct();
                        }),
                      ),
                    ),
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

  Widget _itemBuilder(context, ProductClass product, _) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: GestureDetector(
        onTap: () {
          Provider.of<HomeScreenProvider>(context, listen: false)
              .selectedTitle = "${product.productName}";
          Provider.of<HomeScreenProvider>(context, listen: false)
              .selectedProductSlug = "${product.productSlug}";
          Provider.of<VendorProvider>(context, listen: false)
              .selectedVendorName = "${product.vendorSlug}";
          Provider.of<HomeScreenProvider>(context, listen: false)
              .selectedString = "ProductInfo";
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
    return Text(
      'No Products !222',
      style: TextStyle(fontSize: 18.0),
    );
  }

  Widget noProduct121() {
    return Text(
      'No Products !121',
      style: TextStyle(fontSize: 18.0),
    );
  }
}
