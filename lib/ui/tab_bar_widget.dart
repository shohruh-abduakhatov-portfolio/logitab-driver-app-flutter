import 'package:driver_app_flutter/models/choice.dart';
import 'package:driver_app_flutter/ui/tab_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TabBarWidget extends TabBar {
  final TabController controller;
  TabBarWidget({this.controller});

  @override
  Widget build(BuildContext context) {
    if (controller != null) {
    } else {
      return TabBar(tabs: null);
    }
  }
}
