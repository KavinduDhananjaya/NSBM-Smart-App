import 'package:flutter/material.dart';
import 'package:smart_app/ui/bottom_bar/bottom_bar_view.dart';
import 'package:smart_app/ui/login_page/login_provider.dart';

abstract class Routes {
  Routes._();

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
