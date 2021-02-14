import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:smart_app/theme/styled_colors.dart';

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
        child: Container(
          margin: EdgeInsets.all(10),
          child: Table(
            border: TableBorder.all(),
            defaultVerticalAlignment: TableCellVerticalAlignment. baseline,

            columnWidths: {
              0: FractionColumnWidth(.4),
              1: FractionColumnWidth(.2),
              2: FractionColumnWidth(.2),
              3: FractionColumnWidth(.2)
            },
            children: [
              TableRow(children: [
                Column(children: [Text('Faculty')]),
                Column(children: [Text('Flow')]),
                Column(children: [Text('Hall Number')]),
                Column(children: [Text("Capacity")]),
              ]),
              TableRow(
                children: [
                  Text("SOC"),
                  Text("B1"),
                  Text("101"),
                  Text("140"),
                ],
              ),
              TableRow(
                children: [
                  Text("SOC"),
                  Text("B1"),
                  Text("101"),
                  Text("140"),
                ],
              ),
              TableRow(
                children: [
                  Text("SOC"),
                  Text("B1"),
                  Text("101"),
                  Text("140"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
