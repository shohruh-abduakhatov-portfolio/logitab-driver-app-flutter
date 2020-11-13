import 'package:driver_app_flutter/models/event.dart';
import 'package:driver_app_flutter/rxbus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EventListItem extends StatelessWidget {
  final Function onTap;
  final LogEvent data;

  EventListItem({
    @required this.data,
    @required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    var textStyle = TextStyle(fontWeight: FontWeight.w400, fontSize: 19);
    return new Card(
        // margin: EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
        child: InkWell(
      onTap: () => onTap(this.data.id),
      child: Container(
          margin: EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            top: 16.0,
            bottom: 16.0,
          ),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                eventStatusView("OFF"),
                Text("12:00:11 AM", style: textStyle),
                Text("24 H  00 min", style: textStyle),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Row(
                  children: [
                    Icon(Icons.location_on,
                        color: Colors.green.shade400, size: 28.0),
                    Text("Location")
                  ],
                )
              ],
            ),
            Row(
              children: [
                Icon(Icons.comment, color: Colors.green.shade400, size: 28.0),
                Text("My Comment")
              ],
            )
          ])),
    ));
  }

  Widget eventStatusView(String status) {
    var _borderColor, _fontColor;
    switch (status.toUpperCase()) {
      case "OFF":
        _borderColor = Colors.red.shade300;
        _fontColor = Colors.white;
        break;
      case "SB":
        _borderColor = Colors.orange.shade300;
        _fontColor = Colors.black;
        break;
      case "D":
        _borderColor = Colors.green.shade300;
        _fontColor = Colors.white;
        break;
      case "ON":
        _borderColor = Colors.blue.shade300;
        _fontColor = Colors.white;
        break;
      default:
        _borderColor = Colors.transparent;
        _fontColor = Colors.black;
        break;
    }
    return Container(
        decoration: BoxDecoration(
            color: _borderColor,
            border: Border.all(
              color: _borderColor,
            ),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        padding: EdgeInsets.all(10),
        child: Text(
          "OFF",
          style: TextStyle(fontWeight: FontWeight.bold, color: _fontColor),
        ));
  }
}
