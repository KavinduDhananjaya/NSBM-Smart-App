import 'package:date_time_picker/date_time_picker.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:fcode_common/fcode_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_app/theme/styled_colors.dart';
import 'package:smart_app/ui/root_page/root_page.dart';
import 'package:smart_app/ui/widgets/round_button.dart';

import 'hall_booking_bloc.dart';
import 'hall_booking_state.dart';

class HallBookingView extends StatelessWidget {
  static final log = Log("HallBookingView");
  static final loadingWidget = Center(
    child: CircularProgressIndicator(),
  );

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final hall_bookingBloc = BlocProvider.of<HallBookingBloc>(context);
    // ignore: close_sinks
    final rootBloc = BlocProvider.of<RootBloc>(context);
    log.d("Loading HallBooking View");

    CustomSnackBar customSnackBar;
    final scaffold = Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: Text(
          "Hall Booking",
          style: TextStyle(
            color: StyledColors.DARK_BLUE,
            fontWeight: FontWeight.w500,
            fontSize: 24,
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            SizedBox(
              height: 16,
            ),
            Column(
              children: [
                Row(
                  children: [
                    Radio(
                      value: "KAvindu",
                      groupValue: true,
                      onChanged: (value) {
                        print(value);
                      },
                    ),
                    Text('Student')
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      value: "KAvindu",
                      groupValue: true,
                      onChanged: (value) {
                        print(value);
                      },
                    ),
                    Text('Club or Organization')
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            TextFormField(
              textCapitalization: TextCapitalization.none,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(labelText: "Purpose"),
              onFieldSubmitted: (value) {},
            ),
            SizedBox(
              height: 16,
            ),
            DropdownSearch<String>(
              mode: Mode.DIALOG,
              maxHeight: 300,
              items: ["kjaf", "afeafe", "atresvdg"],
              label: "Select Faculty",
              selectedItem: null,
              onChanged: (value) {},
              showSearchBox: false,
              searchBoxDecoration: InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 0),
                labelText: "Search User",
              ),
              showClearButton: true,
            ),
            SizedBox(
              height: 16,
            ),
            TextFormField(
              textCapitalization: TextCapitalization.none,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Capacity"),
              onFieldSubmitted: (value) {},
            ),
            SizedBox(
              height: 16,
            ),
            DropdownSearch<String>(
              mode: Mode.DIALOG,
              maxHeight: 300,
              items: ["kjaf", "afeafe", "atresvdg"],
              label: "Available Holes",
              selectedItem: null,
              onChanged: (value) {},
              showSearchBox: false,
              searchBoxDecoration: InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 0),
                labelText: "Search User",
              ),
              showClearButton: true,
            ),
            SizedBox(
              height: 16,
            ),
            DropdownSearch<String>(
              mode: Mode.DIALOG,
              maxHeight: 300,
              items: ["kjaf", "afeafe", "atresvdg"],
              label: "Responsible Lecture",
              selectedItem: null,
              onChanged: (value) {},
              showSearchBox: false,
              searchBoxDecoration: InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 0),
                labelText: "Search User",
              ),
              showClearButton: true,
            ),
            SizedBox(
              height: 16,
            ),

            DateTimePicker(
              type: DateTimePickerType.date,
              initialValue: '',
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
              dateLabelText: 'Select Date',
              onChanged: (val) => print(val),
              validator: (val) {
                print(val);
                return null;
              },
              onSaved: (val) => print(val),
            ),

            SizedBox(
              height: 32,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FlatButton(onPressed: (){}, child: Text("Cancel"),color: StyledColors.LIGHT_GREEN,),
                SizedBox(width: 16,),
                FlatButton(onPressed: (){}, child: Text("Request"),color: StyledColors.PRIMARY_COLOR),
              ],
            ),

          ],
        ),
      ),
    );

    return MultiBlocListener(
      listeners: [
        BlocListener<HallBookingBloc, HallBookingState>(
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
