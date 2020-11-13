import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomLoaderWidget extends StatelessWidget {
  CustomLoaderWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 70,
      margin: EdgeInsets.all(5),
      child: CircularProgressIndicator(),
    );
  }
}
