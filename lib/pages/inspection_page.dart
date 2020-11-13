import 'package:driver_app_flutter/pages/inspection_email.dart';
import 'package:driver_app_flutter/ui/btn_widget.dart';
import 'package:driver_app_flutter/ui/log_report_dialog.dart';
import 'package:driver_app_flutter/ui/pdf_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class InspectionPage extends StatefulWidget {
  @override
  _InspectionPageState createState() => _InspectionPageState();
}

class _InspectionPageState extends State<InspectionPage> {
  // InspectionEmail emailRequestDialog = new InspectionEmail();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Preview logs for previous 7 days + today",
                    style: TextStyle(fontSize: 25),
                  ),
                  SizedBox(height: 30),
                  Text(
                    'Tap "Begin Inspection" and hand your device to the officer',
                    style: TextStyle(fontSize: 21),
                  ),
                  SizedBox(height: 15),
                  new Btn(
                    "BEGIN INSPECTION",
                    onPressed: beginInspection,
                  ),
                  SizedBox(height: 15),
                  new Divider(
                    height: 4,
                    color: Colors.black54,
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Send logs for previous 7 days + today',
                    style: TextStyle(fontSize: 21),
                  ),
                  SizedBox(height: 15),
                  new Btn(
                    "SEND LOGS",
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (_) => new InspectionEmail());
                    },
                  ),
                ]),
          ),
        ));
  }

  void beginInspection() {
    showDialog(
        context: context,
        builder: (_) =>
            new LogReport('http://www.africau.edu/images/default/sample.pdf'));
  }

  void sendLogs() {}
}
