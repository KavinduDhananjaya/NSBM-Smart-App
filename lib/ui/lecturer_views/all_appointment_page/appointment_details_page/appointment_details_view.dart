import 'package:fcode_common/fcode_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_app/theme/styled_colors.dart';
import 'package:smart_app/ui/common/root_page/root_page.dart';

import 'appointment_details_bloc.dart';
import 'appointment_details_state.dart';

class AppointmentDetailsView extends StatelessWidget {
  static final log = Log("LectureAppointmentDetailsView");
  static final loadingWidget = Center(
    child: CircularProgressIndicator(),
  );

  final titleStyle = TextStyle(
    color: StyledColors.DARK_BLUE,
    fontSize: 20,
    fontWeight: FontWeight.w400,
  );

  final subtitleStyle = TextStyle(
    color: Colors.black.withOpacity(0.6),
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final lecture_appointment_detailsBloc =
        BlocProvider.of<AppointmentDetailsBloc>(context);
    // ignore: close_sinks
    final rootBloc = BlocProvider.of<RootBloc>(context);
    log.d("Loading LectureAppointmentDetails View");

    CustomSnackBar customSnackBar;
    final scaffold = Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: Text(
          "Appointments Details",
          style: TextStyle(
            color: StyledColors.DARK_GREEN,
            fontWeight: FontWeight.w500,
            fontSize: 24,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          width: double.infinity,
          child: Column(
            children: [
              SizedBox(
                height: 24,
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  "Purpose",
                  style: titleStyle,
                ),
                subtitle: Text(
                  " The passage is attributed to an unknown typesetter in the 15th century who is"
                  " thought to have scrambled parts of Cicero's De Finibus Bonorum et Malorum for use in a type specimen book.",
                  style: subtitleStyle,
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Row(
                children: [
                  Text(
                    "Date and Time",
                    style: titleStyle,
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Text(
                    "2012/12/11",
                    style: subtitleStyle,
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                textCapitalization: TextCapitalization.none,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(labelText: "Message"),
                onFieldSubmitted: (value) {},
                maxLines: 4,

              ),
              SizedBox(
                height: 48,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FlatButton(
                    onPressed: () {},
                    child: Text("Reject"),
                    color: StyledColors.LIGHT_GREEN,
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  FlatButton(
                      onPressed: () {},
                      child: Text("Confirm"),
                      color: StyledColors.PRIMARY_COLOR),
                ],
              ),
            ],
          ),
        ),
      ),
    );

    return MultiBlocListener(
      listeners: [
        BlocListener<AppointmentDetailsBloc,
            AppointmentDetailsState>(
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
