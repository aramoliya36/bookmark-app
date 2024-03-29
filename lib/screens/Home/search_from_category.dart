import 'package:bookmrk/api/search_api.dart';
import 'package:bookmrk/api/wishlist_api.dart';
import 'package:bookmrk/constant/constant.dart';
import 'package:bookmrk/model/no_data_model.dart';
import 'package:bookmrk/model/search_product_model.dart';
import 'package:bookmrk/provider/homeScreenProvider.dart';
import 'package:bookmrk/provider/vendor_provider.dart';
import 'package:bookmrk/res/colorPalette.dart';
import 'package:bookmrk/widgets/searchBar.dart';
import 'package:bookmrk/widgets/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class Search2 extends StatefulWidget {
  @override
  _Search2State createState() => _Search2State();
}

class _Search2State extends State<Search2> {
  ColorPalette colorPalette = ColorPalette();
  bool isSearchCall = false;

  /// TextField Controller
  TextEditingController _searchProductController;

  Future searchSuggestionProducts(String productName) async {
    print("IS SEARCH CALL $isSearchCall");
    print("IS SEARCH SUGGSTION PRODUCT API CALL");

    // if (productName.length < 2) {
    //   productName = "a";
    // }

    int userId = prefs.read<int>('userId');
    dynamic response =
        await SearchAPI.searchSuggestion(productName, userId.toString());

    if (response['response'].length == 0) {
      NoDataOrderModel _noData = NoDataOrderModel.fromJson(response);
      return _noData;
    } else {
      SearchSuggestion _searchProductModel =
          SearchSuggestion.fromJson(response);

      // setState(() {});
      return _searchProductModel;
    }
  }

  /// search products....
  Future searchProducts(String productName) async {
    print("IS SEARCH PRODUCT API CALL");
    int userId = prefs.read<int>('userId');
    dynamic response =
        await SearchAPI.searchProductHomePage(productName, userId.toString());
    if (response['response'].length == 0) {
      NoDataOrderModel _noData = NoDataOrderModel.fromJson(response);
      return _noData;
    } else {
      SearchProductModel _searchProductModel =
          SearchProductModel.fromJson(response);
      // isSearchCall = false;
      return _searchProductModel;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    _searchProductController = TextEditingController();
    print("IS INIT CALL");
    _searchProductController.text =
        Provider.of<HomeScreenProvider>(context, listen: false)
            .findHomeScreenProduct;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    print("CALL FROM CATEGORY $isSearchCall");

    return Consumer<HomeScreenProvider>(
      builder: (_, _homeScreenProvider, child) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SearchBar(
              title: "Search Products",
              width: width,
              controller: _searchProductController,
              // searchClick: true,
              onSearchTap: () {
                _homeScreenProvider.findHomeScreenProduct =
                    _searchProductController.text;
                isSearchCall = true;
                FocusScope.of(context).unfocus();
              },
              onChanged: (value) {
                print("IS SEARCH ALL SEARCH $value");
                if (value.length > 0) {
                  searchSuggestionProducts(value);
                  // isSearchCall = false;
                  _homeScreenProvider.findHomeScreenProduct = value;
                  isSearchCall = false;
                }
              }),
          isSearchCall == true
              ? Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, bottom: 75.0),
                    child: FutureBuilder(
                        future: searchProducts(
                            _homeScreenProvider.findHomeScreenProduct),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data.response.length != 0) {
                              if (snapshot.data is SearchProductModel) {
                                SearchProductModel _searchProductModel =
                                    snapshot.data;

                                return GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithMaxCrossAxisExtent(
                                          maxCrossAxisExtent: 300,
                                          childAspectRatio: 0.75,
                                          crossAxisSpacing: 10,
                                          mainAxisSpacing: 10),
                                  itemBuilder: (context, index) {
                                    print(
                                        "STATUS DATA ${_searchProductModel.response[index].productStockStatus}");
                                    return Stack(
                                      fit: false == true
                                          ? StackFit.expand
                                          : StackFit.loose,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            _homeScreenProvider.selectedTitle =
                                                "${snapshot.data.response[index].productName}";
                                            Provider.of<VendorProvider>(context,
                                                        listen: false)
                                                    .selectedVendorName =
                                                "${snapshot.data.response[index].vendorSlug}";
                                            print(
                                                "MY TXT ${_homeScreenProvider.findHomeScreenProduct}");
                                            _searchProductController.text =
                                                _homeScreenProvider
                                                    .findHomeScreenProduct;
                                            _homeScreenProvider
                                                    .selectedProductSlug =
                                                "${snapshot.data.response[index].productSlug}";
                                            _homeScreenProvider.selectedString =
                                                "ProductInfoSearch1";
                                            // "ProductInfoSearch2"; prevois code changed by bhavesh....
                                          },
                                          child: Container(
                                            height: height / 3,
                                            width: width / 2,
                                            margin:
                                                EdgeInsets.only(bottom: 10.0),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              border: Border.all(
                                                color: Color(0xffcfcfcf),
                                              ),
                                            ),
                                            child: ProductBox(
                                                expanded: true,
                                                height: height,
                                                width: width,
                                                title:
                                                    "${snapshot.data.response[index].productName}",
                                                image:
                                                    "${snapshot.data.response[index].productImg}",
                                                description: "",
                                                // "${snapshot.data.response[index].vendorCompanyName}",
                                                price: _searchProductModel
                                                    .response[index]
                                                    .productSalePrice,
                                                stock:
                                                    "${_searchProductModel.response[index].productStockStatus}",
                                                discount:
                                                    "${_searchProductModel.response[index].productDiscount}"),
                                          ),
                                        ),
                                        Positioned(
                                          top: 0,
                                          right: 0,
                                          child: IconButton(
                                            onPressed: () async {
                                              int userId =
                                                  prefs.read<int>('userId');
                                              dynamic response =
                                                  await WishListAPI
                                                      .addProductInWishList(
                                                          userId.toString(),
                                                          snapshot
                                                              .data
                                                              .response[index]
                                                              .productId);
                                              setState(() {});
                                            },
                                            icon: Icon(
                                              snapshot.data.response[index]
                                                          .productInUserWishlist ==
                                                      "1"
                                                  ? Icons.favorite
                                                  : Icons.favorite_border,
                                              color: snapshot
                                                          .data
                                                          .response[index]
                                                          .productInUserWishlist ==
                                                      "1"
                                                  ? Colors.red
                                                  : colorPalette.navyBlue,
                                            ),
                                          ),
                                        )
                                      ],
                                    );
                                  },
                                  itemCount: snapshot.data.response.length,
                                );
                              } else {
                                return Container(
                                  color: Colors.transparent,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation(
                                          colorPalette.navyBlue),
                                    ),
                                  ),
                                );
                              }
                            } else {
                              return Center(
                                child: Padding(
                                  padding: EdgeInsets.only(top: 40.0),
                                  child: Column(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/icons/search1.svg',
                                        height: 100.0,
                                      ),
                                      SizedBox(height: 30),
                                      Text('Search entire store here...'),
                                    ],
                                  ),
                                ),
                              );
                            }
                          } else {
                            return Container(
                              color: Colors.transparent,
                              child: Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation(
                                      colorPalette.navyBlue),
                                ),
                              ),
                            );
                          }
                        }),
                  ),
                )
              : Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, bottom: 75.0),
                    child: FutureBuilder(
                        future: searchSuggestionProducts(
                            _homeScreenProvider.findHomeScreenProduct),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data.response.length != 0) {
                              if (snapshot.data is SearchSuggestion) {
                                SearchSuggestion _searchProductModel =
                                    snapshot.data;
                                return SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: List.generate(
                                        _searchProductModel.response.length,
                                        (index) {
                                      return InkWell(
                                        onTap: () {
                                          if (_searchProductModel
                                                  .response[index].actionType ==
                                              "find") {
                                            _searchProductController.text =
                                                _searchProductModel
                                                    .response[index]
                                                    .productName;
                                          } else {
                                            _homeScreenProvider.selectedTitle =
                                                "${_searchProductModel.response[index].productName}";
                                            Provider.of<VendorProvider>(context,
                                                        listen: false)
                                                    .selectedVendorName =
                                                "${_searchProductModel.response[index].vendorSlug}";

                                            _searchProductController.text =
                                                _homeScreenProvider
                                                    .findHomeScreenProduct;
                                            _homeScreenProvider
                                                    .selectedProductSlug =
                                                "${_searchProductModel.response[index].productSlug}";
                                            _homeScreenProvider.selectedString =
                                                "ProductInfoSearch1";
                                          }
                                        },
                                        child: Column(
                                          children: [
                                            Container(
                                                width: Get.width,
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 10,
                                                    horizontal: 10),
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 5),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  // borderRadius: BorderRadius.circular(10),
                                                  // border: Border.all(
                                                  //     color: Colors.grey.withOpacity(0.5),
                                                ),
                                                height: 30,
                                                child: Text(_searchProductModel
                                                    .response[index]
                                                    .productName)),
                                            Divider(
                                              color: Colors.black,
                                              height: 2,
                                            )
                                          ],
                                        ),
                                      );
                                    }),
                                  ),
                                );
                              } else {
                                return Container(
                                  color: Colors.transparent,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation(
                                          colorPalette.navyBlue),
                                    ),
                                  ),
                                );
                              }
                            } else {
                              return Padding(
                                padding: EdgeInsets.only(top: 40.0),
                                child: Column(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/search1.svg',
                                      height: 100.0,
                                    ),
                                    SizedBox(height: 30),
                                    Text('Search entire store here...'),
                                  ],
                                ),
                              );
                            }
                          } else {
                            return Container(
                              color: Colors.transparent,
                              child: Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation(
                                      colorPalette.navyBlue),
                                ),
                              ),
                            );
                          }
                        }),
                  ),
                )
        ],
      ),
    );
  }
}
