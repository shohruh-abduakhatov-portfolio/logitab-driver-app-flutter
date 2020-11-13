import 'package:driver_app_flutter/pages/dvir.dart';
import 'package:driver_app_flutter/pages/gauge.dart';
import 'package:driver_app_flutter/pages/logs_page.dart';
import 'package:driver_app_flutter/pages/signature_page.dart';
import 'package:driver_app_flutter/pages/stepline.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeWidget extends StatelessWidget {
  final TabController controller;
  final screen;

  HomeWidget({this.screen, this.controller});

  @override
  Widget build(BuildContext context) {
    if (screen != null) {
      return Expanded(
          child: Container(padding: EdgeInsets.only(top: 0), child: screen));
    } else if (controller != null) {
      return Expanded(
          child: new TabBarView(
        children: <Widget>[
          new LogsPage(),
          new GaugePage(),
          new DVIRPage(),
          new SignaturePage(),
        ],
        controller: controller,
      ));
    } else {
      return Container();
    }
  }
}
