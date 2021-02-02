import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_app/ui/root_page/root_page.dart';
import 'package:smart_app/theme/primary_theme.dart';
import 'package:smart_app/util/routes.dart';

class SmartAppView extends StatelessWidget {
  String email;

  SmartAppView(
      this.email,
      );

  @override
  Widget build(BuildContext context) {
    final materialApp = MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Smart App",
      theme: PrimaryTheme.generateTheme(context),
      home: RootView(email: email,),
      onGenerateRoute: Routes.generator,
    );

    return MultiBlocProvider(
      providers: <BlocProvider>[
        BlocProvider<RootBloc>(create: (context) => RootBloc(context)),
      ],
      child: materialApp,
    );
  }
}
