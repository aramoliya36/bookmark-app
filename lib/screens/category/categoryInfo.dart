import 'package:bookmrk/api/category_api.dart';
import 'package:bookmrk/constant/constant.dart';
import 'package:bookmrk/model/category_product_model.dart';
import 'package:bookmrk/model/no_data_model.dart';
import 'package:bookmrk/provider/category_provider.dart';
import 'package:bookmrk/provider/homeScreenProvider.dart';
import 'package:bookmrk/provider/vendor_provider.dart';
import 'package:bookmrk/res/colorPalette.dart';
import 'package:bookmrk/screens/Home/filter.dart';

import 'package:bookmrk/widgets/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class CategoryInfo extends StatefulWidget {
  final String categoryName;

  const CategoryInfo(this.categoryName);

  @override
  _CategoryInfoState createState() => _CategoryInfoState();
}

class _CategoryInfoState extends State<CategoryInfo> {
  String message = "";
  int totalData = 1;
  int pageCount = 0;
  bool isAllCategory = true;
  static const int PAGE_SIZE = 15;
  CateGoryCounter _cateGoryCounter;
  bool isFilterData = false;
  bool isAPICALL = false;

  @override
  void initState() {
    makeDefault();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    _cateGoryCounter = Provider.of<CateGoryCounter>(context, listen: false);
    print("MY CATEGORY ${widget.categoryName}");

    return FutureBuilder(
        future: getCategoryProductsDetails(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != null) {
              CategoryProductsModel categoryProductsModel = snapshot.data;
              if (categoryProductsModel.response.length > 0) {
                int isFilterExits =
                    categoryProductsModel.response[0].category[0].isFilterExits;
                isAllCategory = true;
                if (snapshot.data.response.length <= 0) {
                  return noProduct();
                } else {
                  return Column(
                    children: [
                      Stack(
                        children: [
                          CachedNetworkImage(
                            imageUrl:
                                '${snapshot.data.response[0].category[0].categoryImg}',
                            fit: BoxFit.cover,
                            imageBuilder: (context, imageProvider) => Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 20),
                              height: height / 12,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: NetworkImage(
                                      "${snapshot.data.response[0].category[0].categoryImg}"),
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
                                  image:
                                      AssetImage("assets/images/preload.png"),
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
                                  image:
                                      AssetImage("assets/images/preload.png"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Consumer<CategoryProvider>(
                              builder: (_, _categoryProvider, child) {
                            return Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 20),
                              height: height / 12,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.black.withOpacity(0.5),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      child: Text(
                                        '${_categoryProvider.selectedCategoryNameToShow == "" || _categoryProvider.selectedCategoryNameToShow == null ? "All" : _categoryProvider.selectedCategoryNameToShow}',
                                        style: TextStyle(
                                          fontFamily: 'Roboto',
                                          fontSize: 20,
                                          color: const Color(0xffffffff),
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                      width: width / 2,
                                    ),
                                  ),
                                  Expanded(
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
                                        return _cateGoryCounter
                                            .totalCategoryProduct;
                                      }),
                                    ),
                                  ),
                                  isFilterExits == 1
                                      ? InkWell(
                                          onTap: () {
                                            print(
                                                "IS TAP FILTER ${widget.categoryName}");
                                            Get.to(FilterSettingScreen(
                                              isRefresh: () {
                                                print("IS REFRESH");
                                                isFilterData = true;
                                                setState(() {});
                                              },
                                            ), arguments: <String>[
                                              _categoryProvider
                                                              .selectedSubCategory ==
                                                          null ||
                                                      _categoryProvider
                                                              .selectedSubCategory ==
                                                          ""
                                                  ? widget.categoryName
                                                  : _categoryProvider
                                                      .selectedSubCategory
                                            ]);
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: SvgPicture.asset(
                                              "assets/icons/settings.svg",
                                              color: Colors.white,
                                              height: 20,
                                              width: 20,
                                            ),
                                          ),
                                        )
                                      : SizedBox(),
                                ],
                              ),
                            );
                          }),
                        ],
                      ),
                      Consumer<CategoryProvider>(
                          builder: (_, _categoryProvider, child) {
                        return Consumer<HomeScreenProvider>(
                          builder: (_, _homeScreenProvider, child) => Container(
                            height:
                                snapshot.data.response[0].subCategory.length > 0
                                    ? height / 25
                                    : height / 45,
                            child: snapshot
                                        .data.response[0].subCategory.length >
                                    0
                                ? SingleChildScrollView(
                                    physics: BouncingScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            left: 10.0,
                                          ),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: _categoryProvider
                                                                .selectedSubCategory ==
                                                            "" ||
                                                        _categoryProvider
                                                                .selectedSubCategory ==
                                                            null
                                                    ? colorPalette.navyBlue
                                                    : Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(5.0)),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10.0,
                                                vertical: 5.0),
                                            child: GestureDetector(
                                              onTap: () {
                                                isAllCategory = false;

                                                _categoryProvider
                                                    .selectedSubCategory = "";
                                                _categoryProvider
                                                    .selectedCategoryNameToShow = "";
                                              },
                                              child: Text(
                                                'All',
                                                style: TextStyle(
                                                    fontFamily: 'Roboto',
                                                    fontSize: 14,
                                                    color: _categoryProvider
                                                                    .selectedSubCategory ==
                                                                "" ||
                                                            _categoryProvider
                                                                    .selectedSubCategory ==
                                                                null
                                                        ? Colors.white
                                                        : colorPalette
                                                            .navyBlue),
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Row(
                                          children: List.generate(
                                            snapshot.data.response[0]
                                                .subCategory.length,
                                            (index) => GestureDetector(
                                              onTap: () {
                                                pageCount = 0;
                                                isFilterData = false;

                                                _categoryProvider
                                                        .selectedSubCategory =
                                                    "${snapshot.data.response[0].subCategory[index].catSlug}";
                                                print(
                                                    "IS TAP ${_categoryProvider.selectedSubCategory}");

                                                _categoryProvider
                                                        .selectedCategoryNameToShow =
                                                    "${snapshot.data.response[0].subCategory[index].categoryName}";
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: _categoryProvider
                                                                .selectedSubCategory ==
                                                            "${snapshot.data.response[0].subCategory[index].catSlug}"
                                                        ? colorPalette.navyBlue
                                                        : Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0)),
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10.0,
                                                    vertical: 5.0),
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 10.0),
                                                child: Text(
                                                  '${snapshot.data.response[0].subCategory[index].categoryName}',
                                                  style: TextStyle(
                                                      fontFamily: 'Roboto',
                                                      fontSize: 14,
                                                      color: _categoryProvider
                                                                  .selectedSubCategory ==
                                                              "${snapshot.data.response[0].subCategory[index].catSlug}"
                                                          ? Colors.white
                                                          : colorPalette
                                                              .navyBlue),
                                                  textAlign: TextAlign.left,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : SizedBox(),
                          ),
                        );
                      }),
                      SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: Consumer<CategoryProvider>(
                            builder: (_, _categoryProvider, child) {
                          if (_categoryProvider.selectedSubCategory == "" ||
                              _categoryProvider.selectedSubCategory == null) {
                            _cateGoryCounter.totalCategoryProductInit =
                                int.parse(snapshot.data.response[0].category[0]
                                        .allProductsCount ??
                                    "0");
                            if (categoryProductsModel
                                    .response[0].category[0].catSlug ==
                                "books") {
                              pageCount =
                                  snapshot.data.response[0].product.length;
                            }

                            return Provider.of<CateGoryCounter>(context,
                                            listen: false)
                                        .totalCategoryProduct >
                                    0
                                ? PagewiseGridView<Product>.count(
                                    key: UniqueKey(),
                                    pageSize: PAGE_SIZE,
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 10,
                                    childAspectRatio: 0.75,
                                    padding: EdgeInsets.only(bottom: 70),
                                    itemBuilder: this._itemBuilder,
                                    pageFuture: (pageIndex) {
                                      return CategoryAPI.getProduct(
                                          context,
                                          pageIndex * PAGE_SIZE,
                                          PAGE_SIZE,
                                          widget.categoryName,
                                          _categoryProvider,
                                          isFilterData);
                                    })
                                : noProduct();
                          } else {
                            print("IS ELSE CALL");
                            if (Provider.of<CateGoryCounter>(context,
                                        listen: false)
                                    .totalCategoryProduct ==
                                0) {
                              CategoryAPI.getProduct(
                                  context,
                                  1 * PAGE_SIZE,
                                  PAGE_SIZE,
                                  _categoryProvider.selectedSubCategory,
                                  _categoryProvider,
                                  isFilterData);
                            }
                            return Provider.of<CateGoryCounter>(context,
                                            listen: false)
                                        .totalCategoryProduct >
                                    0
                                ? PagewiseGridView<Product>.count(
                                    key: UniqueKey(),
                                    pageSize: PAGE_SIZE,
                                    crossAxisCount: 2,
                                    childAspectRatio: 0.75,
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 10,
                                    loadingBuilder: (_) {
                                      return Container(
                                        child: Center(
                                          child: CircularProgressIndicator(
                                            valueColor: AlwaysStoppedAnimation(
                                                colorPalette.navyBlue),
                                          ),
                                        ),
                                      );
                                    },
                                    padding: EdgeInsets.only(bottom: 70),
                                    itemBuilder: this._itemBuilder,
                                    pageFuture: (pageIndex) {
                                      return CategoryAPI.getProduct(
                                          context,
                                          pageIndex * PAGE_SIZE,
                                          PAGE_SIZE,
                                          _categoryProvider.selectedSubCategory,
                                          _categoryProvider,
                                          isFilterData);
                                    })
                                : noProduct();
                          }
                        }),
                      ),
                    ],
                  );
                }
              } else {
                return noProduct();
              }
            } else {
              return noProduct();
            }
          } else {
            print("IS CIRCULAR FUTURE");
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

  Widget noProduct() {
    return Center(
      key: UniqueKey(),
      child: Text(
        'No Products !',
        style: TextStyle(fontSize: 18.0),
      ),
    );
  }

  Widget _itemBuilder(context, Product product, _) {
    if (Provider.of<CateGoryCounter>(context, listen: false)
            .totalCategoryProduct >
        0) {
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
    } else {
      return noProduct();
    }
  }

  Future getCategoryProductsDetails() async {
    int userId = prefs.read<int>('userId');
    dynamic categoryProductsDetails = await CategoryAPI.getCategoryProducts(
        widget.categoryName, userId.toString(), "NO",
        pageCount: pageCount);
    if (categoryProductsDetails['response'].length == "0") {
      NoDataOrderModel _noDataModel =
          NoDataOrderModel.fromJson(categoryProductsDetails);
      return _noDataModel;
    } else {
      totalData = 0;
      CategoryProductsModel _categoryProductModelDetails =
          CategoryProductsModel.fromJson(categoryProductsDetails);
      totalData = _categoryProductModelDetails.count;

      return _categoryProductModelDetails;
    }
  }

  ColorPalette colorPalette = ColorPalette();

  makeDefault() {
    Provider.of<CategoryProvider>(context, listen: false)
        .selectedCategoryNameToShowInit = "";
    Provider.of<CategoryProvider>(context, listen: false)
        .selectedSubCategoryInit = "";
  }
}
