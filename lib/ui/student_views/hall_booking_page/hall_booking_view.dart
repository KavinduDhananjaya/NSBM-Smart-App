import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:fcode_common/fcode_common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_app/db/model/hall.dart';
import 'package:smart_app/db/model/user.dart';
import 'package:smart_app/theme/styled_colors.dart';
import 'package:smart_app/ui/common/hall_info_view/hall_info_view.dart';
import 'package:smart_app/ui/common/root_page/root_bloc.dart';
import 'package:smart_app/ui/common/root_page/root_state.dart';
import 'package:smart_app/ui/student_views/hall_booking_page/hall_booking_event.dart';
import 'package:smart_app/util/routes.dart';
import 'hall_booking_bloc.dart';
import 'hall_booking_state.dart';

class HallBookingView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HallBookingViewState();
}

class HallBookingViewState extends State<HallBookingView> {
  static final log = Log("HallBookingView");
  static final loadingWidget = Center(
    child: CircularProgressIndicator(),
  );

  final _purposeController = TextEditingController();
  final _capacityController = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  CustomSnackBar customSnackBar;

  FocusNode _purposeFocus;
  FocusNode _capacityFocus;
  FocusNode _nameFocus;
  FocusNode _passwordFocus;
  FocusNode _confirmPasswordFocus;

  @override
  void initState() {
    super.initState();
    _purposeFocus = FocusNode();
    _capacityFocus = FocusNode();
    _nameFocus = FocusNode();
    _passwordFocus = FocusNode();
    _confirmPasswordFocus = FocusNode();
  }

  @override
  void dispose() {
    _purposeFocus.dispose();
    _capacityFocus?.dispose();
    _purposeController.dispose();
    _passwordFocus?.dispose();
    _confirmPasswordFocus.dispose();
    _nameFocus.dispose();
    super.dispose();
  }

  String faculty;
  String hall;
  String lecturer;
  Timestamp date=Timestamp.now();

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final hall_bookingBloc = BlocProvider.of<HallBookingBloc>(context);
    // ignore: close_sinks
    final rootBloc = BlocProvider.of<RootBloc>(context);
    log.d("Loading HallBooking View");

    customSnackBar = CustomSnackBar(scaffoldKey: scaffoldKey);

    final scaffold = Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        brightness: Brightness.light,
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: true,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HallInfoView(),
                    fullscreenDialog: true),
              );
            },
          ),
        ],
        title: Text(
          "Hall Booking",
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
            BlocBuilder<HallBookingBloc, HallBookingState>(
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
                              hall_bookingBloc.add(ChangeRoleEvent(value));
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
                              hall_bookingBloc.add(ChangeRoleEvent(value));
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
              showSearchBox: true,
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
            TextFormField(
              textCapitalization: TextCapitalization.none,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Capacity"),
              onFieldSubmitted: (value) {},
              controller: _capacityController,
            ),
            SizedBox(
              height: 16,
            ),
            BlocBuilder<RootBloc, RootState>(
                buildWhen: (pre, current) => pre.allHalls != current.allHalls,
                builder: (context, snapshot) {
                  final hallList = List<Hall>.from(snapshot.allHalls);

                  final hallNumbers =
                      hallList.map((e) => e.hallNumber).toList(growable: false);

                  return DropdownSearch<String>(
                    mode: Mode.DIALOG,
                    maxHeight: 300,
                    items: hallNumbers
                        .map((e) => e.toString())
                        .toList(growable: false),
                    label: "Available Halls",
                    selectedItem: null,
                    onChanged: (value) {
                      setState(() {
                        hall = value;
                      });
                    },
                    showSearchBox: true,
                    searchBoxDecoration: InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 0),
                      labelText: "Search Hall",
                    ),
                    showClearButton: true,
                  );
                }),
            SizedBox(
              height: 16,
            ),
            BlocBuilder<RootBloc, RootState>(
                buildWhen: (pre, current) =>
                    pre.allLecturers != current.allLecturers,
                builder: (context, snapshot) {
                  final userList = List<User>.from(snapshot.allLecturers);

                  final userNames =
                      userList.map((e) => e.name).toList(growable: false);

                  return DropdownSearch<String>(
                    mode: Mode.DIALOG,
                    maxHeight: 300,
                    items: userNames,
                    label: "Select Lecture",
                    selectedItem: null,
                    onChanged: (value) {
                      lecturer = value;
                    },
                    showSearchBox: true,
                    searchBoxDecoration: InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 0),
                      labelText: "Search User",
                    ),
                    showClearButton: true,
                  );
                }),
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
                      hall_bookingBloc.add(
                        CreateHallRequestEvent(
                          purpose: _purposeController.text,
                          capacity: _capacityController.text.isEmpty
                              ? 0
                              : int.parse(_capacityController.text ?? 0),
                          faculty: faculty,
                          date: date,
                          lecturer: lecturer,
                          hall: hall,
                        ),
                      );
                    },
                    child: Text("Request"),
                    color: StyledColors.PRIMARY_COLOR),
              ],
            ),
          ],
        ),
      ),
    );

    return MultiBlocListener(
      listeners: [
        BlocListener<HallBookingBloc, HallBookingState>(
          listenWhen: (pre, current) => pre.error != current.error,
          listener: (context, state) {
            if (state.error?.isNotEmpty ?? false) {
              customSnackBar?.showErrorSnackBar(state.error);
            } else {
              customSnackBar?.hideAll();
            }
          },
        ),
        BlocListener<HallBookingBloc, HallBookingState>(
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
