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
  final type = 0;

  @override
  Widget build(BuildContext context) {
    final rootBloc = BlocProvider.of<RootBloc>(context);
    log.d("Loading Home View");

    CustomSnackBar customSnackBar;

    final List<Widget> studentTabs = [
      HomeProvider(),
      ChatProvider(),
      NotificationProvider(),
      EventsProvider(),
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
        label: 'Event',
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


    final scaffold = Scaffold(
      body: type == 1 ? studentTabs[selectedIndex] : lecturerTabs[selectedIndex],
      bottomNavigationBar: FFNavigationBar(
        theme: FFNavigationBarTheme(
          barBackgroundColor: Colors.white,
          selectedItemBorderColor: StyledColors.LIGHT_GREEN,
          selectedItemBackgroundColor:
              StyledColors.PRIMARY_COLOR.withOpacity(0.5),
          selectedItemIconColor: Colors.white,
          selectedItemLabelColor: StyledColors.DARK_GREEN,
          showSelectedItemShadow: false,
          unselectedItemIconColor: StyledColors.LIGHT_GREEN,
          unselectedItemLabelColor: StyledColors.LIGHT_GREEN,
        ),
        selectedIndex: selectedIndex,
        onSelectTab: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: type == 1 ? studentBar : lecturerBar,
      ),
    );

    return scaffold;
  }
}
