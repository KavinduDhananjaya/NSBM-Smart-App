import 'package:fcode_common/fcode_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_app/ui/root_page/root_page.dart';

import 'lecture_appointment_details_bloc.dart';
import 'lecture_appointment_details_state.dart';

class LectureAppointmentDetailsView extends StatelessWidget {
  static final log = Log("LectureAppointmentDetailsView");
  static final loadingWidget = Center(
    child: CircularProgressIndicator(),
  );

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final lecture_appointment_detailsBloc = BlocProvider.of<LectureAppointmentDetailsBloc>(context);
    // ignore: close_sinks
    final rootBloc = BlocProvider.of<RootBloc>(context);
    log.d("Loading LectureAppointmentDetails View");

    CustomSnackBar customSnackBar;
    final scaffold = Scaffold(
      body: BlocBuilder<LectureAppointmentDetailsBloc, LectureAppointmentDetailsState>(
          buildWhen: (pre, current) => true,
          builder: (context, state) {
            return Center(
              child: Text("HI..."),
            );
          }),
    );

    return MultiBlocListener(
      listeners: [
        BlocListener<LectureAppointmentDetailsBloc, LectureAppointmentDetailsState>(
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
