import 'package:bookmrk/api/notification_api.dart';
import 'package:bookmrk/constant/constant.dart';
import 'package:bookmrk/model/notification_model.dart';
import 'package:flutter/cupertino.dart';

class NotificationProvider extends ChangeNotifier{



  /// total Number of notifications ....
  int _totalNewNotifications = 0;

  int get totalNewNotifications => _totalNewNotifications;

  set totalNewNotifications(int value) {
    _totalNewNotifications = value;
    notifyListeners();
  }


  getNotification() async {
    int userId = prefs.read<int>('userId');
    dynamic response =
    await NotificationAPI.getAllNotification(userId.toString());
    NotificationModel _notificationModel = NotificationModel.fromJson(response);
    int totalNotification = 0;
    _notificationModel.response.forEach((notification) {
      if (notification.isSeen == "0") {
        totalNotification++;
      }
    });
    totalNewNotifications = totalNotification;
  }

}