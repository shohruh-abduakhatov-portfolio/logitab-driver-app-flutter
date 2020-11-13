import 'package:driver_app_flutter/models/log_edit.dart';
import 'package:flutter/foundation.dart';

class ErrorEvent {
  MyError error;

  ErrorEvent(this.error);
}

enum MyError { SERVER_UNAVAILABLE }
