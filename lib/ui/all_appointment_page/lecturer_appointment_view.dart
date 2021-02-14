import 'package:fcode_common/fcode_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_app/theme/styled_colors.dart';
import 'package:smart_app/ui/root_page/root_page.dart';
import 'package:smart_app/ui/widgets/hall_booking_card.dart';

import 'lecturer_appointment_bloc.dart';
import 'lecturer_appointment_state.dart';

class LecturerAppointmentView extends StatelessWidget {
  static final log = Log("LecturerAppointmentView");
  static final loadingWidget = Center(
    child: CircularProgressIndicator(),
  );

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final lecturer_appointmentBloc =
        BlocProvider.of<LecturerAppointmentBloc>(context);
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
      body: BlocBuilder<LecturerAppointmentBloc, LecturerAppointmentState>(
          buildWhen: (pre, current) => true,
          builder: (context, state) {
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
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: StyledColors.PRIMARY_COLOR)),
                          height: 20,
                          width: 80,
                          child: Center(
                            child: Text("All"),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: StyledColors.PRIMARY_COLOR)),
                          height: 20,
                          width: 80,
                          child: Center(
                            child: Text("Confirmed"),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: StyledColors.PRIMARY_COLOR)),
                          height: 20,
                          width: 80,
                          child: Center(
                            child: Text("Pending"),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: StyledColors.PRIMARY_COLOR)),
                          height: 20,
                          width: 80,
                          child: Center(
                            child: Text("Reject"),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  HallBookingCard(
                    type: 0,
                    action: 1,
                  ),
                  HallBookingCard(
                    type: 1,
                    action: 1,
                  ),
                  HallBookingCard(
                    type: 1,
                    action: 1,
                  ),
                  HallBookingCard(
                    type: 3,
                    action: 1,
                  )
                ],
              ),
            );
          }),
    );

    return MultiBlocListener(
      listeners: [
        BlocListener<LecturerAppointmentBloc, LecturerAppointmentState>(
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
