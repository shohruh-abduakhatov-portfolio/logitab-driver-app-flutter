import 'package:driver_app_flutter/models/check.dart';
import 'package:driver_app_flutter/models/check_status.dart';
import 'package:intl/intl.dart';

String dtToString(String format) {
  return DateFormat(format).format(DateTime.now());
}

List<Check> sampleData() {
  return [
    new Check(1, ""),
    new Check(2, "Delivery"),
    new Check(3, "Pick Up"),
  ];
}
