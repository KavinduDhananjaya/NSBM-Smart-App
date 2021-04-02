import 'package:fcode_common/fcode_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_app/theme/styled_colors.dart';
import 'package:smart_app/ui/common/root_page/root_page.dart';
import 'package:smart_app/util/routes.dart';

import 'profile_bloc.dart';
import 'profile_state.dart';

class ProfileView extends StatelessWidget {
  static final log = Log("ProfileView");
  static final loadingWidget = Center(
    child: CircularProgressIndicator(),
  );

  final titleStyle = TextStyle(
    color: StyledColors.DARK_BLUE.withOpacity(0.6),
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  final subtitleStyle = TextStyle(
    color: StyledColors.DARK_BLUE,
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  final separator = Container(
    margin: EdgeInsets.symmetric(horizontal: 16),
    height: 1.2,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.centerRight,
        end: Alignment.centerLeft,
        colors: [
          StyledColors.DARK_GREEN.withOpacity(0.1),
          StyledColors.PRIMARY_COLOR.withOpacity(0.3)
        ],
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final profileBloc = BlocProvider.of<ProfileBloc>(context);
    // ignore: close_sinks
    final rootBloc = BlocProvider.of<RootBloc>(context);
    log.d("Loading Profile View");

    CustomSnackBar customSnackBar;
    final scaffold = Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "Profile",
          style: TextStyle(
            color: StyledColors.DARK_GREEN,
            fontWeight: FontWeight.w500,
            fontSize: 28,
          ),
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: BlocBuilder<RootBloc, RootState>(
            buildWhen: (previous, current) =>
                previous.currentUser != current.currentUser,
            builder: (context, state) {
              final user = state.currentUser;

              return Column(
                children: [
                  SizedBox(
                    height: 8,
                  ),
                  ProfileImage(
                    style: TextStyle(
                      color: StyledColors.DARK_GREEN,
                      fontSize: 27,
                      fontWeight: FontWeight.w600,
                    ),
                    radius: 32,
                    firstName: user.name,
                    lastName: " ",
                    image:
                        user.profileImage.isEmpty || user.profileImage == null
                            ? null
                            : NetworkImage(user.profileImage),
                    backgroundColor: StyledColors.DARK_GREEN.withOpacity(0.4),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    "${user.name}",
                    style: TextStyle(
                      color: StyledColors.DARK_GREEN.withOpacity(0.7),
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  ListTile(
                    title: Text(
                      "NSBM Email",
                      style: titleStyle,
                    ),
                    subtitle: Text(
                      '${user.nsbmEmail}',
                      style: subtitleStyle,
                    ),
                  ),
                  separator,
                  ListTile(
                    title: Text(
                      "NSBM ID",
                      style: titleStyle,
                    ),
                    subtitle: Text(
                      '${user.nsbmId}',
                      style: subtitleStyle,
                    ),
                  ),
                  separator,
                  ListTile(
                    title: Text(
                      "Registered University",
                      style: titleStyle,
                    ),
                    subtitle: Text(
                      '${user.registeredUniversity}',
                      style: subtitleStyle,
                    ),
                  ),
                  separator,
                  ListTile(
                    title: Text(
                      "Degree Program",
                      style: titleStyle,
                    ),
                    subtitle: Text(
                      '${user.degree}',
                      style: subtitleStyle,
                    ),
                  ),
                  separator,
                  ListTile(
                    title: Text(
                      "University Email",
                      style: titleStyle,
                    ),
                    subtitle: Text(
                      '${user.universityEmail}',
                      style: subtitleStyle,
                    ),
                  ),
                  separator,
                  ListTile(
                    title: Text(
                      "University ID",
                      style: titleStyle,
                    ),
                    subtitle: Text(
                      '${user.universityId}',
                      style: subtitleStyle,
                    ),
                  ),
                  separator,
                  SizedBox(
                    height: 24,
                  ),
                  TextButton(
                    onPressed: () {
                      rootBloc.add(UserLoggedOutEvent());
                      Navigator.pushNamedAndRemoveUntil(
                          context, Routes.LOGIN_ROUTE, (route) => false);
                    },
                    child: Text(
                      "LOGOUT",
                      style: TextStyle(
                        color: StyledColors.DARK_BLUE,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );

    return MultiBlocListener(
      listeners: [
        BlocListener<ProfileBloc, ProfileState>(
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
