import 'package:fcode_common/fcode_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_app/theme/styled_colors.dart';
import 'package:smart_app/ui/common/map_page/map_provider.dart';
import 'package:smart_app/ui/common/root_page/root_page.dart';
import 'package:smart_app/ui/lecturer_views/all_appointment_page/all_appointment_page.dart';
import 'package:smart_app/ui/lecturer_views/lecturer_hall_booking_page/lecturer_hall_booking_page.dart';
import 'package:smart_app/ui/student_views/time_table_page/time_table_page.dart';
import 'package:smart_app/ui/widgets/home_page_app_bar.dart';

import 'lecturer_home_bloc.dart';
import 'lecturer_home_state.dart';

class LecturerHomeView extends StatelessWidget {
  static final log = Log("LectureHomeView");
  static final loadingWidget = Center(
    child: CircularProgressIndicator(),
  );

  final textStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.w600,color: StyledColors.DARK_GREEN);

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final lecture_homeBloc = BlocProvider.of<LecturerHomeBloc>(context);
    // ignore: close_sinks
    final rootBloc = BlocProvider.of<RootBloc>(context);
    log.d("Loading LectureHome View");

    CustomSnackBar customSnackBar;
    final scaffold = Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 80),
        child: BlocBuilder<RootBloc, RootState>(
            buildWhen: (pre, current) => pre.currentUser != current.currentUser,
            builder: (context, snapshot) {
              final user = snapshot.currentUser;

              return HomePageAppBar(
                firstName: user.name,
                lastName: " ",
                profileImage: user.profileImage,
              );
            }),
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              "assets/images/main_top.png",
              color: Colors.lightGreen.withOpacity(0.4),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
              "assets/images/login_bottom.png",
              color: Colors.lightGreen.withOpacity(0.2),

            ),
          ),
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            padding: EdgeInsets.only(top: 24),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TimeTableProvider(),
                            fullscreenDialog: true,
                          ));
                    },
                    child: Card(
                      elevation: 5,
                      shadowColor: StyledColors.PRIMARY_COLOR,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                                StyledColors.LIGHT_GREEN.withOpacity(0.3),
                                StyledColors.PRIMARY_COLOR.withOpacity(0.7),
                              ],
                            ),
                            border: Border.all(
                              color: StyledColors.PRIMARY_COLOR,
                            ),
                            borderRadius: BorderRadius.circular(10)),
                        padding: EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              "Timetable",
                              style: textStyle,
                            ),
                            Icon(
                              Icons.table_chart,
                              color: StyledColors.DARK_GREEN,
                              size: 50,
                            ),
                            SizedBox(
                              width: 4,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            GestureDetector(
                              child: Card(
                                elevation: 5,
                                shadowColor: StyledColors.PRIMARY_COLOR,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topRight,
                                        end: Alignment.bottomLeft,
                                        colors: [
                                          StyledColors.LIGHT_GREEN.withOpacity(0.3),
                                          StyledColors.PRIMARY_COLOR.withOpacity(0.7),
                                        ],
                                      ),
                                      border: Border.all(
                                        color: StyledColors.PRIMARY_COLOR,
                                      ),
                                      borderRadius: BorderRadius.circular(10)),
                                  width: double.infinity,
                                  height: 130,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 16, horizontal: 16),
                                  child: Column(
                                    children: [
                                      Text(
                                        "Hall Booking",
                                        style: textStyle,
                                      ),
                                      Icon(
                                        Icons.view_compact_outlined,
                                        color: StyledColors.DARK_GREEN,
                                        size: 50,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            LecturerHallBookingProvider(),
                                        fullscreenDialog: true));
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                          child: Column(
                        children: [
                          GestureDetector(
                            child: Card(
                              shadowColor: StyledColors.PRIMARY_COLOR,
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topRight,
                                      end: Alignment.bottomLeft,
                                      colors: [
                                        StyledColors.LIGHT_GREEN.withOpacity(0.3),
                                        StyledColors.PRIMARY_COLOR.withOpacity(0.7),
                                      ],
                                    ),
                                    border: Border.all(
                                      color: StyledColors.PRIMARY_COLOR,
                                    ),
                                    borderRadius: BorderRadius.circular(10)),
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(
                                    vertical: 16, horizontal: 16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Lecture Appointment",
                                        style: textStyle,
                                      ),
                                    ),
                                    Icon(
                                      Icons.event_available_outlined,
                                      color: StyledColors.DARK_GREEN,
                                      size: 50,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AllAppointmentProvider(),
                                      fullscreenDialog: true));
                            },
                          ),
                        ],
                      )),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MapProvider(),
                            fullscreenDialog: true),
                      );
                    },
                    child: Card(
                      elevation: 5,
                      shadowColor: StyledColors.PRIMARY_COLOR,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                                StyledColors.LIGHT_GREEN.withOpacity(0.3),
                                StyledColors.PRIMARY_COLOR.withOpacity(0.7),
                              ],
                            ),
                            border: Border.all(
                              color: StyledColors.PRIMARY_COLOR,
                            ),
                            borderRadius: BorderRadius.circular(10)),
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                        child: Column(
                          children: [
                            Text(
                              "University Map",
                              style: textStyle,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Icon(
                              Icons.map,
                              color: StyledColors.DARK_GREEN,
                              size: 50,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

    return MultiBlocListener(
      listeners: [
        BlocListener<LecturerHomeBloc, LecturerHomeState>(
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
