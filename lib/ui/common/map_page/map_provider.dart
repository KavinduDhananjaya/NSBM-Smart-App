import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'map_bloc.dart';
import 'map_view.dart';

class MapProvider extends BlocProvider<MapBloc> {
  MapProvider({
    Key key,
  }) : super(
          key: key,
          create: (context) => MapBloc(context),
          child: MapView(),
        );
}
