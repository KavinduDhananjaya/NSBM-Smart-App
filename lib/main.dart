import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:smart_app/db/authentication.dart';
import 'package:smart_app/ui/common/root_page/smart_app_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final user = await Authentication().getLoggedUser();
  runApp(SmartAppView(null));
}
