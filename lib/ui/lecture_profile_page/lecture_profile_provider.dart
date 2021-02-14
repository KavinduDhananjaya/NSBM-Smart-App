import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'lecture_profile_bloc.dart';
import 'lecture_profile_view.dart';

class LecturerProfileProvider extends BlocProvider<LecturerProfileBloc> {
  LecturerProfileProvider({
    Key key,
  }) : super(
          key: key,
          create: (context) => LecturerProfileBloc(context),
          child: LecturerProfileView(),
        );
}
