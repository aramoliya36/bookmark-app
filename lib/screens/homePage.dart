import 'package:bookmrk/api/home_page_api.dart';
import 'package:bookmrk/model/home_page_model.dart';
import 'package:bookmrk/provider/category_provider.dart';
import 'package:bookmrk/provider/filter_category_provider.dart';
import 'package:bookmrk/provider/homeScreenProvider.dart';
import 'package:bookmrk/provider/order_provider.dart';
import 'package:bookmrk/provider/school_provider.dart';
import 'package:bookmrk/provider/user_provider.dart';
import 'package:bookmrk/provider/vendor_provider.dart';
import 'package:bookmrk/res/colorPalette.dart';
import 'package:bookmrk/res/images.dart';
import 'package:bookmrk/screens/Home/filter.dart';
import 'package:bookmrk/screens/Home/filter_category_class.dart';
import 'package:bookmrk/screens/Home/filter_category_publisher.dart';
import 'package:bookmrk/screens/Home/filter_category_subject.dart';
import 'package:bookmrk/screens/Home/productInfo.dart';
import 'package:bookmrk/screens/Home/schoolInfo.dart';
import 'package:bookmrk/screens/Home/search.dart';
import 'package:bookmrk/screens/Home/search_from_category.dart';
import 'package:bookmrk/screens/Home/vendorsInfo.dart';
import 'package:bookmrk/screens/cart/addAddress.dart';
import 'package:bookmrk/screens/cart/changeAddress.dart';
import 'package:bookmrk/screens/cart/editAddress.dart';
import 'package:bookmrk/screens/tabs/all_brand.dart';
import 'package:bookmrk/screens/tabs/all_publisher_page.dart';
import 'package:bookmrk/screens/tabs/all_subjects_page.dart';
import 'package:bookmrk/screens/tabs/cart.dart';
import 'package:bookmrk/screens/tabs/category_tab.dart';
import 'package:bookmrk/screens/tabs/help_tab.dart';
import 'package:bookmrk/screens/tabs/home.dart';
import 'package:bookmrk/screens/tabs/notificationPage.dart';
import 'package:bookmrk/screens/tabs/school_tab.dart';
import 'package:bookmrk/screens/tabs/user.dart';
import 'package:bookmrk/screens/user/change_mobilenumber.dart';
import 'package:bookmrk/screens/user/change_password.dart';
import 'package:bookmrk/screens/user/edit_profile.dart';
import 'package:bookmrk/screens/user/feedback.dart';
import 'package:bookmrk/screens/user/my_address.dart';
import 'package:bookmrk/screens/user/my_orders.dart';
import 'package:bookmrk/screens/user/new_password.dart';
import 'package:bookmrk/screens/user/order_details.dart';
import 'package:bookmrk/screens/user/order_status.dart';
import 'package:bookmrk/screens/user/order_traking.dart';
import 'package:bookmrk/screens/user/user_add_address.dart';
import 'package:bookmrk/screens/user/user_edit_address.dart';
import 'package:bookmrk/screens/user/user_otp.dart';
import 'package:bookmrk/screens/user/wishlist.dart';
import 'package:bookmrk/widgets/appBar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'Home/filter_category_brand.dart';
import 'category/categoryInfo.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // PageController pageController = PageController(initialPage: 0);
  ColorPalette colorPalette = ColorPalette();
  ImagePath imagePath = ImagePath();
  HomeScreenProvider _setHomeScreenProvider;

  /// get data for home page..
  Future<HomePageModel> getHomePageDetails() async {
    // print("IS HOME DETAILS CALL");
    dynamic data = await HomePageApi.getHomePageDetails();
    HomePageModel _homePageDetails = HomePageModel.fromJson(data);
    return _homePageDetails;
  }

  notificationAction() {
    FirebaseMessaging().requestNotificationPermissions();

    FirebaseMessaging().configure(onLaunch: (value) async {
      if (value['data']['open_page'] == "user") {
        try {
          Provider
              .of<HomeScreenProvider>(context, listen: false)
              .pageController
              .jumpToPage(3);
          Provider
              .of<HomeScreenProvider>(context, listen: false)
              .selectedBottomIndex =
          3;
          Provider
              .of<HomeScreenProvider>(context, listen: false)
              .selectedString =
          "Help";
          // "User";
          Provider
              .of<HomeScreenProvider>(context, listen: false)
              .blueCartIcon =
          false;
          Provider
              .of<HomeScreenProvider>(context, listen: false)
              .blueBellIcon =
          false;
        } catch (e) {
          print(e);
        }
      }
      else if (value['data']['open_page'] == "order_details") {
        try {
          Provider
              .of<HomeScreenProvider>(context, listen: false)
              .pageController
              .jumpToPage(3);
          Provider
              .of<OrderProvider>(context,
              listen: false)
              .orderId =
          "${value['data']['detail_id']}";


          Provider
              .of<HomeScreenProvider>(context,
              listen: false)
              .selectedString =
          "OrderDetails";
          Provider
              .of<HomeScreenProvider>(context, listen: false)
              .selectedBottomIndex =
          3;
        } catch (e) {
          print(e);
        }
      } else if (value['data']['open_page'] == "cart") {
        try {
          Provider
              .of<HomeScreenProvider>(context, listen: false)
              .pageController
              .jumpToPage(4);

          Provider
              .of<HomeScreenProvider>(context, listen: false)
              .selectedString = "Cart";
          Provider
              .of<HomeScreenProvider>(context, listen: false)
              .selectedBottomIndex = 4;
          Provider
              .of<HomeScreenProvider>(context, listen: false)
              .blueCartIcon = true;
          Provider
              .of<HomeScreenProvider>(context, listen: false)
              .blueBellIcon = false;
        } catch (e) {
          print(e);
        }
      } else if (value['data']['open_page'] == "order") {
        /// redirect to order page....
        try {
          Provider
              .of<HomeScreenProvider>(context, listen: false)
              .pageController
              .jumpToPage(3);

          Provider
              .of<HomeScreenProvider>(context, listen: false)
              .selectedBottomIndex = 3;

          Provider
              .of<HomeScreenProvider>(context, listen: false)
              .selectedString = "MyOrders";
        } catch (e) {
          print(e);
        }
      } else if (value['data']['open_page'] == "home") {
        /// redirect to home page from notification....
        try {
          Provider
              .of<HomeScreenProvider>(context, listen: false)
              .pageController
              .jumpToPage(0);

          Provider
              .of<HomeScreenProvider>(context, listen: false)
              .selectedBottomIndex = 0;

          Provider
              .of<HomeScreenProvider>(context, listen: false)
              .selectedString = "Home";
        } catch (e) {
          print(e);
        }
      }
    },

        onMessage: (value) async {
          if (value['data']['open_page'] == "user") {
            try {
              Provider
                  .of<HomeScreenProvider>(context, listen: false)
                  .pageController
                  .jumpToPage(3);
              Provider
                  .of<HomeScreenProvider>(context, listen: false)
                  .selectedBottomIndex =
              3;
              Provider
                  .of<HomeScreenProvider>(context, listen: false)
                  .selectedString =
              "Help";
              // "User";
              Provider
                  .of<HomeScreenProvider>(context, listen: false)
                  .blueCartIcon =
              false;
              Provider
                  .of<HomeScreenProvider>(context, listen: false)
                  .blueBellIcon =
              false;
            } catch (e) {
              print(e);
            }
          }
          else if (value['data']['open_page'] == "order_details") {
            try {
              Provider
                  .of<HomeScreenProvider>(context, listen: false)
                  .pageController
                  .jumpToPage(3);
              Provider
                  .of<OrderProvider>(context,
                  listen: false)
                  .orderId =
              "${value['data']['detail_id']}";


              Provider
                  .of<HomeScreenProvider>(context,
                  listen: false)
                  .selectedString =
              "OrderDetails";
              Provider
                  .of<HomeScreenProvider>(context, listen: false)
                  .selectedBottomIndex =
              3;
            } catch (e) {
              print(e);
            }
          } else if (value['data']['open_page'] == "cart") {
            try {
              Provider
                  .of<HomeScreenProvider>(context, listen: false)
                  .pageController
                  .jumpToPage(4);

              Provider
                  .of<HomeScreenProvider>(context, listen: false)
                  .selectedString = "Cart";
              Provider
                  .of<HomeScreenProvider>(context, listen: false)
                  .selectedBottomIndex = 4;
              Provider
                  .of<HomeScreenProvider>(context, listen: false)
                  .blueCartIcon = true;
              Provider
                  .of<HomeScreenProvider>(context, listen: false)
                  .blueBellIcon = false;
            } catch (e) {
              print(e);
            }
          } else if (value['data']['open_page'] == "order") {
            /// redirect to order page....
            try {
              Provider
                  .of<HomeScreenProvider>(context, listen: false)
                  .pageController
                  .jumpToPage(3);

              Provider
                  .of<HomeScreenProvider>(context, listen: false)
                  .selectedBottomIndex = 3;

              Provider
                  .of<HomeScreenProvider>(context, listen: false)
                  .selectedString = "MyOrders";
            } catch (e) {
              print(e);
            }
          } else if (value['data']['open_page'] == "home") {
            /// redirect to home page from notification....
            try {
              Provider
                  .of<HomeScreenProvider>(context, listen: false)
                  .pageController
                  .jumpToPage(0);

              Provider
                  .of<HomeScreenProvider>(context, listen: false)
                  .selectedBottomIndex = 0;

              Provider
                  .of<HomeScreenProvider>(context, listen: false)
                  .selectedString = "Home";
            } catch (e) {
              print(e);
            }
          }
        },

        onResume: (value) async {
          if (value['data']['open_page'] == "user") {
            try {
              Provider
                  .of<HomeScreenProvider>(context, listen: false)
                  .pageController
                  .jumpToPage(3);
              Provider
                  .of<HomeScreenProvider>(context, listen: false)
                  .selectedBottomIndex =
              3;
              Provider
                  .of<HomeScreenProvider>(context, listen: false)
                  .selectedString =
              "Help";
              // "User";
              Provider
                  .of<HomeScreenProvider>(context, listen: false)
                  .blueCartIcon =
              false;
              Provider
                  .of<HomeScreenProvider>(context, listen: false)
                  .blueBellIcon =
              false;
            } catch (e) {
              print(e);
            }
          } else if (value['data']['open_page'] == "order_details") {
            try {
              Provider
                  .of<HomeScreenProvider>(context, listen: false)
                  .pageController
                  .jumpToPage(3);
              Provider
                  .of<OrderProvider>(context,
                  listen: false)
                  .orderId =
              "${value['data']['detail_id']}";


              Provider
                  .of<HomeScreenProvider>(context,
                  listen: false)
                  .selectedString =
              "OrderDetails";
              Provider
                  .of<HomeScreenProvider>(context, listen: false)
                  .selectedBottomIndex =
              3;
            } catch (e) {
              print(e);
            }
          } else if (value['data']['open_page'] == "cart") {
            try {
              Provider
                  .of<HomeScreenProvider>(context, listen: false)
                  .pageController
                  .jumpToPage(4);

              Provider
                  .of<HomeScreenProvider>(context, listen: false)
                  .selectedString = "Cart";
              Provider
                  .of<HomeScreenProvider>(context, listen: false)
                  .selectedBottomIndex = 4;
              Provider
                  .of<HomeScreenProvider>(context, listen: false)
                  .blueCartIcon = true;
              Provider
                  .of<HomeScreenProvider>(context, listen: false)
                  .blueBellIcon = false;
            } catch (e) {
              print(e);
            }
          } else if (value['data']['open_page'] == "order") {
            /// redirect to order page....
            try {
              Provider
                  .of<HomeScreenProvider>(context, listen: false)
                  .pageController
                  .jumpToPage(3);

              Provider
                  .of<HomeScreenProvider>(context, listen: false)
                  .selectedBottomIndex = 3;

              Provider
                  .of<HomeScreenProvider>(context, listen: false)
                  .selectedString = "MyOrders";
            } catch (e) {
              print(e);
            }
          } else if (value['data']['open_page'] == "home") {
            /// redirect to home page from notification....
            try {
              Provider
                  .of<HomeScreenProvider>(context, listen: false)
                  .pageController
                  .jumpToPage(0);

              Provider
                  .of<HomeScreenProvider>(context, listen: false)
                  .selectedBottomIndex = 0;

              Provider
                  .of<HomeScreenProvider>(context, listen: false)
                  .selectedString = "Home";
            } catch (e) {
              print(e);
            }
          }
        });
  }

  @override
  void initState() {
    print("Home Screen InitState");
    super.initState();
    notificationAction();
  }


  @override
  Widget build(BuildContext context) {
    _setHomeScreenProvider =
        Provider.of<HomeScreenProvider>(context, listen: false);


    var height = MediaQuery
        .of(context)
        .size
        .height;
    var width = MediaQuery
        .of(context)
        .size
        .width;
    return Consumer<HomeScreenProvider>(
      builder: (context, _homeScreenProvider, child) {
        return FutureBuilder(
          future: getHomePageDetails(),
          builder: (context, snapshot) {
            var s = Provider
                .of<HomeScreenProvider>(context,
                listen: false)
                .selectedString;
            // print("SELECTED SCREEN NAME ---> $s");
            if (snapshot.hasData) {
              // appScreen
              if (snapshot.data.response[0].maintenanceScreen != null &&
                  snapshot.data.response[0].maintenanceScreen.length > 0) {
                if (snapshot.data.response[0].maintenanceScreen[0].show ==
                    "1") {
                  return AnnotatedRegion<SystemUiOverlayStyle>(
                    value: SystemUiOverlayStyle(
                        statusBarColor: Colors.black,
                        statusBarBrightness: Brightness.light
                    ),
                    child: Scaffold(appBar: MaintananceAppBar(
                        context, imagePath.logo
                    ),
                      resizeToAvoidBottomPadding: true,
                      body: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: Container(
                              child: SvgPicture.asset(
                                'assets/icons/maintanance.svg',
                                height: 150.0,
                              ),
                            ),
                          ),
                          SizedBox(height: 30.0),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15),
                            child: Text(
                              '${snapshot.data.response[0]
                                  .maintenanceScreen[0]
                                  .message == "" || snapshot.data.response[0]
                                  .maintenanceScreen[0]
                                  .message == null
                                  ? "Application under maintenance !"
                                  : snapshot.data.response[0]
                                  .maintenanceScreen[0]
                                  .message}',
                              style: TextStyle(
                                color: colorPalette.navyBlue,
                                fontSize: 18.0,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                else {
                  return Stack(
                    children: [
                      WillPopScope(
                        onWillPop: () async {
                          if (_homeScreenProvider.selectedString == "Home") {
                            showDialog(
                              context: context,

                              builder: (context) =>
                                  LogOutDialog(
                                    width: width,
                                    title: 'Are you sure you want to exit ?',
                                    onCancelTap: () {
                                      Navigator.pop(context);
                                    },
                                    onYesTap: () async {
                                      Navigator.pop(context);
                                      SystemNavigator.pop();
                                    },
                                  ),
                            );
                          }

                          else if (_homeScreenProvider.selectedString ==
                              "Category") {
                            _homeScreenProvider.selectedString = "Home";
                            _homeScreenProvider.selectedBottomIndex = 0;
                            _homeScreenProvider.pageController.jumpToPage(0);
                          } else if (_homeScreenProvider.selectedString ==
                              "School") {
                            _homeScreenProvider.selectedString = "Home";
                            _homeScreenProvider.selectedBottomIndex = 0;
                            _homeScreenProvider.pageController.jumpToPage(0);
                          } else
                            // if (_homeScreenProvider.selectedString == "User") {
                          if (_homeScreenProvider.selectedString == "Help") {
                            _homeScreenProvider.selectedString = "Home";
                            _homeScreenProvider.selectedBottomIndex = 0;
                            _homeScreenProvider.pageController.jumpToPage(0);
                          } else if (_homeScreenProvider.selectedString ==
                              "Notifications") {
                            _homeScreenProvider.selectedString = "Home";
                            _homeScreenProvider.selectedBottomIndex = 0;
                            _homeScreenProvider.pageController.jumpToPage(0);
                          } else if (_homeScreenProvider.selectedString ==
                              "Cart") {
                            _homeScreenProvider.selectedString = "Home";
                            _homeScreenProvider.selectedBottomIndex = 0;
                            _homeScreenProvider.pageController.jumpToPage(0);
                          }

                          /// check when home page is selected......
                          _homeScreenProvider.selectedBottomIndex == 0 &&
                              _homeScreenProvider.selectedString == "Home"
                              ? imagePath.logo
                              : _homeScreenProvider.selectedBottomIndex == 0
                              ? _setHomeScreenProvider.selectedString =
                          _homeScreenProvider.selectedString == "VendorInfo"
                              ? "Home"
                              : _homeScreenProvider.selectedString ==
                              "ProductInfo"
                              ? "Home" : _homeScreenProvider.selectedString ==
                              "DrawerProductInfo"
                              ? "FilterP" : _homeScreenProvider
                              .selectedString ==
                              "School" ? "FilterB" : _homeScreenProvider
                              .selectedString ==
                              "School"
                              ? "School"
                              : _homeScreenProvider.selectedString ==
                              "FilterS"
                              ? "AllSubjects" : _homeScreenProvider
                              .selectedString ==
                              "FilterP"
                              ? "AllPublishers" : _homeScreenProvider
                              .selectedString ==
                              "FilterB"
                              ? "Brand" :
                          _homeScreenProvider.selectedString ==
                              "SubCategoryInfo"
                              ? "CategoryInfo" : _homeScreenProvider
                              .selectedString ==
                              "ProductInfoSearch1"
                              ? "SearchProducts" : _homeScreenProvider
                              .selectedString ==
                              "ProductInfoWish"
                              ? "Wishlist"
                              : _homeScreenProvider
                              .selectedString ==
                              "OrderTrackingStatus" ? "OrderDetails" : "Home"


                          /// check when category page is selected......
                              : _homeScreenProvider.selectedBottomIndex ==
                              1 &&
                              (_homeScreenProvider.selectedString ==
                                  "Category" ||
                                  _homeScreenProvider.selectedString ==
                                      "CategoryInfo" || _homeScreenProvider
                                  .selectedString ==
                                  "SubCategoryInfo" ||
                                  _homeScreenProvider.selectedString ==
                                      "ProductInfo" ||
                                  _homeScreenProvider.selectedString ==
                                      "ProductInfoSearch2" ||
                                  _homeScreenProvider.selectedString ==
                                      "SearchProducts2" ||
                                  _homeScreenProvider.selectedString ==
                                      "SearchProducts" ||
                                  _homeScreenProvider.selectedString ==
                                      "MyOrders" ||
                                  _homeScreenProvider.selectedString ==
                                      "ProductInfoWish" ||
                                  _homeScreenProvider.selectedString ==
                                      "Wishlist" ||
                                  _homeScreenProvider.selectedString ==
                                      "ProductInfoSearch1")
                              ? _setHomeScreenProvider.selectedString =
                          _homeScreenProvider.selectedString == "CategoryInfo"
                              ? "Category"
                              : _homeScreenProvider.selectedString ==
                              "SubCategoryInfo"
                              ? "CategoryInfo"
                              : _homeScreenProvider.selectedString ==
                              "ProductInfoSearch2"
                              ? "SearchProducts2" : _homeScreenProvider
                              .selectedString ==
                              "ProductInfo"
                              ? "SubCategoryInfo" : _homeScreenProvider
                              .selectedString ==
                              "OrderDetails"
                              ? "MyOrders" : _homeScreenProvider
                              .selectedString ==
                              "MyOrders"
                              ? "Category" : _homeScreenProvider
                              .selectedString ==
                              "ProductInfoWish"
                              ? "Wishlist"
                              : _homeScreenProvider.selectedString ==
                              "ProductInfoSearch1"
                              ? "SearchProducts"
                              : _homeScreenProvider
                              .selectedString ==
                              "OrderTrackingStatus" ? "OrderDetails" :"Category"

                          /// check when school page is selected.......
                              : _homeScreenProvider.selectedBottomIndex ==
                              2 &&
                              (_homeScreenProvider.selectedString ==
                                  "ProductInfo" ||
                                  _homeScreenProvider.selectedString ==
                                      "School" ||
                                  _homeScreenProvider.selectedString ==
                                      "OrderDetails" ||
                                  _homeScreenProvider.selectedString ==
                                      "SchoolInfo" ||
                                  _homeScreenProvider.selectedString ==
                                      "MyOrders" ||
                                  _homeScreenProvider.selectedString ==
                                      "ProductInfoWish" ||
                                  _homeScreenProvider.selectedString ==
                                      "Wishlist" ||
                                  _homeScreenProvider.selectedString ==
                                      "ProductInfoSearch1" ||
                                  _homeScreenProvider.selectedString ==
                                      "SearchProducts"
                              )
                              ? _setHomeScreenProvider.selectedString =
                          _homeScreenProvider.selectedString ==
                              "SchoolInfo"
                              ? "School"
                              : _homeScreenProvider.selectedString ==
                              "ProductInfo"
                              ? "SchoolInfo"
                              : _homeScreenProvider.selectedString ==
                              "OrderDetails"
                              ? "MyOrders" : _homeScreenProvider
                              .selectedString ==
                              "MyOrders"
                              ? "School"
                              : _homeScreenProvider.selectedString ==
                              "ProductInfoWish"
                              ? "Wishlist" : _homeScreenProvider
                              .selectedString ==
                              "ProductInfoSearch1"
                              ? "SearchProducts"
                              : _homeScreenProvider
                              .selectedString ==
                              "OrderTrackingStatus" ? "OrderDetails" :"School"

                          /// check when user is selected........
                              : _homeScreenProvider.selectedBottomIndex ==
                              3 ||
                              (_homeScreenProvider.selectedString == "Help" ||
                                  _homeScreenProvider.selectedString ==
                                      "EditProfile" ||
                                  _homeScreenProvider.selectedString ==
                                      "ChangeMobile" ||
                                  _homeScreenProvider.selectedString ==
                                      "UserOTP" ||
                                  _homeScreenProvider.selectedString ==
                                      "Wishlist" ||
                                  _homeScreenProvider.selectedString ==
                                      "MyAddress" ||
                                  _homeScreenProvider.selectedString ==
                                      "MyOrders" ||
                                  _homeScreenProvider.selectedString ==
                                      "OrderDetails" ||
                                  _homeScreenProvider.selectedString ==
                                      "OrderTracking" ||
                                  _homeScreenProvider.selectedString ==
                                      "OrderTrackingStatus" ||
                                  _homeScreenProvider.selectedString ==
                                      "ChangePassword" ||
                                  _homeScreenProvider.selectedString ==
                                      "NewPassword" ||
                                  _homeScreenProvider.selectedString ==
                                      "FeedBack"
                                  || _homeScreenProvider.selectedString ==
                                      "ProductInfo" ||
                                  _homeScreenProvider.selectedString ==
                                      "MyOrders" ||
                                  _homeScreenProvider.selectedString ==
                                      "MyOrders" ||
                                  _homeScreenProvider.selectedString ==
                                      "ProductInfoSearch1" ||
                                  _homeScreenProvider.selectedString ==
                                      "SearchProducts")
                              ? _setHomeScreenProvider.selectedString =
                          _homeScreenProvider
                              .selectedString ==
                              "EditProfile"
                              ? "User"
                              : _homeScreenProvider
                              .selectedString ==
                              "ChangeMobile"
                              ? "EditProfile"
                              : _homeScreenProvider.selectedString ==
                              "UserOTP"
                              ? "ChangeMobile"
                              : _homeScreenProvider.selectedString ==
                              "ProductInfoWish" ? "Wishlist" :
                          _homeScreenProvider.selectedString ==
                              "MyAddress" ||
                              _homeScreenProvider.selectedString ==
                                  "MyOrders" ||
                              _homeScreenProvider.selectedString ==
                                  "ChangePassword" ||
                              _homeScreenProvider.selectedString ==
                                  "FeedBack"
                              ? "Help"
                              : _homeScreenProvider.selectedString ==
                              "OrderDetails"
                              ? "MyOrders"
                              : _homeScreenProvider.selectedString ==
                              "NewPassword"
                              ? "ChangePassword"
                              : _homeScreenProvider.selectedString ==
                              "ProductInfo"
                              ? "Wishlist"
                              : _homeScreenProvider.selectedString ==
                              "ProductInfoSearch1"
                              ? "SearchProducts" :_homeScreenProvider
                              .selectedString ==
                              "OrderTrackingStatus" ? "OrderDetails" : "Help" : "Help";

                          /// ============================================================
                          return false;
                        },

                        child: Scaffold(
                          drawer: SafeArea(child: Drawer(child: User(),)),
                          resizeToAvoidBottomInset: false,
                          drawerEdgeDragWidth: Get.width / 1.5,
                          drawerEnableOpenDragGesture: false,
                          appBar: _homeScreenProvider.selectedString ==
                              "ChangeAddress" ||
                              _homeScreenProvider.selectedString ==
                                  "AddAddress" ||
                              _homeScreenProvider.selectedString ==
                                  "EditAddress" ||
                              _homeScreenProvider.selectedString ==
                                  "SearchProducts" ||
                              _homeScreenProvider.selectedString ==
                                  "SearchProducts2" ||
                              _homeScreenProvider.selectedString ==
                                  "Filter" ||
                              _homeScreenProvider.selectedString ==
                                  "UserEditAddress" ||
                              _homeScreenProvider.selectedString ==
                                  "UserAddAddress" ||
                              _homeScreenProvider.selectedString ==
                                  "OrderTracking" ||
                              _homeScreenProvider.selectedString ==
                                  "OrderTrackingStatus"
                              ? SimpleAppBar(
                              actionIcon: _homeScreenProvider
                                  .selectedString ==
                                  "AddAddress" ||
                                  _homeScreenProvider.selectedString ==
                                      "EditAddress" ||
                                  _homeScreenProvider.selectedString ==
                                      "SearchProducts" ||
                                  _homeScreenProvider.selectedString ==
                                      "SearchProducts2" ||
                                  _homeScreenProvider.selectedString ==
                                      "Filter" ||
                                  _homeScreenProvider.selectedString ==
                                      "UserEditAddress" ||
                                  _homeScreenProvider.selectedString ==
                                      "UserAddAddress" ||
                                  _homeScreenProvider.selectedString ==
                                      "OrderTracking" ||
                                  _homeScreenProvider.selectedString ==
                                      "OrderTrackingStatus"
                                  ? null
                                  : Icons.add,
                              actionTap: () {
                                _setHomeScreenProvider.selectedString =
                                _homeScreenProvider.selectedString ==
                                    "ChangeAddress"
                                    ? "AddAddress"
                                    : "Cart";
                              },
                              context: context,
                              onTap: () {
                                print("SELECTED INDEX ${_homeScreenProvider
                                    .selectedBottomIndex}");
                                print("SELECTED STRING ${_homeScreenProvider
                                    .selectedString}");
                                if (_homeScreenProvider.oldSelectedIndex !=
                                    null) {
                                  _homeScreenProvider.selectedBottomIndex =
                                      _homeScreenProvider.oldSelectedIndex;
                                  _homeScreenProvider.oldSelectedIndex = null;
                                  _setHomeScreenProvider.blueCartIcon = false;
                                  _setHomeScreenProvider.blueBellIcon = false;
                                }
                                print(
                                    "SELECTED STRING 2 before${_homeScreenProvider
                                        .selectedString}");
                                print("SELECTED INDEX 2${_homeScreenProvider
                                    .selectedBottomIndex}");
                                _setHomeScreenProvider.selectedString =
                                _homeScreenProvider.selectedString ==
                                    "AddAddress"
                                    ? "ChangeAddress" //dk..
                                    : _homeScreenProvider.selectedString ==
                                    "EditAddress"
                                    ? "ChangeAddress"
                                    : _homeScreenProvider.selectedString ==
                                    "SearchProducts" &&
                                    _homeScreenProvider.selectedBottomIndex ==
                                        0
                                    ? "Home" : _homeScreenProvider
                                    .selectedString ==
                                    "ChangeAddress" &&
                                    _homeScreenProvider.selectedBottomIndex ==
                                        0 ? "Home" : _homeScreenProvider
                                    .selectedString ==
                                    "SearchProducts" &&
                                    _homeScreenProvider.selectedBottomIndex ==
                                        1
                                    ? "Category" : _homeScreenProvider
                                    .selectedString ==
                                    "ChangeAddress" &&
                                    _homeScreenProvider.selectedBottomIndex ==
                                        1 ? "Category" :
                                _homeScreenProvider.selectedString ==
                                    "SearchProducts" &&
                                    _homeScreenProvider.selectedBottomIndex ==
                                        2
                                    ? "School" : _homeScreenProvider
                                    .selectedString ==
                                    "ChangeAddress" &&
                                    _homeScreenProvider.selectedBottomIndex ==
                                        2 ? "School" :
                                _homeScreenProvider.selectedString ==
                                    "SearchProducts" &&
                                    _homeScreenProvider.selectedBottomIndex ==
                                        3
                                    ? "Help"
                                    : _homeScreenProvider.selectedString ==
                                    "Filter"
                                    ? "VendorInfo"
                                    : _homeScreenProvider.selectedString ==
                                    "UserEditAddress" ||
                                    _homeScreenProvider.selectedString ==
                                        "UserAddAddress"
                                    ? "MyAddress"
                                    : _homeScreenProvider.selectedString ==
                                    "OrderTracking"
                                    ? "OrderDetails" : _homeScreenProvider
                                    .selectedString ==
                                    "OrderTrackingStatus"
                                    ? "OrderDetails"
                                    : _homeScreenProvider.selectedString ==
                                    "SearchProducts2"
                                    ? "Category" : _homeScreenProvider
                                    .selectedString ==
                                    "ChangeAddress" &&
                                    _homeScreenProvider.selectedBottomIndex ==
                                        3 ? "Help" :
                                "Cart";
                                print("SELECTED STRING 2 ${_homeScreenProvider
                                    .selectedString}");
                                print(
                                    "SELECTED STRING SE HOME 2 ${_setHomeScreenProvider
                                        .selectedString}");
                              },
                              title: _homeScreenProvider.selectedString ==
                                  "SearchProducts"
                                  ? "Search Products"
                                  : _homeScreenProvider.selectedString ==
                                  "SearchProducts2" ?
                              "Search Products"
                                  : _homeScreenProvider.selectedString ==
                                  "SearchProducts2" ?
                              "Search Products" : _homeScreenProvider
                                  .selectedString ==
                                  "Filter"
                                  ? "Filter By Categories"
                                  : _homeScreenProvider.selectedString ==
                                  "UserEditAddress"
                                  ? "Edit Address"
                                  : _homeScreenProvider.selectedString ==
                                  "UserAddAddress"
                                  ? "Add Address"
                                  : _homeScreenProvider.selectedString ==
                                  "OrderTracking"
                                  ? "Order Tracking" : _homeScreenProvider
                                  .selectedString ==
                                  "OrderTrackingStatus"
                                  ? " Order Cancel  Status"
                                  : _homeScreenProvider.selectedString ==
                                  "OrderTrackingStatus"
                                  ? "OrderTrackingStatus"
                                  : _homeScreenProvider.selectedString ==
                                  "ChangeAddress"
                                  ? "Change Address"
                                  : _homeScreenProvider.selectedString ==
                                  "AddAddress"
                                  ? "Add Address"
                                  : _homeScreenProvider.selectedString ==
                                  "OrderDetails"
                                  ? "Order Details"
                                  : _homeScreenProvider.selectedString ==
                                  "Help" ? "Help" : _homeScreenProvider
                                  .selectedString ==
                                  "EditAddress" ? "Edit Address" : "",
                              icon: Icons.close)
                              : _homeScreenProvider.selectedString ==
                              "VendorInfo"
                              ?
                          PreferredSize(
                              child: Container(),
                              preferredSize: Size(0.0, 0.0))
                              : CustomAppBar(
                            _homeScreenProvider.selectedString,
                            context,
                            blueCartIcon: _homeScreenProvider.blueCartIcon,
                            blueBellIcon: _homeScreenProvider.blueBellIcon,
                            onBellTap: () {
                              _homeScreenProvider.pageController.jumpToPage(
                                  4);
                              if (_setHomeScreenProvider
                                  .selectedBottomIndex != 4)
                                _homeScreenProvider.oldSelectedIndex =
                                    _setHomeScreenProvider
                                        .selectedBottomIndex;
                              _setHomeScreenProvider.selectedString =
                              "Notifications";
                              _setHomeScreenProvider.selectedBottomIndex = 4;
                              _setHomeScreenProvider.blueCartIcon = false;
                              _setHomeScreenProvider.blueBellIcon = true;
                            },
                            onCartTap: () {
                              _homeScreenProvider.pageController.jumpToPage(
                                  4);
                              if (_setHomeScreenProvider
                                  .selectedBottomIndex != 4)
                                _homeScreenProvider.oldSelectedIndex =
                                    _setHomeScreenProvider
                                        .selectedBottomIndex;
                              _setHomeScreenProvider.selectedString = "Cart";
                              _setHomeScreenProvider.selectedBottomIndex = 4;
                              _setHomeScreenProvider.blueCartIcon = true;
                              _setHomeScreenProvider.blueBellIcon = false;
                            },
                            whiteIcon: _homeScreenProvider.selectedString ==
                                "VendorInfo" ? true : false,
                            color: _homeScreenProvider.selectedString ==
                                "VendorInfo"
                                ? colorPalette.purple
                                : Colors.white,
                            width: width,
                            imagePath: imagePath,
                            colorPalette: colorPalette,
                            child: Container(

                              // height: width / 6,
                              // width: width / 2.5,
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.symmetric(horizontal: 0),

                              /// home page appbar...
                              child: _homeScreenProvider
                                  .selectedBottomIndex ==
                                  0 &&
                                  _homeScreenProvider.selectedString == "Home"
                                  ? Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30),
                                child: imagePath.logo,
                              )
                                  : _homeScreenProvider.selectedBottomIndex ==
                                  0
                                  ? Row(
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      Icons.arrow_back_ios,
                                      color: _homeScreenProvider
                                          .selectedString ==
                                          "VendorInfo"
                                          ? Colors.white
                                          : colorPalette.navyBlue,

                                    ),
                                    onPressed: () {
                                      _setHomeScreenProvider.selectedString =
                                      _homeScreenProvider.selectedString ==
                                          "VendorInfo"
                                          ? "All Vendors"
                                          : _homeScreenProvider
                                          .selectedString ==
                                          "ProductInfo"
                                          ? "Home" : _homeScreenProvider
                                          .selectedString ==
                                          "DrawerProductInfo"
                                          ? "FilterP"
                                          : _homeScreenProvider
                                          .selectedString ==
                                          "FilterS"
                                          ? "AllSubjects"
                                          : _homeScreenProvider
                                          .selectedString ==
                                          "FilterB"
                                          ? "Brand" : _homeScreenProvider
                                          .selectedString ==
                                          "FilterP"
                                          ? "AllPublishers" :
                                      _homeScreenProvider.selectedString ==
                                          "SubCategoryInfo"
                                          ? "CategoryInfo"
                                          : _homeScreenProvider
                                          .selectedString ==
                                          "ProductInfoSearch1"
                                          ? "SearchProducts"
                                          : _homeScreenProvider
                                          .selectedString ==
                                          "ProductInfoWish"
                                          ? "Wishlist"
                                          : "Home";
                                    },
                                    iconSize: 30,
                                  ),
                                  Container(
                                    width: width / 2.6,
                                    child: Text(

                                      _homeScreenProvider.selectedString ==
                                          "VendorInfo"
                                          ? ""
                                          : _homeScreenProvider
                                          .selectedString ==
                                          "ProductInfo" || _homeScreenProvider
                                          .selectedString ==
                                          "ProductInfoSearch1"
                                          ? "${_homeScreenProvider
                                          .selectedTitle}" :
                                      _homeScreenProvider
                                          .selectedString ==
                                          "DrawerProductInfo"
                                          ? "${_homeScreenProvider
                                          .drawerSelectedTitle}"
                                          : _homeScreenProvider
                                          .selectedString ==
                                          "School"
                                          ? "School"
                                          :
                                      _homeScreenProvider.selectedString ==
                                          "SchoolInfo"
                                          ? "${_homeScreenProvider
                                          .selectedTitle}"
                                          : _homeScreenProvider
                                          .selectedString ==
                                          "AllSubjects"
                                          ? "All Subjects"
                                          : _homeScreenProvider
                                          .selectedString ==
                                          "CategoryInfo"
                                          ? "${_homeScreenProvider
                                          .selectedTitle}"
                                          : _homeScreenProvider
                                          .selectedString ==
                                          "SubCategoryInfo"
                                          ? "SubCategory"
                                          : _homeScreenProvider
                                          .selectedString ==
                                          "AllPublishers"
                                          ? "All Publishers"
                                          : _homeScreenProvider
                                          .selectedString ==
                                          "Brand"
                                          ? "Brand"
                                          : _homeScreenProvider
                                          .selectedString ==
                                          "FilterS"
                                          ? "${_homeScreenProvider
                                          .selectedTitle}"
                                          : _homeScreenProvider
                                          .selectedString ==
                                          "FilterP"
                                          ? "${_homeScreenProvider
                                          .selectedTitle}"
                                          : _homeScreenProvider
                                          .selectedString ==
                                          "FilterB"
                                          ? "${_homeScreenProvider
                                          .selectedTitle}"
                                          : _homeScreenProvider
                                          .selectedString ==
                                          "FilterC"
                                          ? "${_homeScreenProvider
                                          .selectedTitle}"
                                          : _homeScreenProvider
                                          .selectedString ==
                                          "MyAddress"
                                          ? "My Addresses"
                                          : _homeScreenProvider
                                          .selectedString ==
                                          "MyOrders"
                                          ? "My Orders"
                                          : _homeScreenProvider
                                          .selectedString ==
                                          "Wishlist"
                                          ? "Wishlist" : _homeScreenProvider
                                          .selectedString ==
                                          "FeedBack"
                                          ? "FeedBack" : _homeScreenProvider
                                          .selectedString ==
                                          "ChangePassword"
                                          ? "Change Password"
                                          : _homeScreenProvider
                                          .selectedString ==
                                          "EditProfile"
                                          ? "Edit Profile" :
                                      _homeScreenProvider
                                          .selectedString ==
                                          "ProductInfoWish"
                                          ? "${_homeScreenProvider
                                          .selectedTitle}"
                                          : _homeScreenProvider
                                          .selectedString ==
                                          "OrderDetails"
                                          ? 'MyOrders'
                                          : 'All Vendors',

                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xff301869),
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ],
                              )

                              /// category page appbar...
                                  : _homeScreenProvider.selectedBottomIndex ==
                                  1 &&
                                  (_homeScreenProvider.selectedString ==
                                      "Category" ||
                                      _homeScreenProvider.selectedString ==
                                          "CategoryInfo" ||
                                      _homeScreenProvider.selectedString ==
                                          "SubCategoryInfo" ||
                                      _homeScreenProvider.selectedString ==
                                          "ProductInfo" ||
                                      _homeScreenProvider.selectedString ==
                                          "ProductInfoSearch2" ||
                                      _homeScreenProvider.selectedString ==
                                          "MyAddress" ||
                                      _homeScreenProvider.selectedString ==
                                          "MyOrders" ||
                                      _homeScreenProvider.selectedString ==
                                          "Wishlist" ||
                                      _homeScreenProvider.selectedString ==
                                          "FeedBack" ||
                                      _homeScreenProvider.selectedString ==
                                          "ChangePassword" ||
                                      _homeScreenProvider.selectedString ==
                                          "EditProfile" || _homeScreenProvider
                                      .selectedString ==
                                      "ProductInfoWish" || _homeScreenProvider
                                      .selectedString ==
                                      "ProductInfoSearch1" ||
                                      _homeScreenProvider.selectedString ==
                                          "OrderDetails")
                                  ? leadingAppBar(
                                  title: _homeScreenProvider.selectedString ==
                                      "Category"
                                      ? "Category"
                                      : _homeScreenProvider.selectedString ==
                                      "CategoryInfo"
                                      ? "${ Provider
                                      .of<CategoryProvider>(
                                      context, listen: false)
                                      .selectedCategoryName}"
                                      : _homeScreenProvider.selectedString ==
                                      "SubCategoryInfo"
                                      ? "${Provider
                                      .of<CategoryProvider>(
                                      context, listen: false)
                                      .selectedCategoryName}"
                                      : _homeScreenProvider.selectedString ==
                                      "MyAddress"
                                      ? "My Addresses"
                                      : _homeScreenProvider.selectedString ==
                                      "MyOrders"
                                      ? "My Orders"
                                      : _homeScreenProvider.selectedString ==
                                      "Wishlist"
                                      ? "Wishlist" : _homeScreenProvider
                                      .selectedString ==
                                      "FeedBack"
                                      ? "FeedBack"
                                      : _homeScreenProvider
                                      .selectedString ==
                                      "ChangePassword"
                                      ? "Change Password"
                                      : _homeScreenProvider
                                      .selectedString ==
                                      "OrderDetails"
                                      ? "MyOrders" : _homeScreenProvider
                                      .selectedString ==
                                      "Brand"
                                      ? "Brand" : _homeScreenProvider
                                      .selectedString ==
                                      "EditProfile"
                                      ? "Edit Profile"
                                  // : "demo",
                                      : "${_homeScreenProvider
                                      .selectedTitle}",
                                  backButton:
                                  _homeScreenProvider.selectedString ==
                                      "Category"
                                      ? false
                                      : true,
                                  onBackTap: () {
                                    _setHomeScreenProvider.selectedString =
                                    _homeScreenProvider.selectedString ==
                                        "CategoryInfo"
                                        ? "Category"
                                        : _homeScreenProvider
                                        .selectedString ==
                                        "SubCategoryInfo"
                                        ? "CategoryInfo" : _homeScreenProvider
                                        .selectedString ==
                                        "ProductInfoSearch1"
                                        ? "SearchProducts"
                                        : _homeScreenProvider
                                        .selectedString ==
                                        "ProductInfo"
                                    // ? "Wishlist"
                                        ? "CategoryInfo"
                                        : _homeScreenProvider
                                        .selectedString ==
                                        "ProductInfoWish"
                                        ? "Wishlist"
                                        : _homeScreenProvider
                                        .selectedString ==
                                        "OrderDetails"
                                        ? "MyOrders" : "Category";
                                  })

                              /// school page appbar ....
                                  : _homeScreenProvider.selectedBottomIndex ==
                                  2 &&
                                  (_homeScreenProvider.selectedString ==
                                      "ProductInfo" ||
                                      _homeScreenProvider.selectedString ==
                                          "School" ||
                                      _homeScreenProvider.selectedString ==
                                          "SchoolInfo" ||
                                      _homeScreenProvider.selectedString ==
                                          "MyAddress" ||
                                      _homeScreenProvider.selectedString ==
                                          "MyOrders" ||
                                      _homeScreenProvider.selectedString ==
                                          "Wishlist" ||
                                      _homeScreenProvider.selectedString ==
                                          "FeedBack" ||
                                      _homeScreenProvider.selectedString ==
                                          "ChangePassword" ||
                                      _homeScreenProvider.selectedString ==
                                          "ProductInfoWish" ||
                                      _homeScreenProvider.selectedString ==
                                          "EditProfile" || _homeScreenProvider
                                      .selectedString ==
                                      "ProductInfoSearch1"
                                      ||
                                      _homeScreenProvider.selectedString ==
                                          "OrderDetails")
                                  ? leadingAppBar(
                                title: _homeScreenProvider.selectedString ==
                                    "School"
                                    ? "Schools" : _homeScreenProvider
                                    .selectedString ==
                                    "OrderDetails"
                                    ? "My Order"
                                    : _homeScreenProvider.selectedString ==
                                    "MyAddress"
                                    ? "My Addresses" : _homeScreenProvider
                                    .selectedString ==
                                    "MyOrders"
                                    ? "My Orders"
                                    : _homeScreenProvider.selectedString ==
                                    "Wishlist"
                                    ? "Wishlist" : _homeScreenProvider
                                    .selectedString ==
                                    "FeedBack"
                                    ? "FeedBack"
                                    : _homeScreenProvider
                                    .selectedString ==
                                    "ChangePassword"
                                    ? "Change Password"
                                    : _homeScreenProvider.selectedString ==
                                    "EditProfile"
                                    ? "Edit Profile" : _homeScreenProvider
                                    .selectedString ==
                                    "OrderDetails"
                                    ? "MyOrders" : _homeScreenProvider
                                    .selectedString ==
                                    "ProductInfoWish"
                                    ? "${_homeScreenProvider
                                    .selectedTitle}" : "${_homeScreenProvider
                                    .selectedTitle}",
                                backButton:
                                _homeScreenProvider.selectedString == "School"
                                    ? false
                                    : true,
                                onBackTap: () {
                                  _setHomeScreenProvider.selectedString =
                                  _homeScreenProvider.selectedString ==
                                      "SchoolInfo"
                                      ? "School"
                                      : _homeScreenProvider
                                      .selectedString ==
                                      "ProductInfoSearch1"
                                      ? "SearchProducts" : _homeScreenProvider
                                      .selectedString ==
                                      "ProductInfoWish"
                                      ? "Wishlist"
                                      : _homeScreenProvider.selectedString ==
                                      "OrderDetails"
                                      ? "MyOrders" : "School";
                                },
                              )


                              /// user page appbar...
                                  : _homeScreenProvider.selectedBottomIndex ==
                                  3 && (_homeScreenProvider.selectedString ==
                                  "User" ||
                                  _homeScreenProvider.selectedString ==
                                      "Help" ||
                                  _homeScreenProvider.selectedString ==
                                      "EditProfile" ||
                                  _homeScreenProvider.selectedString ==
                                      "ChangeMobile" ||
                                  _homeScreenProvider.selectedString ==
                                      "UserOTP" ||
                                  _homeScreenProvider.selectedString ==
                                      "Wishlist" ||
                                  _homeScreenProvider.selectedString ==
                                      "MyAddress" ||
                                  _homeScreenProvider.selectedString ==
                                      "MyOrders" ||
                                  _homeScreenProvider.selectedString ==
                                      "OrderDetails" ||
                                  _homeScreenProvider.selectedString ==
                                      "OrderTracking" ||
                                  _homeScreenProvider.selectedString ==
                                      "OrderTrackingStatus" ||
                                  _homeScreenProvider.selectedString ==
                                      "ChangePassword" ||
                                  _homeScreenProvider.selectedString ==
                                      "NewPassword" ||
                                  _homeScreenProvider.selectedString ==
                                      "FeedBack"
                                  || _homeScreenProvider.selectedString ==
                                      "ProductInfo" ||
                                  _homeScreenProvider.selectedString ==
                                      "ProductInfoWish" || _homeScreenProvider
                                  .selectedString ==
                                  "ProductInfoSearch1")
                                  ? leadingAppBar(
                                title: _homeScreenProvider.selectedString ==
                                    "Help"
                                    ? "Help"
                                    : _homeScreenProvider.selectedString ==
                                    "School"
                                    ? "School"
                                // ? "Account"
                                    : _homeScreenProvider.selectedString ==
                                    "EditProfile"
                                    ? "Edit Profile"
                                    : _homeScreenProvider.selectedString ==
                                    "ChangeMobile" ||
                                    _homeScreenProvider.selectedString ==
                                        "UserOTP"
                                    ? "Change Mobile Number"
                                    : _homeScreenProvider.selectedString ==
                                    "Wishlist"
                                    ? "Wishlist"
                                    : _homeScreenProvider.selectedString ==
                                    "MyAddress"
                                    ? "My Addresses"
                                    : _homeScreenProvider.selectedString ==
                                    "MyOrders" ||
                                    _homeScreenProvider.selectedString ==
                                        "OrderDetails"
                                    ? "My Orders"
                                    : _homeScreenProvider.selectedString ==
                                    "ChangePassword" ||
                                    _homeScreenProvider.selectedString ==
                                        "NewPassword"
                                    ? "Change Password"
                                    : _homeScreenProvider.selectedString ==
                                    "FeedBack"
                                    ? "Submit Feedback"
                                    : _homeScreenProvider.selectedString ==
                                    "ProductInfoWish"
                                    ? "${_homeScreenProvider
                                    .selectedTitle}"
                                    : "${_homeScreenProvider
                                    .selectedTitle}",
                                backButton:
                                // _homeScreenProvider.selectedString == "Help"
                                _homeScreenProvider.selectedString == "Help"
                                    ? false
                                    : true,
                                onBackTap: () {
                                  _setHomeScreenProvider.selectedString =
                                  _homeScreenProvider
                                      .selectedString ==
                                      "EditProfile"
                                      ? "Help"
                                      : _homeScreenProvider
                                      .selectedString ==
                                      "ChangeMobile"
                                      ? "EditProfile"
                                      : _homeScreenProvider.selectedString ==
                                      "UserOTP"
                                      ? "ChangeMobile"
                                      : _homeScreenProvider.selectedString ==
                                      "Wishlist" ||
                                      _homeScreenProvider.selectedString ==
                                          "MyAddress" ||
                                      _homeScreenProvider.selectedString ==
                                          "MyOrders" ||
                                      _homeScreenProvider.selectedString ==
                                          "ChangePassword" ||
                                      _homeScreenProvider.selectedString ==
                                          "FeedBack"
                                      ? "Help"
                                      : _homeScreenProvider.selectedString ==
                                      "OrderDetails"
                                      ? "MyOrders"
                                      : _homeScreenProvider.selectedString ==
                                      "NewPassword"
                                      ? "ChangePassword"
                                      : _homeScreenProvider.selectedString ==
                                      "ProductInfo"
                                      ? "Wishlist"
                                      : _homeScreenProvider
                                      .selectedString ==
                                      "ProductInfoSearch1"
                                      ? "SearchProducts" : _homeScreenProvider
                                      .selectedString ==
                                      "ProductInfoWish"
                                      ? "Wishlist" : "";
                                },
                              )

                              /// cart page appbar....
                                  : _homeScreenProvider.selectedString ==
                                  "Cart"
                                  ? leadingAppBar(
                                  backButton: false,
                                  title: "Cart")
                                  : leadingAppBar(
                                  backButton: false,
                                  title: "Notifications"),
                            ),
                          ),
                          extendBody: true,

                          /// BODY SECTION
                          body: Stack(
                            children: [
                              Container(
                                height: height,
                                child: PageView(
                                  controller: _homeScreenProvider
                                      .pageController,
                                  children: [


                                    /// HOME PAGE0
                                    _homeScreenProvider
                                        .selectedBottomIndex ==
                                        0 ?
                                    _homeScreenProvider.selectedString ==
                                        "Home"
                                        ? Home()
                                        : _homeScreenProvider
                                        .selectedString ==
                                        "ChangeAddress"
                                        ? ChangeAddress()
                                        : _homeScreenProvider
                                        .selectedString ==
                                        "SearchProducts"
                                        ? Search2()
                                        : _homeScreenProvider
                                        .selectedString ==
                                        "AllSubjects"
                                        ? Consumer<FilterCategoryProvider>(
                                        builder: (_,
                                            _filterCategoryProvider,
                                            child) =>
                                            AllSubjects(
                                            ))
                                        : _homeScreenProvider
                                        .selectedString ==
                                        "Brand"
                                        ? AllBrands()
                                        : _homeScreenProvider
                                        .selectedString ==
                                        "FilterS"
                                        ? Consumer<FilterCategoryProvider>(
                                        builder: (_,
                                            _filterCategoryProvider,
                                            child) =>
                                            FilterCategorySubject(
                                                _filterCategoryProvider
                                                    .selectedFilterCategorySubjectSlug))
                                        : _homeScreenProvider
                                        .selectedString ==
                                        "FilterC"
                                        ? Consumer<FilterCategoryProvider>(
                                        builder: (_,
                                            _filterCategoryProvider,
                                            child) =>
                                            FilterCategoryClass(
                                                _filterCategoryProvider
                                                    .selectedFilterCategoryClassSlug))
                                        : _homeScreenProvider
                                        .selectedString ==
                                        "FilterB"
                                        ? Consumer<FilterCategoryProvider>(
                                        builder: (_,
                                            _filterCategoryProvider,
                                            child) =>
                                            FilterCategoryBrand(
                                                _filterCategoryProvider
                                                    .selectedFilterCategoryBrandSlug))
                                        : _homeScreenProvider
                                        .selectedString ==
                                        "FilterP"
                                        ? Consumer<FilterCategoryProvider>(
                                        builder: (_,
                                            _filterCategoryProvider,
                                            child) =>
                                            FilterCategoryPublisher(
                                                _filterCategoryProvider
                                                    .selectedFilterCategoryPublisherSlug))
                                        : _homeScreenProvider
                                        .selectedString ==
                                        "AllPublishers"
                                        ? Consumer<FilterCategoryProvider>(
                                        builder: (_,
                                            _filterCategoryProvider,
                                            child) =>
                                            AllPublisher(
                                            ))
                                        : _homeScreenProvider
                                        .selectedString ==
                                        "VendorInfo"
                                        ? Consumer<VendorProvider>(
                                        builder: (_, _vendorProvider,
                                            child) =>
                                            VendorsInfo(
                                                vendorSlug: _vendorProvider
                                                    .selectedVendorName))
                                        : _homeScreenProvider
                                        .selectedString ==
                                        "ProductInfo"
                                        ? Consumer<HomeScreenProvider>(
                                        builder: (_, _homeScreenProvider,
                                            child) {
                                          print("ISPRODUCT CALL 1");
                                          return ProductInfo(
                                            selectedProductSlug: _homeScreenProvider
                                                .selectedProductSlug,);
                                        }
                                    )
                                        : _homeScreenProvider
                                        .selectedString ==
                                        "DrawerProductInfo"
                                        ? Consumer<HomeScreenProvider>(
                                        builder: (_, _homeScreenProvider,
                                            child) {
                                          // print("ISPRODUCT CALL 1");
                                          return ProductInfo(
                                            selectedProductSlug: _homeScreenProvider.selectedProductSlug,);
                                        }
                                    )
                                        : _homeScreenProvider
                                        .selectedString ==
                                        "SchoolInfo"
                                        ? Consumer<SchoolProvider>(
                                        builder: (_, _schoolProvider,
                                            child) =>
                                            SchoolInfo(
                                              schoolSlug: _schoolProvider
                                                  .selectedSchoolSlug,))
                                        : _homeScreenProvider
                                        .selectedString ==
                                        "Filter"
                                        ? Filter() : _homeScreenProvider
                                        .selectedString ==
                                        "AddAddress"
                                        ? AddAddress()
                                        : _homeScreenProvider
                                        .selectedString ==
                                        "School"
                                        ? SchoolTab()
                                        : _homeScreenProvider
                                        .selectedString ==
                                        "Wishlist"
                                        ? WishList() : _homeScreenProvider
                                        .selectedString ==
                                        "Category" &&
                                        _homeScreenProvider
                                            .selectedBottomIndex ==
                                            1

                                        ? CategoryTab()
                                        : _homeScreenProvider
                                        .selectedString ==
                                        "MyAddress"
                                        ? MyAddress() : _homeScreenProvider
                                        .selectedString ==
                                        "MyOrders"
                                        ? MyOrders() : _homeScreenProvider
                                        .selectedString ==
                                        "FeedBack"
                                        ? FeedBack() : _homeScreenProvider
                                        .selectedString ==
                                        "ChangePassword"
                                        ? Consumer<UserProvider>(
                                      builder: (_, _userProvider, child) =>
                                          ChangePassword(
                                            userMobileNumber: _userProvider
                                                .mobileNumberToSendOtp,),)
                                        : _homeScreenProvider
                                        .selectedString ==
                                        "EditProfile"
                                        ? EditProfile()
                                        : _homeScreenProvider
                                        .selectedString ==
                                        "OrderDetails"
                                        ? Consumer<OrderProvider>(
                                        builder: (_, _orderProvider,
                                            child) =>
                                            OrderDetails(
                                                _orderProvider.orderId
                                                    .toString()))
                                        : _homeScreenProvider
                                        .selectedString ==
                                        "CategoryInfo" //TEST 1
                                        ? Consumer<CategoryProvider>(
                                        builder: (_, _categoryProvider,
                                            child) {
                                          print("TEST 1 CALL");
                                          return CategoryInfo(
                                              _categoryProvider
                                                  .selectedCategoryName);
                                        }


                                    )
                                        :
                                    _homeScreenProvider
                                        .selectedString ==
                                        "SearchProducts2"
                                        ? Search2()
                                        :
                                    _homeScreenProvider
                                        .selectedString ==
                                        "ProductInfoSearch1" ||
                                        _homeScreenProvider
                                            .selectedString ==
                                            "ProductInfoWish"
                                        ? Consumer<HomeScreenProvider>(
                                        builder: (_, _homeScreenProvider,
                                            child) {
                                          print(
                                              "ISPRODUCT CALL 2 ${_homeScreenProvider
                                                  .selectedTitle}");

                                          return ProductInfo(
                                            selectedProductSlug: _homeScreenProvider
                                                .selectedProductSlug,);
                                        })
                                        : _homeScreenProvider
                                        .selectedString ==
                                        "UserEditAddress" ||
                                        _homeScreenProvider
                                            .selectedString ==
                                            "EditAddress"
                                        ? Consumer<UserProvider>(
                                        builder: (_, _userProvider,
                                            child) =>
                                            UserEditAddress(
                                              userAddressId: _userProvider
                                                  .selectedUserAddressId,))
                                        :

                                    _homeScreenProvider
                                        .selectedString ==
                                        "UserAddAddress"
                                        ? UserAddAddress()
                                        : _homeScreenProvider
                                        .selectedString ==
                                        "OrderTracking"
                                        ? Consumer<OrderProvider>(
                                        builder: (_, _orderProvider,
                                            child) =>
                                            OrderTracking(
                                              orderIdToTrack: _orderProvider
                                                  .orderIdToTrack,
                                              userAddressToDeliver: _orderProvider
                                                  .userDeliveryAddress,)) :
                                    _homeScreenProvider
                                        .selectedString ==
                                        "OrderTrackingStatus"
                                        ? Consumer<OrderProvider>(
                                        builder: (_, orderProvider,
                                            child) => OrderStatus(
                                            orderProvider.orderDatum)) :
                                    Home() :

                                    /// CATEGORY PAGE
                                    _homeScreenProvider
                                        .selectedBottomIndex ==
                                        1 ?
                                    _homeScreenProvider.selectedString ==
                                        "Category"
                                        ? CategoryTab()
                                        : _homeScreenProvider
                                        .selectedString ==
                                        "ChangeAddress"
                                        ? ChangeAddress()
                                        : _homeScreenProvider
                                        .selectedString ==
                                        "OrderTracking"
                                        ? Consumer<OrderProvider>(
                                        builder: (_, _orderProvider,
                                            child) =>
                                            OrderTracking(
                                              orderIdToTrack: _orderProvider
                                                  .orderIdToTrack,
                                              userAddressToDeliver: _orderProvider
                                                  .userDeliveryAddress,)
                                    ) :
                                    _homeScreenProvider
                                        .selectedString ==
                                        "OrderTrackingStatus"
                                        ? Consumer<OrderProvider>(
                                        builder: (_, orderProvider,
                                            child) => OrderStatus(
                                            orderProvider.orderDatum)) :
                                    _homeScreenProvider
                                        .selectedString ==
                                        "AddAddress"
                                        ? AddAddress()
                                        : _homeScreenProvider
                                        .selectedString ==
                                        "SearchProducts2"
                                        ? Search() : _homeScreenProvider
                                        .selectedString ==
                                        "MyAddress"
                                        ? MyAddress() : _homeScreenProvider
                                        .selectedString ==
                                        "MyOrders"
                                        ? MyOrders() : _homeScreenProvider
                                        .selectedString ==
                                        "OrderDetails"
                                        ? Consumer<OrderProvider>(
                                        builder: (_, _orderProvider,
                                            child) =>
                                            OrderDetails(
                                                _orderProvider.orderId
                                                    .toString()))
                                        : _homeScreenProvider
                                        .selectedString ==
                                        "FeedBack"
                                        ? FeedBack() : _homeScreenProvider
                                        .selectedString ==
                                        "ChangePassword"
                                        ? Consumer<UserProvider>(
                                      builder: (_, _userProvider, child) =>
                                          ChangePassword(
                                            userMobileNumber: _userProvider
                                                .mobileNumberToSendOtp,),)
                                        : _homeScreenProvider
                                        .selectedString ==
                                        "EditProfile"
                                        ? EditProfile()
                                        : _homeScreenProvider
                                        .selectedString ==
                                        "Wishlist"
                                        ? WishList() : _homeScreenProvider
                                        .selectedString ==
                                        "ProductInfo" || _homeScreenProvider
                                        .selectedString ==
                                        "ProductInfoSearch1" ||
                                        _homeScreenProvider
                                            .selectedString ==
                                            "ProductInfoWish"
                                        ? Consumer<HomeScreenProvider>(
                                        builder: (_, _homeScreenProvider,
                                            child) {
                                          print("ISPRODUCT CALL 3");

                                          return ProductInfo(
                                              selectedProductSlug: _homeScreenProvider
                                                  .selectedProductSlug);
                                        })
                                        :

                                    _homeScreenProvider
                                        .selectedString ==
                                        "SearchProducts"
                                        ? Search2()
                                        : _homeScreenProvider
                                        .selectedString ==
                                        "UserEditAddress" ||
                                        _homeScreenProvider
                                            .selectedString ==
                                            "EditAddress"
                                        ? Consumer<UserProvider>(
                                        builder: (_, _userProvider,
                                            child) =>
                                            UserEditAddress(
                                              userAddressId: _userProvider
                                                  .selectedUserAddressId,))
                                        :

                                    _homeScreenProvider
                                        .selectedString ==
                                        "UserAddAddress"
                                        ? UserAddAddress() : Consumer<
                                        CategoryProvider>(
                                        builder: (_, _categoryProvider,
                                            child) {
                                          //TEST 2
                                          print("TEST 2 CALL");

                                          return CategoryInfo(
                                              _categoryProvider
                                                  .selectedCategoryName);
                                        }

                                    ) :

                                    /// SCHOOL PAGE

                                    _homeScreenProvider
                                        .selectedBottomIndex ==
                                        2 ?
                                    _homeScreenProvider.selectedString ==
                                        "School"
                                        ? SchoolTab()
                                        : _homeScreenProvider
                                        .selectedString ==
                                        "ChangeAddress"
                                        ? ChangeAddress()
                                        : _homeScreenProvider
                                        .selectedString ==
                                        "ProductInfoSearch1" ||
                                        _homeScreenProvider
                                            .selectedString ==
                                            "ProductInfoWish"
                                        ? Consumer<HomeScreenProvider>(
                                        builder: (_, _homeScreenProvider,
                                            child) {
                                          print("ISPRODUCT CALL 3");

                                          return ProductInfo(
                                              selectedProductSlug: _homeScreenProvider
                                                  .selectedProductSlug);
                                        }) : _homeScreenProvider
                                        .selectedString ==
                                        "OrderTracking"
                                        ? Consumer<OrderProvider>(
                                        builder: (_, _orderProvider,
                                            child) =>
                                            OrderTracking(
                                              orderIdToTrack: _orderProvider
                                                  .orderIdToTrack,
                                              userAddressToDeliver: _orderProvider
                                                  .userDeliveryAddress,)
                                    ) :
                                    _homeScreenProvider
                                        .selectedString ==
                                        "OrderTrackingStatus"
                                        ? Consumer<OrderProvider>(
                                        builder: (_, orderProvider,
                                            child) => OrderStatus(
                                            orderProvider.orderDatum))
                                        : _homeScreenProvider
                                        .selectedString ==
                                        "SearchProducts"
                                        ? Search2() : _homeScreenProvider
                                        .selectedString ==
                                        "MyAddress"
                                        ? MyAddress() : _homeScreenProvider
                                        .selectedString ==
                                        "MyOrders"
                                        ? MyOrders() : _homeScreenProvider
                                        .selectedString ==
                                        "OrderDetails"
                                        ? Consumer<OrderProvider>(
                                        builder: (_, _orderProvider,
                                            child) =>
                                            OrderDetails(
                                                _orderProvider.orderId
                                                    .toString()))
                                        : _homeScreenProvider
                                        .selectedString ==
                                        "FeedBack"
                                        ? FeedBack() : _homeScreenProvider
                                        .selectedString ==
                                        "ChangePassword"
                                        ? Consumer<UserProvider>(
                                      builder: (_, _userProvider, child) =>
                                          ChangePassword(
                                            userMobileNumber: _userProvider
                                                .mobileNumberToSendOtp,),)
                                        : _homeScreenProvider
                                        .selectedString ==
                                        "Wishlist"
                                        ? WishList() : _homeScreenProvider
                                        .selectedString ==
                                        "EditProfile"
                                        ? EditProfile()
                                        : _homeScreenProvider
                                        .selectedString ==
                                        "SchoolInfo"
                                        ? Consumer<SchoolProvider>(
                                        builder: (_, _schoolProvider,
                                            child) =>
                                            SchoolInfo(
                                                schoolSlug: _schoolProvider
                                                    .selectedSchoolSlug))
                                        : _homeScreenProvider
                                        .selectedString ==
                                        "SearchProducts"
                                        ? Search2() : _homeScreenProvider
                                        .selectedString ==
                                        "UserEditAddress" ||
                                        _homeScreenProvider
                                            .selectedString ==
                                            "EditAddress"
                                        ? Consumer<UserProvider>(
                                        builder: (_, _userProvider,
                                            child) =>
                                            UserEditAddress(
                                              userAddressId: _userProvider
                                                  .selectedUserAddressId,))
                                        :

                                    _homeScreenProvider
                                        .selectedString ==
                                        "UserAddAddress"
                                        ? UserAddAddress()
                                        : _homeScreenProvider
                                        .selectedString ==
                                        "AddAddress"
                                        ? AddAddress() : Consumer<
                                        HomeScreenProvider>(
                                        builder: (_, _homeScreenProvider,
                                            child) {
                                          print("ISPRODUCT CALL 4");
                                          return ProductInfo(
                                              selectedProductSlug: _homeScreenProvider
                                                  .selectedProductSlug);
                                        }) :

                                    /// USER PAGE
                                    _homeScreenProvider
                                        .selectedBottomIndex ==
                                        3 ?
                                    _homeScreenProvider.selectedString ==
                                        "EditProfile"
                                        ? EditProfile()
                                        : _homeScreenProvider
                                        .selectedString ==
                                        "ChangeAddress"
                                        ? ChangeAddress() :
                                    _homeScreenProvider
                                        .selectedString ==
                                        "School"
                                        ? SchoolTab() : _homeScreenProvider
                                        .selectedString ==
                                        "ProductInfoSearch1" ||
                                        _homeScreenProvider
                                            .selectedString ==
                                            "ProductInfoWish"
                                        ? Consumer<HomeScreenProvider>(
                                        builder: (_, _homeScreenProvider,
                                            child) {
                                          print("ISPRODUCT CALL 3");

                                          return ProductInfo(
                                              selectedProductSlug: _homeScreenProvider
                                                  .selectedProductSlug);
                                        }) : _homeScreenProvider
                                        .selectedString ==
                                        "SearchProducts"
                                        ? Search2() : _homeScreenProvider
                                        .selectedString ==
                                        "ChangeMobile"
                                        ? Consumer<UserProvider>(
                                        builder: (_, _userProvider,
                                            child) =>
                                            ChangeMobile(
                                              selectedMobileNumber: _userProvider
                                                  .mobileNumberToChange,))
                                        : _homeScreenProvider
                                        .selectedString ==
                                        "UserOTP"
                                        ? UserOTP()
                                        : _homeScreenProvider
                                        .selectedString ==
                                        "Wishlist"
                                        ? WishList()
                                        : _homeScreenProvider
                                        .selectedString ==
                                        "MyAddress"
                                        ? MyAddress()
                                        : _homeScreenProvider
                                        .selectedString ==
                                        "UserEditAddress" ||
                                        _homeScreenProvider
                                            .selectedString ==
                                            "EditAddress"
                                        ? Consumer<UserProvider>(
                                        builder: (_, _userProvider,
                                            child) =>
                                            UserEditAddress(
                                              userAddressId: _userProvider
                                                  .selectedUserAddressId,))
                                        : _homeScreenProvider
                                        .selectedString ==
                                        "UserAddAddress"
                                        ? UserAddAddress()
                                        : _homeScreenProvider
                                        .selectedString ==
                                        "MyOrders"
                                        ? MyOrders()
                                        : _homeScreenProvider
                                        .selectedString ==
                                        "OrderDetails"
                                        ? Consumer<OrderProvider>(
                                        builder: (_, _orderProvider,
                                            child) =>
                                            OrderDetails(
                                                _orderProvider.orderId
                                                    .toString()))
                                        : _homeScreenProvider
                                        .selectedString ==
                                        "OrderTracking"
                                        ? Consumer<OrderProvider>(
                                        builder: (_, _orderProvider,
                                            child) =>
                                            OrderTracking(
                                              orderIdToTrack: _orderProvider
                                                  .orderIdToTrack,
                                              userAddressToDeliver: _orderProvider
                                                  .userDeliveryAddress,)
                                    ) : _homeScreenProvider
                                        .selectedString ==
                                        "OrderTrackingStatus"
                                        ? Consumer<OrderProvider>(
                                        builder: (_, orderProvider,
                                            child) =>
                                            OrderStatus(orderProvider
                                                .orderDatum))

                                        : _homeScreenProvider
                                        .selectedString ==
                                        "ChangePassword"
                                        ? Consumer<UserProvider>(
                                      builder: (_, _userProvider, child) =>
                                          ChangePassword(
                                            userMobileNumber: _userProvider
                                                .mobileNumberToSendOtp,),)
                                        : _homeScreenProvider
                                        .selectedString ==
                                        "NewPassword"
                                        ? NewPassword() :
                                    _homeScreenProvider
                                        .selectedString ==
                                        "AddAddress"
                                        ? AddAddress() : _homeScreenProvider
                                        .selectedString ==
                                        "FeedBack"
                                        ? FeedBack()
                                        : _homeScreenProvider
                                        .selectedString ==
                                        "ProductInfo"
                                        ? Consumer<HomeScreenProvider>(
                                        builder: (_, _homeScreenProvider,
                                            child) {
                                          print("ISPRODUCT CALL 5");
                                          return
                                            ProductInfo(
                                              selectedProductSlug: _homeScreenProvider
                                                  .selectedProductSlug,);
                                        })
                                        : _homeScreenProvider
                                        .selectedString ==
                                        "SearchProducts2"
                                        ? Search2() : HelpScreen() :
                                    // : User() :

                                    /// cart page...
                                    _homeScreenProvider
                                        .selectedBottomIndex ==
                                        4
                                        ?
                                    _homeScreenProvider.selectedString ==
                                        "Cart"
                                        ? Cart()
                                        : _homeScreenProvider
                                        .selectedString ==
                                        "AddAddress"
                                        ? AddAddress()
                                        : _homeScreenProvider
                                        .selectedString ==
                                        "ChangeAddress"
                                        ? ChangeAddress()
                                        : _homeScreenProvider
                                        .selectedString ==
                                        "EditAddress"
                                        ? Consumer<UserProvider>(
                                        builder: (_, _userProvider,
                                            child) =>
                                            EditAddress(
                                              userAddressId: _userProvider
                                                  .selectedUserAddressId,))
                                        : _homeScreenProvider
                                        .selectedString ==
                                        "SearchProducts"
                                        ? Search()
                                        : _homeScreenProvider
                                        .selectedString ==
                                        "Home"
                                        ? Home() : _homeScreenProvider
                                        .selectedString ==
                                        "Notifications" ?

                                    /// notification page...
                                    NotificationPage() : Text("")
                                        : Text("")

                                    /*  : _homeScreenProvider
                                        .selectedString ==
                                        "Home"
                                        ? Home()
                                        : _homeScreenProvider
                                        .selectedString ==
                                        "Notification" ?

                                    /// notification page...
                                    NotificationPage() : SizedBox(),*/
                                  ],
                                  onPageChanged: (value) {
                                    _setHomeScreenProvider
                                        .selectedBottomIndex =
                                        value;
                                  },
                                  physics: NeverScrollableScrollPhysics(),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: _homeScreenProvider.selectedString ==
                                    "AddAddress" ||
                                    _homeScreenProvider.selectedString ==
                                        "EditAddress" ||
                                    _homeScreenProvider.selectedString ==
                                        "Filter" ||
                                    _homeScreenProvider.selectedString ==
                                        "UserEditAddress" ||
                                    _homeScreenProvider
                                        .selectedString ==
                                        "ChangeAddress" ||
                                    _homeScreenProvider
                                        .selectedString ==
                                        "UserAddAddress"
                                    ? SizedBox()
                                    : Container(
                                  padding: EdgeInsets.only(bottom: 10),
                                  height: 70,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(35)),
                                    boxShadow: [
                                      BoxShadow(
                                        offset: Offset(1, -2),
                                        blurRadius: 8,
                                        color: Color(0xffE1E1E1),
                                      )
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          print(
                                              "IS TAP BOTTOM - ${_homeScreenProvider
                                                  .selectedString}");

                                          _homeScreenProvider.pageController
                                              .jumpToPage(0);
                                          _setHomeScreenProvider
                                              .selectedBottomIndex =
                                          0;
                                          _setHomeScreenProvider
                                              .selectedString =
                                          "Home";
                                          _setHomeScreenProvider
                                              .blueCartIcon =
                                          false;
                                          _setHomeScreenProvider
                                              .blueBellIcon =
                                          false;
                                        },
                                        child: CircleAvatar(
                                          backgroundColor:
                                          _homeScreenProvider
                                              .selectedBottomIndex == 0
                                              ? colorPalette.orange
                                              : Colors.transparent,
                                          radius: width / 17,
                                          child: SvgPicture.asset(
                                            _homeScreenProvider
                                                .selectedBottomIndex ==
                                                0
                                                ? "assets/icons/activeHome.svg"
                                                : "assets/icons/Home.svg",
                                            height: 25.0,

                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          print(
                                              "IS TAP BOTTOM - ${_homeScreenProvider
                                                  .selectedString}");
                                          _homeScreenProvider.pageController
                                              .jumpToPage(1);
                                          _setHomeScreenProvider
                                              .selectedBottomIndex =
                                          1;
                                          _setHomeScreenProvider
                                              .selectedString =
                                          "Category";
                                          _setHomeScreenProvider
                                              .blueCartIcon =
                                          false;
                                          _setHomeScreenProvider
                                              .blueBellIcon =
                                          false;
                                        },
                                        child: CircleAvatar(
                                          backgroundColor:
                                          _homeScreenProvider
                                              .selectedBottomIndex == 1
                                              ? colorPalette.orange
                                              : Colors.transparent,
                                          radius: width / 17,
                                          child: SvgPicture.asset(
                                            _homeScreenProvider
                                                .selectedBottomIndex ==
                                                1
                                                ? "assets/icons/activeCategory.svg"
                                                : "assets/icons/Category.svg",
                                            height: 25.0,

                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          print(
                                              "IS TAP BOTTOM - ${_homeScreenProvider
                                                  .selectedString}");

                                          _homeScreenProvider.pageController
                                              .jumpToPage(2);
                                          _setHomeScreenProvider
                                              .selectedBottomIndex =
                                          2;
                                          _setHomeScreenProvider
                                              .selectedString =
                                          "School";
                                          _setHomeScreenProvider
                                              .blueCartIcon =
                                          false;
                                          _setHomeScreenProvider
                                              .blueBellIcon =
                                          false;
                                        },
                                        child: CircleAvatar(
                                          backgroundColor:
                                          _homeScreenProvider
                                              .selectedBottomIndex == 2
                                              ? colorPalette.orange
                                              : Colors.transparent,
                                          radius: width / 17,
                                          child: SvgPicture.asset(
                                            _homeScreenProvider
                                                .selectedBottomIndex ==
                                                2
                                                ? "assets/icons/activeSchool.svg"
                                                : "assets/icons/School.svg",
                                            height: 25.0,

                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          print(
                                              "IS TAP BOTTOM - ${_homeScreenProvider
                                                  .selectedString}");

                                          _homeScreenProvider.pageController
                                              .jumpToPage(3);
                                          _setHomeScreenProvider
                                              .selectedBottomIndex =
                                          3;
                                          _setHomeScreenProvider
                                              .selectedString =
                                          "Help";
                                          _setHomeScreenProvider
                                              .blueCartIcon =
                                          false;
                                          _setHomeScreenProvider
                                              .blueBellIcon =
                                          false;
                                        },
                                        child: CircleAvatar(
                                          backgroundColor:
                                          _homeScreenProvider
                                              .selectedBottomIndex == 3
                                              ? colorPalette.orange
                                              : Colors.transparent,
                                          radius: width / 17,
                                          /*   child: Icon(Icons.info_outline,color: _homeScreenProvider
                                           .selectedBottomIndex == 3
                                           ? Colors.black
                                           : Color(0xff777777),size: 35,),*/
                                          child: SvgPicture.asset(

                                            _homeScreenProvider
                                                .selectedBottomIndex ==
                                                3
                                                ? "assets/icons/about_black.svg"
                                                : "assets/icons/about_grey.svg",

                                            height: 25.0,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      snapshot.data.response[0].popupScreen[0].show == "1" &&
                          _homeScreenProvider.homeScreenMainPopupShow
                          ? Material(
                        color: Colors.transparent,
                        child: Container(
                          color: Colors.black26,
                          alignment: Alignment.center,

                          child: Container(

                            width: MediaQuery
                                .of(context)
                                .size
                                .width - 90,
                            child: Stack(
                              children: [
                                Container(
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width - 85,
                                  margin: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),

                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Colors.white,
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),

                                  child: SingleChildScrollView(
                                    physics: BouncingScrollPhysics(),
                                    child: Column(children:
                                    List.generate(snapshot.data.response[0]
                                        .popupScreen.length, (index) {
                                      return Column(
                                        mainAxisAlignment: MainAxisAlignment
                                            .start,
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          Center(
                                            child: Padding(
                                              padding: const EdgeInsets.all(
                                                  8),
                                              child: Text(
                                                '${snapshot.data.response[0]
                                                    .popupScreen[index]
                                                    .title}',
                                                style: TextStyle(
                                                  color: colorPalette
                                                      .navyBlue,
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.w900,
                                                ),
                                                textAlign: TextAlign.center,

                                              ),
                                            ),
                                          ),

                                          SizedBox(height: 15,),
                                          snapshot.data.response[0]
                                              .popupScreen[index].img ==
                                              null ||
                                              snapshot.data.response[0]
                                                  .popupScreen[index].img ==
                                                  ""
                                              ? SizedBox()
                                              : CachedNetworkImage(
                                            imageUrl:
                                            '${snapshot.data.response[0]
                                                .popupScreen[index].img}',
                                            fit: BoxFit.cover,


                                          ),

                                          snapshot.data.response[0]
                                              .popupScreen[index]
                                              .message == null &&
                                              snapshot.data.response[0]
                                                  .popupScreen[index]
                                                  .message == "" ? SizedBox(
                                          ) : SizedBox(
                                            height: 10.0,
                                          ),
                                          //POPUP CHANGE.......

                                          snapshot.data.response[0]
                                              .popupScreen[index]
                                              .message == ""
                                              ? SizedBox()
                                              : Text(
                                            '${snapshot.data.response[0]
                                                .popupScreen[index]
                                                .message}',
                                            style: TextStyle(
                                              color: colorPalette.navyBlue,
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w500,

                                            ),
                                            textAlign: TextAlign.center,
                                          ),

                                          SizedBox(height: 15,),

                                        ],
                                      );
                                    })
                                      ,),

                                  ),
                                ),
                                Positioned(top: 2,
                                    right: 3,
                                    child: InkWell(onTap: () {
                                      _homeScreenProvider
                                          .homeScreenMainPopupShow =
                                      false;
                                    },
                                      child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius
                                                .circular(
                                                100.0),
                                            color: colorPalette.navyBlue,
                                          ),
                                          padding: EdgeInsets.all(2),
                                          child: Icon(
                                            Icons.close,
                                            color: Colors.white,)),
                                    )),
                              ],
                            ),
                          ),
                        ),
                      )
                          : SizedBox()
                    ],
                  );
                }
              }

              else {
                if (snapshot.data.response[0].appScreen != null &&
                    snapshot.data.response[0].appScreen.length > 0) {
                  if (snapshot.data.response[0].appScreen[0].show == "1") {
                    return Scaffold(
                      appBar: MaintananceAppBar(
                          context, imagePath.logo
                      ),
                      body: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: Container(
                              child: SvgPicture.asset(
                                'assets/icons/404.svg',
                                height: 100.0,
                              ),
                            ),
                          ),
                          SizedBox(height: 30.0),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15),
                            child: Text(
                              '${snapshot.data.response[0].appScreen[0]
                                  .message ==
                                  ""
                                  ? "Page Not Found !"
                                  : snapshot.data.response[0].appScreen[0]
                                  .message}',
                              style: TextStyle(
                                color: colorPalette.navyBlue,
                                fontSize: 18.0,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                    );
                  }
                  else {
                    return SizedBox();
                  }
                }
                else {
                  return Scaffold(
                    body: Center(child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/loading.svg', width: 150.0,),
                        SizedBox(height: 20.0),
                        Text(
                          'Loading...', style: TextStyle(color: colorPalette
                            .navyBlue, fontSize: 18.0),)
                      ],
                    )),
                  );
                }
              }
            }
            else {
              return Scaffold(
                body: Center(child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/loading.svg', width: 150.0,),
                    SizedBox(height: 20.0),
                    Text('Loading...', style: TextStyle(color: colorPalette
                        .navyBlue, fontSize: 18.0),)
                  ],
                )),
              );
            }
          },
        );
      },
    );
  }
}

Widget leadingAppBar({bool backButton, title, onBackTap}) {
  String isTitle;
  print("IS LEADING TITLE ${title.toString()}");
  if (isTitle != null && isTitle != "") {
    isTitle = "$title".capitalizeFirst;
  }
  else {
    isTitle = "";
  }
  return Row(
    children: [
      backButton
          ? IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
        ),
        onPressed: onBackTap,
        iconSize: 30,
      )
          : SizedBox(),
      Container(
        width: Get.width / 2.6,
        child: Padding(
          padding: title == 'Category' || title == 'Schools' ||
              title == 'Help'
          // title == 'Account'
              ? EdgeInsets.symmetric(horizontal: 30)
              : EdgeInsets.symmetric(horizontal: 0),

          child: Text(
            "$title".capitalizeFirst,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: const Color(0xff301869),
            ),
            textAlign: TextAlign.left,
          ),
        ),
      ),
    ],
  );
}
