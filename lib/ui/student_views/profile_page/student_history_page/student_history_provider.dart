import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'student_history_bloc.dart';
import 'student_history_view.dart';

class StudentHistoryProvider extends BlocProvider<StudentHistoryBloc> {
  StudentHistoryProvider({
    Key key,
  }) : super(
          key: key,
          create: (context) => StudentHistoryBloc(context),
          child: StudentHistoryView(),
        );
}
