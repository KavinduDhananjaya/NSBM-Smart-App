import 'package:fcode_common/fcode_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_app/theme/styled_colors.dart';
import 'package:smart_app/ui/common/root_page/root_bloc.dart';

import 'student_history_bloc.dart';
import 'student_history_state.dart';

class StudentHistoryView extends StatelessWidget {
  static final log = Log("StudentHistoryView");
  static final loadingWidget = Center(
    child: CircularProgressIndicator(),
  );

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

            List<Widget> child1=[];
            List<Widget> child2=[];


            for(int i=0;i<state.allHallRequests.length;i++){
              final request=state.allHallRequests[i];

            }

            for(int i=0;i<state.allLecturerRequests.length;i++){
              final request=state.allLecturerRequests[i];


            }


            return Column(
              children: [

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
