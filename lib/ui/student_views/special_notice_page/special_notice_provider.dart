import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'special_notice_bloc.dart';
import 'special_notice_view.dart';

class SpecialNoticeProvider extends BlocProvider<SpecialNoticeBloc> {
  SpecialNoticeProvider({
    Key key,
  }) : super(
          key: key,
          create: (context) => SpecialNoticeBloc(context),
          child: SpecialNoticeView(),
        );
}
