import 'package:fcode_common/fcode_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_app/ui/root_page/root_page.dart';

import 'lecture_appointment_bloc.dart';
import 'lecture_appointment_state.dart';

class LectureAppointmentView extends StatelessWidget {
  static final log = Log("LectureAppointmentView");
  static final loadingWidget = Center(
    child: CircularProgressIndicator(),
  );

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final lecture_appointmentBloc = BlocProvider.of<LectureAppointmentBloc>(context);
    // ignore: close_sinks
    final rootBloc = BlocProvider.of<RootBloc>(context);
    log.d("Loading LectureAppointment View");

    CustomSnackBar customSnackBar;
    final scaffold = Scaffold(
      appBar: AppBar(
        title: Text("Hall Booking"),
      ),
      body: Container(),
    );

    return MultiBlocListener(
      listeners: [
        BlocListener<LectureAppointmentBloc, LectureAppointmentState>(
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
