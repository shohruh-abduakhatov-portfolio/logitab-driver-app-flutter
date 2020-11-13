import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Btn extends StatelessWidget {
  var text = "";
  var color;
  var textColor;
  var show;
  Function onPressed;

  Btn(this.text,
      {this.color = const Color(0xff87CEEB),
      this.textColor = const Color(0xff243665),
      this.show = true,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: !show ? null : () => onPressed(),
      disabledColor: Colors.black26,
      child: Text(
        text,
        maxLines: 1,
        style: TextStyle(
            color: textColor, fontSize: 20.0, fontWeight: FontWeight.w500),
      ),
      padding: EdgeInsets.only(top: 16, bottom: 16, right: 60, left: 60),
      color: color,
    );
  }
}
