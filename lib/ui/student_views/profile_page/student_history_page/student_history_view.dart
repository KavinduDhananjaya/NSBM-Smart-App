import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcode_bloc/fcode_bloc.dart';
import 'package:fcode_common/fcode_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_app/db/model/user.dart';
import 'package:smart_app/db/repository/hall_repository.dart';
import 'package:smart_app/db/repository/user_repository.dart';
import 'package:smart_app/theme/styled_colors.dart';
import 'package:smart_app/ui/common/root_page/root_bloc.dart';

import 'student_history_bloc.dart';
import 'student_history_state.dart';

class StudentHistoryView extends StatelessWidget {
  static final log = Log("StudentHistoryView");
  static final loadingWidget = Center(
    child: CircularProgressIndicator(),
  );

  final addon = RepositoryAddon(repository: new UserRepository());

  Future<User> getUser(DocumentReference ref) async {
    final user = await addon.fetch(ref: ref);
    return user;
  }

  final hallAddon = RepositoryAddon(repository: new HallRepository());

  Future<int> getHall(DocumentReference ref) async {
    final hall = await hallAddon.fetch(ref: ref);
    return hall.hallNumber;
  }

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final student_historyBloc = BlocProvider.of<StudentHistoryBloc>(context);
    // ignore: close_sinks
    final rootBloc = BlocProvider.of<RootBloc>(context);
    log.d("Loading StudentHistory View");

    CustomSnackBar customSnackBar;
    final scaffold = Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: Text(
          "Student History",
          style: TextStyle(
            color: StyledColors.DARK_GREEN,
            fontWeight: FontWeight.w500,
            fontSize: 24,
          ),
        ),
      ),
      body: BlocBuilder<StudentHistoryBloc, StudentHistoryState>(
          buildWhen: (pre, current) =>
              pre.allHallRequests != current.allHallRequests ||
              pre.allLecturerRequests != current.allLecturerRequests,
          builder: (context, state) {
            if (state.allLecturerRequests == null ||
                state.allHallRequests == null) {
              return loadingWidget;
            }

            List<Widget> child1 = [];
            List<Widget> child2 = [];

            for (int i = 0; i < state.allHallRequests.length; i++) {
              final request = state.allHallRequests[i];

              final card = Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: StyledColors.PRIMARY_COLOR.withOpacity(0.4),
                ),
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  title: Text(
                    "Hall Request",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Purpose : ${request.purpose}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54,
                        ),
                      ),
                      Text(
                        "Current State : ${request.state == "assigned" ? "Request in Confirmed." : request.state == "pending" ? "Request is Pending" : "Request is Rejected."}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54,
                        ),
                      ),
                      Text(
                        "Faculty : ${request.faculty}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54,
                        ),
                      ),
                      FutureBuilder(
                        future: getHall(request.hall),
                        builder: (context, snapshot) {
                          return Text(
                            snapshot.hasData
                                ? "Requested Hall : ${snapshot.data.toString()}"
                                : "-",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black54,
                            ),
                          );
                        }, // The widget using the data
                      ),
                    ],
                  ),
                ),
              );
              child1.add(card);
            }

            for (int i = 0; i < state.allLecturerRequests.length; i++) {
              final request = state.allLecturerRequests[i];

              final card = Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: StyledColors.PRIMARY_COLOR.withOpacity(0.4),
                ),
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  title: Text(
                    "Lecturer Request",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Purpose : ${request.purpose}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54,
                        ),
                      ),
                      Text(
                        "Current State : ${request.state == "assigned" ? "Request in Confirmed." : request.state == "pending" ? "Request is Pending" : "Request is Rejected."}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54,
                        ),
                      ),
                      Text(
                        "Faculty : ${request.faculty}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54,
                        ),
                      ),
                      FutureBuilder(
                        future: getUser(request.assigned),
                        builder: (context, snapshot) {
                          return Text(
                            snapshot.hasData
                                ? "Requested Lecturer : ${snapshot.data.name}"
                                : "-",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black54,
                            ),
                          );
                        }, // The widget using the data
                      ),
                    ],
                  ),
                ),
              );
              child2.add(card);
            }

            return Column(
              children: [
                SizedBox(
                  height: 24,
                ),
                Expanded(
                  child: ListView(
                    children: [
                      Column(
                        children: child1,
                      ),
                      Column(
                        children: child2,
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
    );

    return MultiBlocListener(
      listeners: [
        BlocListener<StudentHistoryBloc, StudentHistoryState>(
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
