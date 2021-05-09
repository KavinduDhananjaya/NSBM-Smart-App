import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:fcode_bloc/fcode_bloc.dart';
import 'package:fcode_common/fcode_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_app/db/model/user.dart';
import 'package:smart_app/db/repository/user_repository.dart';
import 'package:smart_app/theme/styled_colors.dart';
import 'package:smart_app/ui/common/root_page/root_page.dart';

import 'time_table_bloc.dart';
import 'time_table_state.dart';

class TimeTableView extends StatelessWidget {
  static final log = Log("TimeTableView");
  static final loadingWidget = Center(
    child: CircularProgressIndicator(),
  );

  final addon = RepositoryAddon(repository: new UserRepository());

  Future<User> getUser(DocumentReference ref) async {
    final user = await addon.fetch(ref: ref);
    return user;
  }

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final time_tableBloc = BlocProvider.of<TimeTableBloc>(context);
    // ignore: close_sinks
    final rootBloc = BlocProvider.of<RootBloc>(context);
    log.d("Loading TimeTable View");

    CustomSnackBar customSnackBar;
    final scaffold = Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: Text(
          "Timetable",
          style: TextStyle(
            color: StyledColors.DARK_BLUE,
            fontWeight: FontWeight.w500,
            fontSize: 24,
          ),
        ),
      ),
      body: BlocBuilder<RootBloc, RootState>(
          buildWhen: (pre, current) =>
              pre.todayTimetable != current.todayTimetable,
          builder: (context, state) {

            if (state.todayTimetable == null) {
              return Center(child: Text("No Today TimeTable"));
            }

            List<DataRow> rows = [];
            for (int i = 0; i < state.todayTimetable.content.length; i++) {
              final cotent = state.todayTimetable.content[i];

              final time = new DateFormat.jm().format(cotent['time'].toDate()??DateTime.now());

              final dataRow = DataRow(cells: [
                DataCell(
                  Text(cotent['module']),
                ),
                DataCell(
                  Text(cotent['batch']),
                ),
                DataCell(
                  Text(cotent['hallNumber']),
                ),
                DataCell(
                  FutureBuilder(
                    future: getUser(cotent['lecturer']),
                    builder: (context, snapshot) {
                      return Text(
                        snapshot.hasData ? snapshot.data.name : "-",
                      );
                    }, // The widget using the data
                  ),
                ),
                DataCell(
                  Text(time),
                ),
              ]);

              rows.add(dataRow);
            }

            return Container(
              width: double.infinity,
              margin: EdgeInsets.all(0),
              child: Scrollbar(
                child: DataTable(
                  columnSpacing: 2,
                  dataRowHeight: 50,
                  dividerThickness: 2,
                  columns: [
                    DataColumn(
                        label: Text('Module',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Batch',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Hall',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Lecturer',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Time',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold))),
                  ],
                  rows: rows,
                ),
              ),
            );
          }),
    );

    return MultiBlocListener(
      listeners: [
        BlocListener<TimeTableBloc, TimeTableState>(
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
