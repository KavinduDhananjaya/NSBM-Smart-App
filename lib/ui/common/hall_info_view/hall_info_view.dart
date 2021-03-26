import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_app/theme/styled_colors.dart';
import 'package:smart_app/ui/common/root_page/root_page.dart';

class HallInfoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: Text(
          "Hall Information",
          style: TextStyle(
            color: StyledColors.DARK_GREEN,
            fontWeight: FontWeight.w500,
            fontSize: 24,
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        child: BlocBuilder<RootBloc, RootState>(
            buildWhen: (pre, current) => pre.allHalls != current.allHalls,
            builder: (context, state) {
              if (state.allHalls.isEmpty) {
                return Text("No Halls Available");
              }

              List<DataRow> rows = [];
              for (int i = 0; i < state.allHalls.length; i++) {
                final hall = state.allHalls[i];

                final dataRow = DataRow(cells: [
                  DataCell(Text(hall.faculty)),
                  DataCell(Text(hall.flow)),
                  DataCell(Text(hall.hallNumber.toString())),
                  DataCell(Text(hall.capacity.toString())),
                ]);

                rows.add(dataRow);
              }

              return Container(
                margin: EdgeInsets.all(10),
                child: DataTable(
                  columnSpacing: 2,
                  columns: [
                    DataColumn(
                        label: Text('Faculty',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Flow',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Hall Number',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Capacity',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold))),
                  ],
                  rows: rows,
                ),
              );
            }),
      ),
    );
  }
}
