import 'package:flutter/material.dart';

class StatusWidget extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String msg;

  StatusWidget(this.msg,
      {this.color = Colors.red, this.icon = Icons.error_outline});
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        color: color,
        padding: EdgeInsets.all(8),
        child: Row(children: <Widget>[
          Icon(icon, color: Colors.white),
          SizedBox(
            width: 12,
          ),
          Expanded(
              child: Text(
            msg,
            style: TextStyle(color: Colors.white, fontSize: 18),
          )),
        ]));
  }
}
