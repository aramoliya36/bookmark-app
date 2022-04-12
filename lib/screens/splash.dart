import 'dart:async';
import 'dart:io';

import 'package:bookmrk/api/home_page_api.dart';
import 'package:bookmrk/constant/constant.dart';
import 'package:bookmrk/provider/homeScreenProvider.dart';
import 'package:bookmrk/provider/notification_provider.dart';
import 'package:bookmrk/res/images.dart';
import 'package:device_info/device_info.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

import 'homePage.dart';
import 'onBoarding.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  ImagePath imagePath = ImagePath();
  HomeScreenProvider _homeScreenProvider;
  NotificationProvider _notificationProvider;
  GetStorage prefs = GetStorage();
  navigateToAnotherScreen() async {
    await Future.delayed(Duration(seconds: 2), () async {
      prefs = GetStorage();
      _homeScreenProvider.selectedString = "Home";
      bool isLogin = prefs.read<bool>("isLogin");
      if (isLogin ?? false) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomePage()));
      } else {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => OnBoarding()));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    navigateToAnotherScreen();
    callDeviceInfo();
  }

  @override
  Widget build(BuildContext context) {
    _homeScreenProvider =
        Provider.of<HomeScreenProvider>(context, listen: false);

    _notificationProvider =
        Provider.of<NotificationProvider>(context, listen: false);
    Timer.periodic(Duration(seconds: 10), (timer) {
      _notificationProvider.getNotification();
      _homeScreenProvider.getCartCount();
    });
    return Scaffold(
      body: GestureDetector(
        onTap: () async {
//          SharedPreferences _prefs = await SharedPreferences.getInstance();
//          bool isLogin = _prefs.getBool("isLogin");
//          if (isLogin) {
//            Navigator.of(context).pushReplacement(
//                MaterialPageRoute(builder: (context) => HomePage()));
//          } else {
//            Navigator.of(context).pushReplacement(
//                MaterialPageRoute(builder: (context) => OnBoarding()));
//          }
        },
        child: Center(
            child: Container(
          margin: EdgeInsets.symmetric(horizontal: 48),
          child: imagePath.logo,
        )),
      ),
    );
  }

  Future<void> callDeviceInfo() async {
    print("IS USER ID ${prefs.read<int>('userId')}");
    if (prefs.read<int>('userId') != null) {
      /// get device information....
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      dynamic deviceId;
      dynamic osInfo;
      dynamic modelName;
      dynamic moreInfo = {"date": "${DateTime.now()}"};

      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        osInfo = Platform.operatingSystem;
        modelName = androidInfo.model;
      } else {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        osInfo = Platform.operatingSystem;
        modelName = iosInfo.model;
      }

      /// get firebase token....
      await FirebaseMessaging().getToken().then((value) {
        deviceId = value.toString();
      });
      int userId = prefs.read<int>('userId');

      debugPrint('deviceId device id : $deviceId');
      debugPrint('userId device id : ${userId.toString()}');
      debugPrint('osInfo device id : ${osInfo.toString()}');
      debugPrint('modelName device id : ${modelName.toString()}');
      debugPrint('kAppVersion device id : ${kAppVersion.toString()}');
      debugPrint('moreInfo device id : ${moreInfo.toString()}');

      dynamic updateAppResponse = await HomePageApi.updateApplicationInfo(
          userId.toString(),
          deviceId.toString(),
          osInfo.toString(),
          modelName.toString(),
          kAppVersion.toString(),
          moreInfo.toString());
    }
  }
}
