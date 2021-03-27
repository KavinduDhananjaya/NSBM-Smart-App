import 'package:fcode_common/fcode_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_app/theme/styled_colors.dart';
import 'package:smart_app/ui/common/root_page/root_page.dart';
import 'package:smart_app/ui/lecturer_views/all_appointment_page/appointment_details_page/appointment_details_page.dart';
import 'package:smart_app/ui/widgets/hall_booking_card.dart';

import 'all_appointment_bloc.dart';
import 'all_appointment_state.dart';

class AllAppointmentView extends StatelessWidget {
  static final log = Log("LecturerAppointmentView");
  static final loadingWidget = Center(
    child: CircularProgressIndicator(),
  );

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final lecturer_appointmentBloc =
        BlocProvider.of<AllAppointmentBloc>(context);
    // ignore: close_sinks
    final rootBloc = BlocProvider.of<RootBloc>(context);
    log.d("Loading LecturerAppointment View");

    CustomSnackBar customSnackBar;
    final scaffold = Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: Text(
          "Lecturer Appointment",
          style: TextStyle(
            color: StyledColors.DARK_GREEN,
            fontWeight: FontWeight.w500,
            fontSize: 24,
          ),
        ),
      ),
      body: BlocBuilder<RootBloc, RootState>(
          buildWhen: (pre, current) =>
              pre.allLecturerRequests != current.allLecturerRequests ||
              pre.showingType != current.showingType,
          builder: (context, state) {
            List<Widget> all = [];
            List<Widget> pending = [];
            List<Widget> assigned = [];
            List<Widget> reject = [];

            if (state.allLecturerRequests == null) {
              return loadingWidget;
            }

            if (state.showingType == RootState.ALL) {
              for (int i = 0; i < state.allLecturerRequests.length; i++) {
                final request = state.allLecturerRequests[i];
                final card = CommonBookingCard(
                  type: request.state == "pending"
                      ? 2
                      : request.state == "assigned"
                          ? 0
                          : 1,
                  purpose: request.purpose,
                  addedUser: request.requestedBy,
                  addedTime: request.requestedAt,
                  isHallReq: false,
                  requestedDate: request.date,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AppointmentDetailsProvider(
                          request: request,
                        ),
                        fullscreenDialog: true,
                      ),
                    );
                  },
                );
                all.add(card);
              }

              if (all.isEmpty) {
                all.add(
                  Column(
                    children: [
                      SizedBox(
                        height: 100,
                      ),
                      Text("No Requests ..."),
                    ],
                  ),
                );
              }
            } else if (state.showingType == RootState.PENDING) {
              for (int i = 0; i < state.allLecturerRequests.length; i++) {
                final request = state.allLecturerRequests[i];

                if (request.state == "pending") {
                  final card = CommonBookingCard(
                    type: request.state == "pending"
                        ? 2
                        : request.state == "assigned"
                            ? 0
                            : 1,
                    purpose: request.purpose,
                    addedUser: request.requestedBy,
                    addedTime: request.requestedAt,
                    isHallReq: false,
                    requestedDate: request.date,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AppointmentDetailsProvider(
                            request: request,
                          ),
                          fullscreenDialog: true,
                        ),
                      );
                    },
                  );

                  pending.add(card);
                }
              }
            } else if (state.showingType == RootState.ASSIGNED) {
              for (int i = 0; i < state.allLecturerRequests.length; i++) {
                final request = state.allLecturerRequests[i];

                if (request.state == "assigned") {
                  final card = CommonBookingCard(
                    type: request.state == "pending"
                        ? 2
                        : request.state == "assigned"
                            ? 0
                            : 1,
                    purpose: request.purpose,
                    addedUser: request.requestedBy,
                    addedTime: request.requestedAt,
                    isHallReq: false,
                    requestedDate: request.date,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AppointmentDetailsProvider(
                            request: request,
                          ),
                          fullscreenDialog: true,
                        ),
                      );
                    },
                  );
                  assigned.add(card);
                }
              }
            } else {
              for (int i = 0; i < state.allLecturerRequests.length; i++) {
                final request = state.allLecturerRequests[i];

                if (request.state == "rejected") {
                  final card = CommonBookingCard(
                    type: request.state == "pending"
                        ? 2
                        : request.state == "assigned"
                            ? 0
                            : 1,
                    purpose: request.purpose,
                    addedUser: request.requestedBy,
                    addedTime: request.requestedAt,
                    isHallReq: false,
                    requestedDate: request.date,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AppointmentDetailsProvider(
                            request: request,
                          ),
                          fullscreenDialog: true,
                        ),
                      );
                    },
                  );
                  reject.add(card);
                }
              }
            }

            if (pending.isEmpty) {
              pending.add(
                Column(
                  children: [
                    SizedBox(
                      height: 100,
                    ),
                    Text("No Requests ..."),
                  ],
                ),
              );
            }

            if (assigned.isEmpty) {
              assigned.add(
                Column(
                  children: [
                    SizedBox(
                      height: 100,
                    ),
                    Text("No Requests ..."),
                  ],
                ),
              );
            }

            if (reject.isEmpty) {
              reject.add(
                Column(
                  children: [
                    SizedBox(
                      height: 100,
                    ),
                    Text(
                      "No Requests ...",
                    ),
                  ],
                ),
              );
            }

            return Container(
              width: double.infinity,
              child: Column(
                children: [
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    height: 30,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        GestureDetector(
                          onTap: () {
                            rootBloc.add(ChangeShowingType(RootState.ALL));
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 14, right: 6),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: StyledColors.PRIMARY_COLOR),
                                color: state.showingType == RootState.ALL
                                    ? StyledColors.LIGHT_GREEN
                                    : null),
                            height: 20,
                            width: 80,
                            child: Center(
                              child: Text("All"),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            rootBloc.add(ChangeShowingType(RootState.PENDING));
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 6),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: StyledColors.PRIMARY_COLOR),
                                color: state.showingType == RootState.PENDING
                                    ? StyledColors.LIGHT_GREEN
                                    : null),
                            height: 20,
                            width: 80,
                            child: Center(
                              child: Text("Pending"),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            rootBloc.add(ChangeShowingType(RootState.ASSIGNED));
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 6),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: StyledColors.PRIMARY_COLOR),
                                color: state.showingType == RootState.ASSIGNED
                                    ? StyledColors.LIGHT_GREEN
                                    : null),
                            height: 20,
                            width: 80,
                            child: Center(
                              child: Text("Confirmed"),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            rootBloc.add(ChangeShowingType(RootState.REJECT));
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 6),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: StyledColors.PRIMARY_COLOR),
                                color: state.showingType == RootState.REJECT
                                    ? StyledColors.LIGHT_GREEN
                                    : null),
                            height: 20,
                            width: 80,
                            child: Center(
                              child: Text("Reject"),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  Expanded(
                    child: ListView(
                      children: state.showingType == RootState.ALL
                          ? all
                          : state.showingType == RootState.PENDING
                              ? pending
                              : state.showingType == RootState.ASSIGNED
                                  ? assigned
                                  : state.showingType == RootState.REJECT
                                      ? reject
                                      : [],
                    ),
                  ),
                ],
              ),
            );
          }),
    );

    return MultiBlocListener(
      listeners: [
        BlocListener<AllAppointmentBloc, AllAppointmentState>(
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
