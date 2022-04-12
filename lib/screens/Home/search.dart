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
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

///search call from alll...
class _SearchState extends State<Search> {
  ColorPalette colorPalette = ColorPalette();

  /// TextField Controller
  TextEditingController _searchProductController = TextEditingController();

  /// search products....
  Future searchProducts(String productName) async {
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
      setState(() {});
      return _searchProductModel;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _searchProductController.text =
        Provider.of<HomeScreenProvider>(context, listen: false)
            .findHomeScreenProduct;
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Consumer<HomeScreenProvider>(
      builder: (_, _homeScreenProvider, child) => Column(
        children: [
          SearchBar(
              title: "Search Products",
              width: width,
              controller: _searchProductController,
              // searchClick: true,
              onSearchTap: () {
                print("IS SEARCH ALL SEARCH1");

                _homeScreenProvider.findHomeScreenProduct =
                    _searchProductController.text;
              },
              onChanged: (value) {
                if (value.length > 3) {
                  print("IS SEARCH ALL SEARCH");

                  searchProducts(value);
                  _homeScreenProvider.findHomeScreenProduct = value;
                }
              }),
          Expanded(
            child: FutureBuilder(
                future:
                    searchProducts(_homeScreenProvider.findHomeScreenProduct),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.response.length != 0) {
                      SearchSuggestion _searchSuggestion = snapshot.data;
                      return ListView.builder(
                        padding: EdgeInsets.only(
                            bottom:
                                MediaQuery.of(context).viewInsets.bottom == 0.0
                                    ? 70
                                    : MediaQuery.of(context).viewInsets.bottom),
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              FocusScope.of(context).unfocus();
                              Provider.of<VendorProvider>(context,
                                          listen: false)
                                      .selectedVendorName =
                                  _searchSuggestion.response[index].vendorSlug;
                              /*   if (_searchSuggestion
                                      .response[index].actionType ==
                                  'find') {

                                    // _homeScreenProvider.findHomeScreenProduct =
                                    //     _searchProductController.text;
                                    _homeScreenProvider.selectedTitle =
                                        _searchSuggestion
                                            .response[index].productName;
                              } else {*/
                              _homeScreenProvider.selectedProductSlug =
                                  _searchSuggestion.response[index].productSlug;
                              _homeScreenProvider.selectedTitle =
                                  _searchSuggestion.response[index].productName;
                              _homeScreenProvider.selectedString =
                                  "ProductInfoSearch1";
                              // }
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              decoration: BoxDecoration(
                                color: Color(0xfff3f3f3),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                _searchSuggestion.response[index].productName,
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 14,
                                  color: Colors.black45,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                          );
                        },
                        itemCount: _searchSuggestion.response.length,
                      );
                    } else {
                      return Padding(
                        padding: EdgeInsets.only(top: 40.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
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
                          valueColor:
                              AlwaysStoppedAnimation(colorPalette.navyBlue),
                        ),
                      ),
                    );
                  }
                }),
          )
        ],
      ),
    );
  }
}
