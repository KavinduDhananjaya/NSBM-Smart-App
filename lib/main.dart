import 'package:flutter/material.dart';
import 'package:smart_app/ui/root_page/smart_app_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  // final user = await Authentication().getLoggedUser();
  runApp(SmartAppView("UserEmail"));
}
