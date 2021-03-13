import 'package:fcode_common/fcode_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_app/theme/styled_colors.dart';
import 'package:smart_app/ui/common/root_page/root_page.dart';
import 'package:smart_app/ui/widgets/notification_card.dart';

import 'notification_bloc.dart';
import 'notification_state.dart';

class NotificationView extends StatelessWidget {
  static final log = Log("NotificationView");
  static final loadingWidget = Center(
    child: CircularProgressIndicator(),
  );

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final notificationBloc = BlocProvider.of<NotificationBloc>(context);
    // ignore: close_sinks
    final rootBloc = BlocProvider.of<RootBloc>(context);
    log.d("Loading Notification View");

    CustomSnackBar customSnackBar;
    final scaffold = Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "Notification",
          style: TextStyle(
            color: StyledColors.DARK_GREEN,
            fontWeight: FontWeight.w500,
            fontSize: 28,
          ),
        ),
      ),
      body: BlocBuilder<NotificationBloc, NotificationState>(
          buildWhen: (pre, current) => true,
          builder: (context, state) {
            return ListView(
              children: [
                NotificationCard(),
                NotificationCard(),
                NotificationCard(),
                NotificationCard(),
                NotificationCard(),
                NotificationCard(),
              ],
            );
          }),
    );

    return MultiBlocListener(
      listeners: [
        BlocListener<NotificationBloc, NotificationState>(
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