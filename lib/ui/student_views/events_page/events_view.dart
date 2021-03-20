import 'package:fcode_common/fcode_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_app/theme/styled_colors.dart';
import 'package:smart_app/ui/common/root_page/root_page.dart';
import 'package:smart_app/ui/widgets/event_card.dart';
import 'events_bloc.dart';
import 'events_state.dart';

class EventsView extends StatelessWidget {
  static final log = Log("EventsView");
  static final loadingWidget = Center(
    child: CircularProgressIndicator(),
  );

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final eventsBloc = BlocProvider.of<EventsBloc>(context);
    // ignore: close_sinks
    final rootBloc = BlocProvider.of<RootBloc>(context);
    log.d("Loading Events View");

    CustomSnackBar customSnackBar;
    final scaffold = Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: Text(
          "Upcoming Events",
          style: TextStyle(
            color: StyledColors.DARK_GREEN,
            fontWeight: FontWeight.w500,
            fontSize: 24,
          ),
        ),
      ),
      body: BlocBuilder<RootBloc, RootState>(
          buildWhen: (pre, current) => pre.allEvents != current.allEvents,
          builder: (context, state) {
            if (state.allEvents == null) return loadingWidget;

            List<Widget> children = [];

            for (int i = 0; i < state.allEvents.length; i++) {
              final event = state.allEvents[i];

              final card = EventCard(
                title: event.title,
                imgUrl: event.imgUrl,
                desc: event.description,
              );

              children.add(card);
            }

            if (children.isEmpty) {
              children.add(Center(
                child: Text(
                  "No UpComing Events..",
                  style: TextStyle(fontSize: 17, color: StyledColors.DARK_BLUE),
                ),
              ));
            }

            return Column(
              children: [
                SizedBox(height: 32,),
                Expanded(
                  child: ListView(
                      children: children
                  ),
                ),
              ],
            );
          }),
    );

    return MultiBlocListener(
      listeners: [
        BlocListener<EventsBloc, EventsState>(
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
