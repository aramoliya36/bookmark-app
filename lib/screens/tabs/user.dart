import 'dart:io';

import 'package:bookmrk/api/forgot_password_api.dart';
import 'package:bookmrk/api/user_api.dart';
import 'package:bookmrk/constant/constant.dart';
import 'package:bookmrk/model/user_profile_info_model.dart';
import 'package:bookmrk/provider/forgot_password_provider.dart';
import 'package:bookmrk/provider/homeScreenProvider.dart';
import 'package:bookmrk/provider/user_provider.dart';
import 'package:bookmrk/res/colorPalette.dart';
import 'package:bookmrk/res/utility.dart';
import 'package:bookmrk/screens/onBoarding.dart';
import 'package:bookmrk/screens/user/privacy_policy.dart';
import 'package:bookmrk/screens/user/terms_and_conditions.dart';
import 'package:bookmrk/widgets/snackbar_global.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class User extends StatefulWidget {
  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<User> {
  ColorPalette colorPalette = ColorPalette();

  Future getUserInformation() async {
    int userId = prefs.read<int>('userId');

    dynamic userInformation =
        await UserAPI.getAllUserInformation(userId.toString());

    UserProfileInfoModel _userInformationModel =
        UserProfileInfoModel.fromJson(userInformation);

    return _userInformationModel;
  }

  /// send otp on mobile number ...
  Future sendOTP(String userMobileNumber) async {
    int userId = prefs.read<int>('userId');
    dynamic response =
        await ForgotPasswordAPI.forgotPassword(userMobileNumber, userId);

    return response;
  }

  ScrollController scrollController;
  @override
  void initState() {
    // TODO: implement initState
    // scrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var homeProvider = Provider.of<HomeScreenProvider>(context, listen: false);

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return FutureBuilder(
        future: getUserInformation(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 25),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        snapshot.data.response[0].profilePic == "circ"
                            ? CircleAvatar(
                                radius: height / 20,
                                backgroundColor: Colors.transparent,
                                child: Icon(
                                  Icons.person_outline,
                                  size: 50.0,
                                  color: colorPalette.navyBlue,
                                ),
                              )
                            : CachedNetworkImage(
                                imageUrl:
                                    '${snapshot.data.response[0].profilePic}',
                                imageBuilder: (context, imageProvider) =>
                                    CircleAvatar(
                                  radius: height / 20,
                                  backgroundColor: Colors.transparent,
                                  backgroundImage: imageProvider,
                                ),
                                errorWidget: (context, string, stackTrace) =>
                                    CircleAvatar(
                                  radius: height / 20,
                                  backgroundColor: Colors.transparent,
                                  child: Icon(
                                    Icons.person_outline,
                                    size: 100.0,
                                    color: colorPalette.navyBlue,
                                  ),
                                ),
                                placeholder: (context, str) => CircleAvatar(
                                  radius: height / 20,
                                  backgroundColor: Colors.transparent,
                                  child: Icon(
                                    Icons.person_outline,
                                    size: 50.0,
                                    color: colorPalette.navyBlue,
                                  ),
                                ),
                              ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Container(
                          width: Get.width / 2.4,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${snapshot.data.response[0].fname}',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 20,
                                  color: const Color(0xff515c6f),
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                '${snapshot.data.response[0].email}',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 14,
                                  color: const Color(0xff515c6f),
                                ),
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Provider.of<HomeScreenProvider>(context,
                                          listen: false)
                                      .selectedString = "EditProfile";
                                  Get.back();
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: height / 26,
                                  width: width / 3.5,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    border: Border.all(
                                      width: 2.8,
                                      color: colorPalette.navyBlue,
                                    ),
                                  ),
                                  child: Text(
                                    'EDIT PROFILE',
                                    style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 13,
                                      color: const Color(0xff301869),
                                      letterSpacing: 0.72,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 25,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    height: width * 1.15,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: colorPalette.grey,
                        width: 1,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Scrollbar(
                      thickness: 3,
                      // controller: scrollController,
                      // isAlwaysShown: true,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _profileMenus(
                                title: "My Addresses",
                                width: width,
                                asset: "address",
                                onClick: () {
                                  homeProvider.selectedString = "MyAddress";
                                }),
                            _customDivider(),
                            _profileMenus(
                                title: "My Orders",
                                width: width,
                                asset: "allOrder",
                                onClick: () {
                                  homeProvider.selectedString = "MyOrders";
                                }),
                            _customDivider(),
                            _profileMenus(
                                title: "Wishlist",
                                width: width,
                                asset: "heart",
                                onClick: () {
                                  homeProvider.selectedString = "Wishlist";
                                }),
                            _customDivider(),
                            _profileMenus(
                                title: "Shop by Category",
                                width: width,
                                asset: "activeCategory",
                                onClick: () {
                                  homeProvider.selectedString = "Category";
                                  homeProvider.selectedBottomIndex = 1;
                                }),
                            _customDivider(),
                            _profileMenus(
                                title: "Shop by School",
                                width: width,
                                asset: "activeSchool",
                                onClick: () {
                                  homeProvider.selectedString = "School";
                                  homeProvider.selectedBottomIndex = 2;
                                }),
                            _customDivider(),
                            _profileMenus(
                                title: "Shop by Subject",
                                width: width,
                                asset: "subject",
                                onClick: () {
                                  homeProvider.selectedString = "AllSubjects";
                                  homeProvider.selectedBottomIndex = 0;
                                }),
                            _customDivider(),
                            _profileMenus(
                                title: "Shop by Publisher",
                                width: width,
                                asset: "publisher",
                                onClick: () {
                                  homeProvider.selectedString =
                                      "AllPublishers";
                                  homeProvider.selectedBottomIndex = 0;
                                }),
                            // https://www.bookmrk.in/stage/api_/categories/filter_categories/1595922619X5f1fd8bb5f332/MOB/1
                            _customDivider(),
                            _profileMenus(
                                title: "Shop by Brand",
                                width: width,
                                asset: "brand",
                                onClick: () {
                                  homeProvider.selectedString = "Brand";
                                  homeProvider.selectedBottomIndex = 0;
                                }),
                            _customDivider(),
                            /*  _profileMenus(
                                title: "Shop by Brand",
                                width: width,
                                asset: "publisher",
                                onClick: () {
                                  homeProvider.selectedString = "Brand";
                                  homeProvider.selectedBottomIndex = 0;
                                }),
                            _customDivider(),*/
                            Consumer<ForgotPasswordProvider>(
                              builder: (_, _forgotPasswordProvider, child) =>
                                  Consumer<UserProvider>(
                                builder: (_, _userProvider, child) =>
                                    _profileMenus(
                                        title: "Change Password",
                                        width: width,
                                        asset: "key",
                                        onClick: () async {
                                          homeProvider.selectedString =
                                              "ChangePassword";
                                          dynamic response = await sendOTP(
                                              snapshot
                                                  .data.response[0].mobile);
                                          if (response['status'] == 200) {
                                            _forgotPasswordProvider
                                                    .forgotPasswordFromPage =
                                                "Account";
                                            _userProvider
                                                    .mobileNumberToSendOtp =
                                                snapshot
                                                    .data.response[0].mobile;
                                            homeProvider.selectedString =
                                                "ChangePassword";
                                          } else {
                                            Scaffold.of(context).showSnackBar(
                                                getSnackBar(
                                                    '${response['message']}'));
                                          }
                                        }),
                              ),
                            ),
                            _customDivider(),
                            _profileMenus(
                                title: "Submit Feedback",
                                width: width,
                                asset: "good",
                                onClick: () =>
                                    homeProvider.selectedString = "FeedBack"),
                            _customDivider(),
                            _profileMenus(
                              title: "Share",
                              width: width,
                              asset: "share",
                              onClick: () {
                                if (Platform.isAndroid) {
                                  Share.share(
                                      "Hi, you have been invited to Download BOOKMRK App.\nDownload for free on Google Playstore: \nhttps://play.google.com/store/apps/details?id=com.solutioncone.bookmrk");
                                } else if (Platform.isIOS) {
                                  Share.share(
                                      "Hi, you have been invited to Download BOOKMRK App.\nDownload for free on IOS App Store: \nhttps://apps.apple.com/in/app/bookmrk/id1543839623");
                                }
                              },
                            ),
                            _customDivider(),
                            _profileMenus(
                                title: "Terms and Conditions",
                                width: width,
                                asset: "tc",
                                onClick: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          TermsAndCondition(),
                                    ),
                                  );
                                }),
                            _customDivider(),
                            _profileMenus(
                                title: "Privacy Policy",
                                width: width,
                                asset: "policy",
                                onClick: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PrivacyPolicy(),
                                    ),
                                  );
                                }),
                            _customDivider(),
                            Consumer<HomeScreenProvider>(
                              builder: (_, _homeScreenProvider, child) =>
                                  _profileMenus(
                                title: "Logout",
                                width: width,
                                asset: "logout",
                                onClick: () => showDialog(
                                  context: context,
                                  builder: (context) => LogOutDialog(
                                    width: width,
                                    title: 'Are you Sure ?',
                                    onCancelTap: () {
                                      Navigator.pop(context);
                                    },
                                    onYesTap: () async {
                                      prefs.write('isLogin', false);
                                      _homeScreenProvider.selectedString =
                                          "Home";
                                      _homeScreenProvider
                                          .selectedBottomIndex = 0;
                                      Navigator.pop(context);
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => OnBoarding()),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),

                  textView(
                      text: Utility.companyMobileNumber,
                      icon: Icon(Icons.phone_android),
                      url: 'tel:+91 8881355777'),
                  textView(
                      text: Utility.companyEmail,
                      icon: Icon(Icons.email),
                      url: 'mailto:info@bookmrk.in?subject='),
                  textView(
                      text: Utility.customerEmail,
                      icon: Icon(Icons.email),
                      url: 'mailto:customercare@bookmrk.in?subject='),
                  // SizedBox(height: 90.0),
                ],
              ),
            );
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
}

Widget textView({String text, Icon icon, String url}) {
  return InkWell(
    onTap: () async {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch';
      }
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Row(
        children: [
          icon,
          SizedBox(
            width: 5,
          ),
          Text(
            text,
            style: TextStyle(
                fontSize: 15, fontFamily: 'Roboto', color: Color(0xff515c6f)),
          ),
        ],
      ),
    ),
  );
}

Widget _profileMenus({width, title, asset, onClick}) {
  return InkWell(
    // onTap: onClick,
    onTap: () {
      Get.back();
      onClick();
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
      child: Row(
        children: [
          Container(
            width: width / 16,
            height: 20,
            child: SvgPicture.asset(
              "assets/icons/${asset}.svg",
              height: width / 22,
              width: width / 22,
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Text(
            title,
            style: TextStyle(
                fontSize: 15, fontFamily: 'Roboto', color: Color(0xff515c6f)),
          ),
          Spacer(),
          SvgPicture.asset(
            "assets/icons/arrow.svg",
            height: width / 15,
          ),
        ],
      ),
    ),
  );
}

Widget _customDivider() {
  return Divider(
    height: 15,
    indent: 60,
    endIndent: 5,
    thickness: 1.5,
  );
}

Widget LogOutDialog({width, title, onCancelTap, onYesTap}) {
  ColorPalette colorPalette = ColorPalette();

  return Dialog(
    elevation: 100,
    insetPadding: EdgeInsets.symmetric(horizontal: 16),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
    child: Container(
      height: width / 3,
      width: width - 32,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              title,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 20,
                color: const Color(0xff000000),
              ),
              textAlign: TextAlign.left,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: onCancelTap,
                  child: Container(
                    alignment: Alignment.center,
                    height: width / 8,
                    width: width / 2.8,
                    decoration: BoxDecoration(
                        color: colorPalette.navyBlue.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(18)),
                    child: Text(
                      "CANCEL",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: onYesTap,
                  child: Container(
                    alignment: Alignment.center,
                    height: width / 8,
                    width: width / 2.8,
                    decoration: BoxDecoration(
                        color: colorPalette.navyBlue,
                        borderRadius: BorderRadius.circular(18)),
                    child: Text(
                      "YES",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ),
  );
}
