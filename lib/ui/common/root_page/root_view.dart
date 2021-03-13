import 'package:fcode_common/fcode_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_app/ui/common/root_page/root_page.dart';
import 'package:smart_app/util/routes.dart';

import 'root_bloc.dart';
import 'root_state.dart';

class RootView extends StatelessWidget {
  final String email;

  RootView({Key key, this.email}) : super(key: key);

  static final log = Log("RootView");
  static final loadingWidget = Center(
    child: CircularProgressIndicator(),
  );

  @override
  Widget build(BuildContext context) {
    final rootBloc = BlocProvider.of<RootBloc>(context);
    log.d("Loading Root View");

    CustomSnackBar customSnackBar;

    final scaffold = Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );

    if (email != null && !rootBloc.state.userLogged) {
      rootBloc.add(UserLoggedEvent(email));
    }


    if (email == null) {
      Future.microtask(
            () => Navigator.pushReplacementNamed(context, Routes.LOGIN_ROUTE),
      );
    }

    if (email != null) {
      Future.microtask(
              () => Navigator.pushReplacementNamed(context, Routes.HOME_ROUTE));
    }

    return MultiBlocListener(
      listeners: [
        BlocListener<RootBloc, RootState>(
          listenWhen: (pre, current) => pre.error != current.error,
          listener: (context, state) {
            if (state.error?.isNotEmpty ?? false) {
              customSnackBar?.showErrorSnackBar(state.error);
            } else {
              customSnackBar?.hideAll();
            }
          },
        ),
      ],
      child: scaffold,
    );
  }
}
