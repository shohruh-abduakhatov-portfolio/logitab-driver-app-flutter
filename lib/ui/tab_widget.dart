import 'package:driver_app_flutter/models/choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TabCard extends StatelessWidget {
  const TabCard({Key key, this.choice}) : super(key: key);

  final Choice choice;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.headline4;
    return new Tab(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Icon(
            choice.icon,
            color: Colors.white,
          ),
          SizedBox(width: 10),
          new Text(
            choice.title,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
