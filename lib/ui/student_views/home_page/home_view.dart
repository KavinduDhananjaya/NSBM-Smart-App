import 'package:fcode_common/fcode_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_app/theme/styled_colors.dart';
import 'package:smart_app/ui/common/map_page/map_page.dart';
import 'package:smart_app/ui/common/root_page/root_page.dart';
import 'package:smart_app/ui/student_views/events_page/events_page.dart';
import 'package:smart_app/ui/student_views/hall_booking_page/hall_booking_page.dart';
import 'package:smart_app/ui/student_views/lecturer_appointment_page/lecturer_appointment_page.dart';
import 'package:smart_app/ui/student_views/time_table_page/time_table_page.dart';
import 'package:smart_app/ui/widgets/home_page_app_bar.dart';
import 'package:url_launcher/url_launcher.dart';

import 'home_bloc.dart';
import 'home_state.dart';

class HomeView extends StatelessWidget {
  static final log = Log("HomeView");
  static final loadingWidget = Center(
    child: CircularProgressIndicator(),
  );

  final textStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.w600,color: StyledColors.DARK_GREEN);

  void _launchURL(String url) async =>
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final homeBloc = BlocProvider.of<HomeBloc>(context);
    // ignore: close_sinks
    final rootBloc = BlocProvider.of<RootBloc>(context);
    log.d("Loading Home View");

    CustomSnackBar customSnackBar;
    final scaffold = Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 80),
        child: BlocBuilder<RootBloc, RootState>(
            buildWhen: (previous, current) =>
                previous.currentUser != current.currentUser,
            builder: (context, state) {
              return HomePageAppBar(
                firstName: "${state.currentUser.name}",
                lastName: " ",
                profileImage: state.currentUser.profileImage,
              );
            }),
      ),
      body: Container(
        width: double.infinity,
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
                        fullscreenDialog: true),
                  );
                },
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  shadowColor: StyledColors.PRIMARY_COLOR,
                  child: Container(
                    decoration: BoxDecoration(
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
                height: 24,
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        GestureDetector(
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            shadowColor: StyledColors.PRIMARY_COLOR,
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: StyledColors.PRIMARY_COLOR),
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
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Icon(
                                    Icons.view_compact_outlined,
                                    color: StyledColors.DARK_GREEN,
                                    size: 60,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HallBookingProvider(),
                                    fullscreenDialog: true));
                          },
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EventsProvider(),
                                    fullscreenDialog: true));
                          },
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            shadowColor: StyledColors.PRIMARY_COLOR,
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: StyledColors.PRIMARY_COLOR,
                                  ),
                                  borderRadius: BorderRadius.circular(10)),
                              height: 130,
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 16),
                              child: Column(
                                children: [
                                  Text(
                                    "Events",
                                    style: textStyle,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Icon(
                                    Icons.event,
                                    color: StyledColors.DARK_GREEN,
                                    size: 60,
                                  ),
                                ],
                              ),
                            ),
                          ),
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
                                border: Border.all(
                                  color: StyledColors.PRIMARY_COLOR,
                                ),
                                borderRadius: BorderRadius.circular(10)),
                            width: double.infinity,
                            height: 130,
                            padding: EdgeInsets.symmetric(
                                vertical: 12, horizontal: 16),
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
                                      LectureAppointmentProvider(),
                                  fullscreenDialog: true));
                        },
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      GestureDetector(
                        onTap: () {
                          // _launchURL(
                          //     "https://www.google.lk/maps/place/NSBM+Green+University+Town/@6.8212859,80.0398974,17.75z/data=!4m5!3m4!1s0x3ae2523b05555555:0x546c34cd99f6f488!8m2!3d6.8213291!4d80.0415729");
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
                  )),
                ],
              ),
            ],
          ),
        ),
      ),
    );

    return MultiBlocListener(
      listeners: [
        BlocListener<HomeBloc, HomeState>(
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
