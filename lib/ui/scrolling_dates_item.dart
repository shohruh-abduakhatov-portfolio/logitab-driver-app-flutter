import 'package:driver_app_flutter/utils/status.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class ScrollingDatesItem extends StatelessWidget {
  final DateTime date;
  final Function onTap;
  final int id;
  final Color status;
  final bool isSelected;

  ScrollingDatesItem(
      {@required this.date,
      @required this.onTap,
      @required this.id,
      this.isSelected = false,
      this.status = StatusColor.none});

  @override
  Widget build(BuildContext context) {
    var fontStyle = isSelected
        ? TextStyle(fontWeight: FontWeight.bold, fontSize: 18)
        : TextStyle(fontSize: 17);
    var bgColor = isSelected ? Colors.grey.shade300 : null;
    return Card(
        color: bgColor,
        child: InkWell(
          onTap: () => onTap(this.id),
          // child: Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Container(
                width: 10.0,
                height: 10.0,
                decoration: new BoxDecoration(
                  color: status,
                  shape: BoxShape.circle,
                )),
            Container(
              margin: EdgeInsets.only(
                  left: 8.0, right: 8.0, top: 16.0, bottom: 16.0),
              child: Column(
                children: [
                  Text(
                    DateFormat('HH:mm').format(date),
                    style: fontStyle,
                  ),
                  Text(
                    DateFormat('MMM dd').format(date),
                    style: fontStyle,
                  )
                ],
              ),
            ),
          ]),
          // ),
        ));
  }
}
