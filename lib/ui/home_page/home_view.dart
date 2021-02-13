import 'package:fcode_common/fcode_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_app/ui/hall_booking_page/hall_booking_page.dart';
import 'package:smart_app/ui/lecture_appointment_page/lecture_appointment_page.dart';
import 'package:smart_app/ui/root_page/root_page.dart';
import 'package:smart_app/ui/widgets/home_page_app_bar.dart';

import 'home_bloc.dart';
import 'home_state.dart';

class HomeView extends StatelessWidget {
  static final log = Log("HomeView");
  static final loadingWidget = Center(
    child: CircularProgressIndicator(),
  );

  final textStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.w600);

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
        child: HomePageAppBar(
          firstName: "John",
          lastName: "Silva",
        ),
      ),
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        padding: EdgeInsets.only(top: 24),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
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
                        color: Colors.grey,
                        size: 50,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                    ],
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
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                              width: double.infinity,
                              height: 120,
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
                                    color: Colors.grey,
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
                                    builder: (context) => HallBookingProvider(),fullscreenDialog: true));
                          },
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container(
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
                                  height: 8,
                                ),
                                Icon(
                                  Icons.event,
                                  color: Colors.grey,
                                  size: 50,
                                ),
                              ],
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
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container(
                            width: double.infinity,
                            padding:
                                EdgeInsets.symmetric(vertical: 16, horizontal: 16),
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
                                  color: Colors.grey,
                                  size: 50,
                                ),
                              ],
                            ),
                          ),
                        ),
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LectureAppointmentProvider(),fullscreenDialog: true));
                        },
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container(
                          width: double.infinity,
                          padding:
                              EdgeInsets.symmetric(vertical: 16, horizontal: 16),
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
                                color: Colors.grey,
                                size: 50,
                              ),
                            ],
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
