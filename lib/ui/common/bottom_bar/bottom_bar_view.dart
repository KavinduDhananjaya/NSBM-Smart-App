import 'package:fcode_common/fcode_common.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_app/theme/styled_colors.dart';
import 'package:smart_app/ui/common/chat_page/chat_page.dart';
import 'package:smart_app/ui/common/notification_page/notification_page.dart';
import 'package:smart_app/ui/common/root_page/root_page.dart';
import 'package:smart_app/ui/lecturer_views/lecturer_home_page/lecturer_home_page.dart';
import 'package:smart_app/ui/lecturer_views/lecturer_profile_page/lecture_profile_page.dart';
import 'package:smart_app/ui/student_views/events_page/events_page.dart';
import 'package:smart_app/ui/student_views/home_page/home_page.dart';
import 'package:smart_app/ui/student_views/profile_page/profile_page.dart';
import 'package:smart_app/ui/student_views/special_notice_page/special_notice_page.dart';

class BottomBarView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BottomBarViewState();
}

class _BottomBarViewState extends State<BottomBarView> {
  static final log = Log("HomeView");
  static final loadingWidget = Center(
    child: CircularProgressIndicator(),
  );

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final rootBloc = BlocProvider.of<RootBloc>(context);
    log.d("Loading Bottom View");

    CustomSnackBar customSnackBar;

    final List<Widget> studentTabs = [
      HomeProvider(),
      ChatProvider(),
      NotificationProvider(),
      SpecialNoticeProvider(),
      ProfileProvider(),
    ];

    final List<Widget> lecturerTabs = [
      LecturerHomeProvider(),
      ChatProvider(),
      NotificationProvider(),
      LecturerProfileProvider(),
    ];

    final studentBar = [
      FFNavigationBarItem(
        iconData: Icons.home,
        label: 'Home',
      ),
      FFNavigationBarItem(
        iconData: Icons.chat,
        label: 'Chat',
      ),
      FFNavigationBarItem(
        iconData: Icons.notifications,
        label: 'Notification',
      ),
      FFNavigationBarItem(
        iconData: Icons.event,
        label: 'Special',
      ),
      FFNavigationBarItem(
        iconData: Icons.person_rounded,
        label: 'Profile',
      ),
    ];


    final lecturerBar = [
      FFNavigationBarItem(
        iconData: Icons.home,
        label: 'Home',
      ),
      FFNavigationBarItem(
        iconData: Icons.chat,
        label: 'Chat',
      ),
      FFNavigationBarItem(
        iconData: Icons.notifications,
        label: 'Notification',
      ),
      FFNavigationBarItem(
        iconData: Icons.person_rounded,
        label: 'Profile',
      ),
    ];

    final scaffold = BlocBuilder<RootBloc, RootState>(
        buildWhen: (previous, current) =>
        previous.currentUser != current.currentUser,
        builder: (context, state) {
          if (state.currentUser == null) {
            return Scaffold(
              body: loadingWidget,
            );
          }
          final type = state?.currentUser?.role;

          return  Scaffold(
            body: type == 'student' ? studentTabs[selectedIndex] : lecturerTabs[selectedIndex],
            bottomNavigationBar: FFNavigationBar(
              theme: FFNavigationBarTheme(
                barBackgroundColor: Colors.white,
                selectedItemBorderColor: StyledColors.PRIMARY_COLOR,
                selectedItemBackgroundColor: StyledColors.DARK_GREEN,
                selectedItemIconColor: Colors.white,
                selectedItemLabelColor: StyledColors.DARK_GREEN,
                showSelectedItemShadow: false,
                unselectedItemIconColor:  StyledColors.PRIMARY_COLOR,
                unselectedItemLabelColor:  StyledColors.PRIMARY_COLOR,
              ),
              selectedIndex: selectedIndex,
              onSelectTab: (index) {
                setState(() {
                  selectedIndex = index;
                });
              },
              items: type == "student"? studentBar : lecturerBar,
            ),
          );
        });


    return scaffold;
  }
}
