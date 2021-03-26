import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:smart_app/ui/common/bottom_bar/bottom_bar_view.dart';
import 'package:smart_app/ui/common/login_page/login_page.dart';

abstract class Routes {
  Routes._();

  static List<String> faculties=["CSE","Management","Tech","Art","Electronic"];

  static String timeAgoSinceDate(DateTime time, {bool numericDates = true}) {

    DateTime notificationDate = time;
    final date2 = DateTime.now();

    final difference = date2.difference(notificationDate);

   if ((difference.inDays / 7).floor() >= 1) {
      return (numericDates) ? '1 week ago' : 'Last week';
    } else if (difference.inDays >= 2) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays >= 1) {
      return (numericDates) ? '1 day ago' : 'Yesterday';
    } else if (difference.inHours >= 2) {
      return '${difference.inHours} hours ago';
    } else if (difference.inHours >= 1) {
      return (numericDates) ? '1 hour ago' : 'An hour ago';
    } else if (difference.inMinutes >= 2) {
      return '${difference.inMinutes} min ago';
    } else if (difference.inMinutes >= 1) {
      return (numericDates) ? '1 min ago' : 'A minute ago';
    } else if (difference.inSeconds >= 3) {
      return '${difference.inSeconds} seconds ago';
    } else {
      return 'Just now';
    }
  }


  static const LOGIN_ROUTE = "login";
  static const HOME_ROUTE = "home";

  static final login = LoginProvider();

  static final home = BottomBarView();

  static Route generator(RouteSettings settings) {
    switch (settings.name) {
      case LOGIN_ROUTE:
        return MaterialPageRoute(builder: (context) => login);

      case HOME_ROUTE:
        return MaterialPageRoute(builder: (context) => home);

      default:
        return MaterialPageRoute(builder: (context) => login);
    }
  }
}
