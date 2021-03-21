import 'package:date_time_picker/date_time_picker.dart';
import 'package:fcode_common/fcode_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_app/db/model/lecturer_request.dart';
import 'package:smart_app/theme/styled_colors.dart';
import 'package:smart_app/ui/common/root_page/root_page.dart';
import 'package:smart_app/ui/lecturer_views/all_appointment_page/appointment_details_page/appointment_details_page.dart';

import 'appointment_details_bloc.dart';
import 'appointment_details_state.dart';

class AppointmentDetailsView extends StatefulWidget {
  final LectureRequest request;

  AppointmentDetailsView({
    Key key,
    @required this.request,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => AppointmentDetailsViewState();
}

class AppointmentDetailsViewState extends State<AppointmentDetailsView> {
  static final log = Log("LectureAppointmentDetailsView");
  static final loadingWidget = Center(
    child: CircularProgressIndicator(),
  );

  final _msgController = TextEditingController();
  CustomSnackBar customSnackBar;
  final scaffoldKey = GlobalKey<ScaffoldState>();

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

    if (widget.request == null) {
      return loadingWidget;
    }

    customSnackBar = CustomSnackBar(scaffoldKey: scaffoldKey);

    final dueDate =
        DateFormat("dd/MM/yyyy").format(widget.request.date.toDate());
    final dueTime = new DateFormat.jm().format(widget.request.date.toDate());

    final scaffold = Scaffold(
      key: scaffoldKey,
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
                  widget.request.purpose,
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
                    "${dueDate}  ${dueTime}",
                    style: subtitleStyle,
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              widget.request.state == "pending"?TextFormField(
                textCapitalization: TextCapitalization.none,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(labelText: "Message"),
                onFieldSubmitted: (value) {},
                controller: _msgController,
                maxLines: 4,
              ):ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  "Message",
                  style: titleStyle,
                ),
                subtitle: Text(
                  widget.request.message==null?" ":widget.request.message,
                  style: subtitleStyle,
                ),
              ),
              SizedBox(
                height: 48,
              ),
              widget.request.state == "pending"
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FlatButton(
                          onPressed: () {
                            lecture_appointment_detailsBloc
                                .add(RejectEvent(widget.request));
                          },
                          child: Text("Reject"),
                          color: StyledColors.LIGHT_GREEN,
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        FlatButton(
                            onPressed: () {
                              lecture_appointment_detailsBloc.add(
                                ConfirmEvent(
                                    widget.request, _msgController.text),
                              );
                            },
                            child: Text("Confirm"),
                            color: StyledColors.PRIMARY_COLOR),
                      ],
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );

    return MultiBlocListener(
      listeners: [
        BlocListener<AppointmentDetailsBloc, AppointmentDetailsState>(
          listenWhen: (pre, current) => pre.error != current.error,
          listener: (context, state) {
            if (state.error?.isNotEmpty ?? false) {
              customSnackBar?.showErrorSnackBar(state.error);
            } else {
              customSnackBar?.hideAll();
            }
          },
        ),
        BlocListener<AppointmentDetailsBloc, AppointmentDetailsState>(
          listenWhen: (pre, current) => pre.state != current.state,
          listener: (context, state) {
            if (state.state == 1) {
              customSnackBar?.showLoadingSnackBar(
                  backgroundColor: StyledColors.PRIMARY_COLOR);
            } else if (state.state == 2) {
              customSnackBar?.hideAll();
              Navigator.pop(context);
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
