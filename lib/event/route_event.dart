import 'package:driver_app_flutter/models/dvir.dart';
import 'package:driver_app_flutter/models/log_edit.dart';

class RouteEvent {
  String route;
  dynamic data;

  RouteEvent(this.route, [this.data]);
}

class MyRoute {
  static const SHOW_FLOATING_BTN = "/show-floating-btn/";
  static const LOG_EDIT = "/log-edit/";
  static const DVIR_CREATE = '/dvir/create/';
  static const DVIR_EDIT = '/dvir/edit/';
  static const SET_DUTY_STATUS = '/duty-status/set';
  static const CHANGE_DUTY_STATUS = '/duty-status/change';
  static const INSERT_DUTY_STATUS = '/duty-status/insert';
}
