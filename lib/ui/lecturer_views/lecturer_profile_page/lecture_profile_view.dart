import 'package:fcode_common/fcode_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_app/theme/styled_colors.dart';
import 'package:smart_app/ui/common/root_page/root_page.dart';
import 'package:smart_app/util/routes.dart';

import 'lecture_profile_bloc.dart';
import 'lecture_profile_state.dart';

class LecturerProfileView extends StatelessWidget {
  static final log = Log("LecturerProfileView");
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
    final lecture_profileBloc = BlocProvider.of<LecturerProfileBloc>(context);
    // ignore: close_sinks
    final rootBloc = BlocProvider.of<RootBloc>(context);
    log.d("Loading LecturerProfile View");

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
          child: BlocBuilder<RootBloc,RootState>(
            buildWhen: (pre,current)=>pre.currentUser!=current.currentUser,
            builder: (context, snapshot) {
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
                    firstName: "${snapshot.currentUser.name}",
                    lastName: " ",
                    image: null,
                    backgroundColor: StyledColors.DARK_GREEN.withOpacity(0.4),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    "${snapshot.currentUser.name}",
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
                      '${snapshot.currentUser.nsbmEmail}',
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
                      '${snapshot.currentUser.nsbmId}',
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
                      '${snapshot.currentUser.universityEmail}',
                      style: subtitleStyle,
                    ),
                  ),
                  separator,
                  SizedBox(
                    height: 24,
                  ),
                  FlatButton(
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
            }
          ),
        ),
      ),
    );

    return MultiBlocListener(
      listeners: [
        BlocListener<LecturerProfileBloc, LecturerProfileState>(
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
