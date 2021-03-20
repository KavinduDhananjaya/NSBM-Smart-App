import 'package:fcode_common/fcode_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_app/theme/styled_colors.dart';
import 'package:smart_app/ui/common/root_page/root_page.dart';
import 'package:smart_app/ui/widgets/notification_card.dart';

import 'special_notice_bloc.dart';
import 'special_notice_state.dart';

class SpecialNoticeView extends StatelessWidget {
  static final log = Log("SpecialNoticeView");
  static final loadingWidget = Center(
    child: CircularProgressIndicator(),
  );

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final special_noticeBloc = BlocProvider.of<SpecialNoticeBloc>(context);
    // ignore: close_sinks
    final rootBloc = BlocProvider.of<RootBloc>(context);
    log.d("Loading SpecialNotice View");

    CustomSnackBar customSnackBar;

    final scaffold = Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "Special Notice",
          style: TextStyle(
            color: StyledColors.DARK_GREEN,
            fontWeight: FontWeight.w500,
            fontSize: 28,
          ),
        ),
      ),
      body: BlocBuilder<RootBloc, RootState>(
        buildWhen: (pre, current) =>
            pre.specialNotices != current.specialNotices,
        builder: (context, state) {
          if (state.specialNotices == null) {
            return loadingWidget;
          }

          List<Widget> children = [];

          for (int i = 0; i < state.specialNotices.length; i++) {
            final notification = state.specialNotices[i];

            final card = NotificationCard(
              title: notification.title,
              createdAt: notification.createdAt,
            );

            children.add(card);
          }

          if (children.isEmpty) {
            children.add(Center(
              child: Text(
                "No Notifications..",
                style: TextStyle(fontSize: 17, color: StyledColors.DARK_BLUE),
              ),
            ));
          }

          return ListView(children: children);
        },
      ),
    );

    return MultiBlocListener(
      listeners: [
        BlocListener<SpecialNoticeBloc, SpecialNoticeState>(
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
