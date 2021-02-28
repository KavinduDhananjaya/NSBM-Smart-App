import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'profile_bloc.dart';
import 'profile_view.dart';

class ProfileProvider extends BlocProvider<ProfileBloc> {
  ProfileProvider({
    Key key,
  }) : super(
          key: key,
          create: (context) => ProfileBloc(context),
          child: ProfileView(),
        );
}
