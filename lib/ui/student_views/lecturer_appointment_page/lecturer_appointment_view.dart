import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:fcode_common/fcode_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_app/db/model/user.dart';
import 'package:smart_app/theme/styled_colors.dart';
import 'package:smart_app/ui/common/root_page/root_page.dart';
import 'package:smart_app/ui/student_views/lecturer_appointment_page/lecturer_appointment_event.dart';
import 'package:smart_app/util/routes.dart';

import 'lecturer_appointment_bloc.dart';
import 'lecturer_appointment_state.dart';

class LectureAppointmentView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LectureAppointmentViewState();
}

class LectureAppointmentViewState extends State<LectureAppointmentView> {
  static final log = Log("LectureAppointmentView");
  static final loadingWidget = Center(
    child: CircularProgressIndicator(),
  );

  final _purposeController = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  CustomSnackBar customSnackBar;

  String faculty;
  String lecture;
  Timestamp date=Timestamp.now();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final lecture_appointmentBloc =
        BlocProvider.of<LectureAppointmentBloc>(context);
    // ignore: close_sinks
    final rootBloc = BlocProvider.of<RootBloc>(context);
    log.d("Loading LectureAppointment View");

    customSnackBar = CustomSnackBar(scaffoldKey: scaffoldKey);

    final scaffold = Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        brightness: Brightness.light,
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: Text(
          "Lecture Appointment",
          style: TextStyle(
            color: StyledColors.DARK_GREEN,
            fontWeight: FontWeight.w500,
            fontSize: 24,
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            SizedBox(
              height: 16,
            ),
            BlocBuilder<LectureAppointmentBloc, LectureAppointmentState>(
                buildWhen: (pre, current) => pre.type != current.type,
                builder: (context, state) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          Radio(
                            value: 1,
                            groupValue: state.type,
                            onChanged: (value) {
                              lecture_appointmentBloc
                                  .add(ChangeRoleEvent(value));
                            },
                            activeColor: StyledColors.PRIMARY_COLOR,
                          ),
                          Text('Student')
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                            value: 2,
                            groupValue: state.type,
                            onChanged: (value) {
                              lecture_appointmentBloc
                                  .add(ChangeRoleEvent(value));
                            },
                            activeColor: StyledColors.PRIMARY_COLOR,
                          ),
                          Text('Club or Organization')
                        ],
                      ),
                    ],
                  );
                }),
            SizedBox(
              height: 16,
            ),
            TextFormField(
              textCapitalization: TextCapitalization.none,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(labelText: "Purpose"),
              onFieldSubmitted: (value) {},
              controller: _purposeController,
            ),
            SizedBox(
              height: 16,
            ),
            DropdownSearch<String>(
              mode: Mode.DIALOG,
              maxHeight: 300,
              items: Routes.faculties,
              label: "Select Faculty",
              selectedItem: null,
              onChanged: (value) {
                setState(() {
                  faculty = value;
                });
              },
              showSearchBox: false,
              searchBoxDecoration: InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 0),
                labelText: "Search Faculty",
              ),
              showClearButton: true,
            ),
            SizedBox(
              height: 16,
            ),
            BlocBuilder<RootBloc, RootState>(
                buildWhen: (pre, current) => pre.allLecturers != current.allLecturers,
              builder: (context, snapshot) {

                final userList = List<User>.from(snapshot.allLecturers);

                final userNames = userList.map((e) => e.name).toList(growable: false);


                return DropdownSearch<String>(
                  mode: Mode.DIALOG,
                  maxHeight: 300,
                  items: userNames,
                  label: "Select Lecture",
                  selectedItem: null,
                  onChanged: (value) {
                    lecture = value;
                  },
                  showSearchBox: false,
                  searchBoxDecoration: InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 0),
                    labelText: "Search User",
                  ),
                  showClearButton: true,
                );
              }
            ),
            SizedBox(
              height: 16,
            ),
            DateTimePicker(
              type: DateTimePickerType.dateTimeSeparate,
              dateMask: 'd MMM, yyyy',
              initialValue: DateTime.now().toString(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
              dateLabelText: 'Date',
              timeLabelText: "Time",
              onChanged: (val) {
                final q = DateTime.parse(val);
                final a = Timestamp.fromDate(q);
                setState(() {
                  date = a;
                });
              },
              validator: (val) {
                print(val);
                return null;
              },
            ),
            SizedBox(
              height: 32,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancel"),
                  color: StyledColors.LIGHT_GREEN,
                ),
                SizedBox(
                  width: 16,
                ),
                FlatButton(
                  onPressed: () {
                    lecture_appointmentBloc.add(CreateLecturerRequest(
                      lecturer: lecture,
                      date: date,
                      purpose: _purposeController.text,
                      faculty: faculty,
                    ));
                  },
                  child: Text("Request"),
                  color: StyledColors.PRIMARY_COLOR,
                ),
              ],
            ),
          ],
        ),
      ),
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
        BlocListener<LectureAppointmentBloc, LectureAppointmentState>(
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
