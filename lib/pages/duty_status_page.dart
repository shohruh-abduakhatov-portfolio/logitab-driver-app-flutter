import 'package:driver_app_flutter/models/duty_status.dart';
import 'package:driver_app_flutter/ui/btn_grouped_widget.dart';
import 'package:driver_app_flutter/ui/btn_widget.dart';
import 'package:driver_app_flutter/ui/input_style.dart';
import 'package:driver_app_flutter/ui/stepline_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

enum DutyStatusEnum { SET, INSERT, EDIT }
enum DriverStatusEnum { OFF, SB, ON_DUTY, D }

extension DriverStatusExtensionMap on DriverStatusEnum {
  static var valueMap = {
    DriverStatusEnum.OFF: 0,
    DriverStatusEnum.SB: 1,
    DriverStatusEnum.ON_DUTY: 2,
    DriverStatusEnum.D: 3,
  };
  int get value => valueMap[this];
}

class DutyStatusPage extends StatefulWidget {
  DutyStatus data;
  DutyStatusEnum mode;

  DutyStatusPage({Key key, mode, data}) : super(key: key) {
    this.mode = mode ?? DutyStatusEnum.SET;
    this.data = data ?? new DutyStatus();
  }

  @override
  _DutyStatusPageState createState() => _DutyStatusPageState(data, this.mode);
}

class _DutyStatusPageState extends State<DutyStatusPage> {
  Function onSave;
  DutyStatus data;
  DutyStatusEnum mode;

  _DutyStatusPageState(this.data, this.mode) {
    print(">>> mode: ${this.mode}");
    this.onSave =
        this.mode == DutyStatusEnum.SET ? createDutyStatus : editDutyStatus;
  }

  final locCtrl = TextEditingController();
  final notesCtrl = TextEditingController();
  final startCtrl = TextEditingController();
  final endCtrl = TextEditingController();

  DateTime startTime;
  DateTime endTime;
  var group = 0;

  RangeValues rangeValues;

  void initState() {
    super.initState();
    rangeValues = const RangeValues(0, 1439);
    group = data.status ?? 0;
    locCtrl.text = data.location ?? "";
    notesCtrl.text = data.remarks ?? "";
    startTime = data.start ?? DateTime.now();
    endTime = data.end ?? DateTime.now();
    endTime = startTime = endTime.subtract(new Duration(
        hours: endTime.hour > 2 ? endTime.hour - 2 : endTime.hour));
    rangeValues = RangeValues(
        (startTime.hour * 60 + startTime.minute).toDouble(), rangeValues.end);
    rangeValues = RangeValues(
        rangeValues.start, (endTime.hour * 60 + endTime.minute).toDouble());
    startCtrl.text = DateFormat('h:mm a').format(startTime);
    endCtrl.text = DateFormat('h:mm a').format(endTime);
  }

  @override
  void dispose() {
    locCtrl.dispose();
    notesCtrl.dispose();
    startCtrl.dispose();
    endCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(children: [
            Container(
              decoration: BoxDecoration(color: Color(0xfff2f2f2)),
              padding: EdgeInsets.all(20),
              child: Row(children: [
                Expanded(
                  child: BtnGrouped(
                    text: "OFF DUTY",
                    id: 0,
                    group: group,
                    activeBgColor: Color(0xff87CEEB),
                    activeTextColor: Colors.black87,
                    bgColor: Colors.white,
                    textColor: Colors.black87,
                    icon: Icons.local_cafe,
                    onPressed: onGroupBtnPressed,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: BtnGrouped(
                    text: "SLEEPER",
                    id: 1,
                    group: group,
                    activeBgColor: Color(0xff87CEEB),
                    activeTextColor: Colors.black87,
                    bgColor: Colors.white,
                    textColor: Colors.black87,
                    icon: Icons.hotel,
                    onPressed: onGroupBtnPressed,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: BtnGrouped(
                    text: "ON DUTY",
                    id: 2,
                    group: group,
                    activeBgColor: Color(0xff87CEEB),
                    activeTextColor: Colors.black87,
                    bgColor: Colors.white,
                    textColor: Colors.black87,
                    icon: Icons.access_time,
                    onPressed: onGroupBtnPressed,
                  ),
                ),
              ]),
            ),
            mode == DutyStatusEnum.SET
                ? Container()
                : Container(
                    padding: EdgeInsets.all(20),
                    child: new SteplineWidget(null,
                        rangeValues: rangeValues, onChange: onChange)),
            Container(
              padding: EdgeInsets.all(20),
              child: Column(children: [
                Text(
                  "LOCATION:",
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 10),
                SizedBox(
                    child: TextField(
                  onChanged: (value) => {},
                  style: TextStyle(
                      color: Theme.of(context).primaryColorDark,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600),
                  controller: locCtrl,
                  decoration: InputStyle.textFieldLightStyle(
                      hint: "Location", icon: "assets/ic_location.png"),
                )),
                SizedBox(height: 20),
                mode != DutyStatusEnum.SET
                    ? Row(children: [
                        Expanded(
                            child: Column(children: [
                          Text(
                            "START TIME:",
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(height: 10),
                          SizedBox(
                              child: TextField(
                            onChanged: (value) {
                              _getStartTime();
                            },
                            onTap: () => _getStartTime(),
                            style: TextStyle(
                                color: Theme.of(context).primaryColorDark,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600),
                            controller: startCtrl,
                            decoration: InputStyle.textFieldLightStyle(
                                hint: "Start Time", icon: "assets/ic_play.png"),
                          )),
                          SizedBox(height: 20),
                        ])),
                        SizedBox(width: 15),
                        Expanded(
                            child: Column(children: [
                          Text(
                            "END TIME:",
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(height: 10),
                          SizedBox(
                              child: TextField(
                            onChanged: (value) {
                              _getEndTime();
                            },
                            onTap: () => _getEndTime(),
                            style: TextStyle(
                                color: Theme.of(context).primaryColorDark,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600),
                            controller: endCtrl,
                            decoration: InputStyle.textFieldLightStyle(
                                hint: "End Time", icon: "assets/ic_pause.png"),
                          )),
                          SizedBox(height: 20),
                        ])),
                      ])
                    : SizedBox(),
                Text(
                  "REMARKS:",
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 10),
                SizedBox(
                    child: TextField(
                  onChanged: (value) => {},
                  style: TextStyle(
                      color: Theme.of(context).primaryColorDark,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600),
                  controller: notesCtrl,
                  decoration: InputStyle.textFieldLightStyle(
                      hint: "Remarks", icon: "assets/ic_notes.png"),
                )),
              ]),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Row(children: [
                Expanded(
                  child: Btn("CANCEL",
                      onPressed: () => {}, color: Colors.grey.shade400),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Btn("OK", onPressed: () => {}),
                ),
              ]),
            )
          ]),
        ));
  }

  void onChange(RangeValues values) {
    var _start = values.start.round();
    var _end = values.end.round();
    setState(() {
      rangeValues = values;
      startTime = new DateTime(startTime.year, startTime.month, startTime.day,
          (_start / 60).floor(), _start % 60);
      endTime = new DateTime(endTime.year, endTime.month, endTime.day,
          (_end / 60).floor(), _end % 60);
      startCtrl.text = DateFormat('h:mm a').format(startTime);
      endCtrl.text = DateFormat('h:mm a').format(endTime);
    });
  }

  onGroupBtnPressed(int index) {
    setState(() {
      group = index;
    });
    onSave(index);
  }

  void createDutyStatus(data) {}

  void editDutyStatus(data) {}

  void _getStartTime() async {
    DatePicker.showTime12hPicker(
      context,
      showTitleActions: true,
      currentTime: startTime,
      onConfirm: (time) {
        setState(() {
          startTime = time;
          startCtrl.text = DateFormat('h:mm a').format(time);
          rangeValues = RangeValues(
              (time.hour * 60 + time.minute).toDouble(), rangeValues.end);
        });
      },
    );
  }

  void _getEndTime() async {
    DatePicker.showTime12hPicker(
      context,
      showTitleActions: true,
      currentTime: endTime,
      onConfirm: (time) {
        setState(() {
          endTime = time;
          endCtrl.text = DateFormat('h:mm a').format(time);
          rangeValues = RangeValues(
              rangeValues.start, (time.hour * 60 + time.minute).toDouble());
        });
      },
    );
  }
}
