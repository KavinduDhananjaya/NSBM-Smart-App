import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'lecturer_home_bloc.dart';
import 'lecturer_home_view.dart';

class LecturerHomeProvider extends BlocProvider<LecturerHomeBloc> {
  LecturerHomeProvider({
    Key key,
  }) : super(
          key: key,
          create: (context) => LecturerHomeBloc(context),
          child: LecturerHomeView(),
        );
}
