import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BtnGrouped extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color activeBgColor, activeTextColor;
  final Color bgColor, textColor;
  final Function onPressed;
  final int group, id;

  BtnGrouped(
      {this.text,
      this.icon,
      this.activeBgColor = const Color(0xff87CEEB),
      this.activeTextColor = Colors.black87,
      this.bgColor = Colors.white,
      this.textColor = Colors.black87,
      this.id,
      this.group,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.grey[500],
          offset: Offset(0.0, 1.5),
          blurRadius: 1.5,
        ),
      ]),
      child: FlatButton(
        padding: EdgeInsets.only(top: 16, bottom: 16, right: 60, left: 60),
        onPressed: () => onPressed(id),
        // disabledColor: id != group ? bgColor : activeBgColor,
        child: Row(children: [
          Icon(
            icon,
            color: id != group ? textColor : activeTextColor,
            size: 28.0,
          ),
          SizedBox(width: 5),
          Text(
            text,
            maxLines: 1,
            style: TextStyle(
                color: id != group ? textColor : activeTextColor,
                fontSize: 20.0,
                fontWeight: FontWeight.w500),
          ),
        ]),
        color: id != group ? bgColor : activeBgColor,
      ),
    );
  }
}
