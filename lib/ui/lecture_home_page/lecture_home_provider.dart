import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'lecture_home_bloc.dart';
import 'lecture_home_view.dart';

class LectureHomeProvider extends BlocProvider<LectureHomeBloc> {
  LectureHomeProvider({
    Key key,
  }) : super(
          key: key,
          create: (context) => LectureHomeBloc(context),
          child: LectureHomeView(),
        );
}
