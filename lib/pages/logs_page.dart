import 'dart:convert';

import 'package:driver_app_flutter/API.dart';
import 'package:driver_app_flutter/event/error_event.dart';
import 'package:driver_app_flutter/event/route_event.dart';
import 'package:driver_app_flutter/models/duty_status.dart';
import 'package:driver_app_flutter/models/event.dart';
import 'package:driver_app_flutter/models/log_edit.dart';
import 'package:driver_app_flutter/models/stepline_data.dart';
import 'package:driver_app_flutter/models/vehicle.dart';
import 'package:driver_app_flutter/pages/duty_status_page.dart';
import 'package:driver_app_flutter/rxbus.dart';
import 'package:driver_app_flutter/ui/btn_grouped_widget.dart';
import 'package:driver_app_flutter/ui/custom_loader_widget.dart';
import 'package:driver_app_flutter/ui/event_list_item.dart';
import 'package:driver_app_flutter/ui/gauge_widget.dart';
import 'package:driver_app_flutter/ui/log_edit_req_list_item.dart';
import 'package:driver_app_flutter/ui/scrolling_dates_item.dart';
import 'package:driver_app_flutter/ui/stepline_widget.dart';
import 'package:driver_app_flutter/utils/main_page_helper.dart';
import 'package:flutter/material.dart';

class LogsPage extends StatefulWidget {
  @override
  _LogsPageState createState() => _LogsPageState();
}

class _LogsPageState extends State<LogsPage> {
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  static List<LogEdit> logEditRequestList;
  int group = 0;
  List<SteplineData> steplineData;
  List<DateTime> dates;
  List<LogEvent> logEvent;
  int dateSelected;

  void initState() {
    super.initState();
    _loadLogEdit();
    this.steplineData = sampleData;
    this.dates = datesList();
    this.logEvent = _logEventData();
    dateSelected = dates.length;
    print(">>> date length: $dateSelected");
  }

  onRefresh() {
    _loadLogEdit();
    return Future(null);
  }

  void onGroupBtnPressed(int index, DriverStatusEnum _status) {
    print(">> onGroupBtnPressed $index");
    setState(() {
      this.group = index;
      print(this.group);
    });
    var _data = new DutyStatus();
    _data.status = _status.value;
    RxBus.post(RouteEvent(MyRoute.SET_DUTY_STATUS, _data));
  }

  @override
  Widget build(BuildContext context) {
    return new RefreshIndicator(
        backgroundColor: Colors.grey.shade300,
        key: refreshKey,
        onRefresh: () => onRefresh(),
        child: Material(
            child: SingleChildScrollView(
                child: Column(children: <Widget>[
          logEditRequestList == null
              ? CustomLoaderWidget()
              : new Column(children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(
                        left: 16.0, right: 16.0, top: 10.0, bottom: 0.0),
                    child: Text(
                      "Log edit requests: ",
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(0, 0, 0, 0.5)),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 12, right: 8),
                      // child: Expanded(
                      child: ListView.builder(
                        itemCount: logEditRequestList.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return new Card(
                              margin: EdgeInsets.only(
                                  left: 8, right: 8, top: 4, bottom: 4),
                              child: new LogEditRequestListItem(
                                  logEditRequestList[index],
                                  removeLogEditRequestFromList));
                        },
                        // ),
                      ))
                ]),

          Container(
            // Grouped Button
            color: Colors.grey.shade300,
            margin: EdgeInsets.only(top: 20),
            padding: EdgeInsets.only(top: 25, bottom: 25, left: 20, right: 20),
            child: Row(children: [
              Container(
                  child: BtnGrouped(
                text: "OFF DUTY",
                id: 0,
                group: this.group,
                icon: Icons.local_cafe,
                onPressed: (id) => onGroupBtnPressed(id, DriverStatusEnum.OFF),
              )),
              SizedBox(width: 10),
              Container(
                  child: BtnGrouped(
                text: "SLEEPER",
                id: 1,
                group: this.group,
                icon: Icons.hotel,
                onPressed: (id) => onGroupBtnPressed(id, DriverStatusEnum.SB),
              )),
              SizedBox(width: 10),
              Container(
                  child: BtnGrouped(
                text: "ON DUTY",
                id: 2,
                group: this.group,
                icon: Icons.access_time,
                onPressed: (id) =>
                    onGroupBtnPressed(id, DriverStatusEnum.ON_DUTY),
              ))
            ]),
          ),

          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Container(
              width: 170,
              height: 170,
              child: GaugeWidget(8.0, "BREAK", 8.0),
            ),
            Container(
              width: 170,
              height: 170,
              child: GaugeWidget(11.0, "DRIVING", 11.0),
            ),
            Container(
              width: 170,
              height: 170,
              child: GaugeWidget(14.0, "SHIFT", 14.0),
            ),
            Container(
              width: 170,
              height: 170,
              child: GaugeWidget(70.0, "CYCLE", 70.0),
            ),
          ]),
          // Stepline Chart
          Container(
            padding: EdgeInsets.all(20),
            child: SteplineWidget(steplineData),
          ),

          SizedBox(
              height: 100.0,
              child: ListView.builder(
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: dates.length,
                  itemBuilder: (context, index) {
                    return ScrollingDatesItem(
                      date: dates[index],
                      onTap: onDateSelected,
                      id: index + 1,
                      isSelected: dateSelected == index + 1,
                    );
                  })),

          // Events List
          logEvent != null
              ? Container(
                  margin: EdgeInsets.only(left: 12, right: 8),
                  child: Material(
                    // child: Expanded(
                    child: ListView.builder(
                      itemCount: logEvent.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return new EventListItem(
                            data: logEvent[index], onTap: onEventItemSelected);
                      },
                    ),
                    // )
                  ))
              : Container()
        ]))));
  }

  void onEventItemSelected(int eventId) {
    var _event = logEvent.singleWhere((LogEvent elem) => elem.id == eventId,
        orElse: null);
    print(">>>> ${_event == null}");
    if (_event == null) return;
    RxBus.post(RouteEvent(MyRoute.CHANGE_DUTY_STATUS, _event));
  }

  void removeLogEditRequestFromList(int logId) {
    print(">>> logId $logId");
    List<LogEdit> _logEditRequestList = [...logEditRequestList];
    _logEditRequestList =
        _logEditRequestList.where((LogEdit elem) => elem.id != logId).toList();
    setState(() {
      logEditRequestList = _logEditRequestList;
    });
  }

  void onDateSelected(id) {
    print(id);
    setState(() {
      this.dateSelected = id;
    });
  }

  void _loadLogEdit() {
    print(">>> LOADING DATA");
    // API.editRequestsList().then((response) {
    //   if (!mounted) return;
    //   if (response.statusCode == 401) {
    //     Navigator.of(context).pushNamedAndRemoveUntil(
    //         '/login/', (Route<dynamic> route) => false);
    //     return;
    //   }
    //   if (response.statusCode != 200) return;
    //   var parsed = jsonDecode(response.body)['data'];

    //   List<LogEdit> _editRequestList = List();
    //   for (final i in parsed) {
    //     _editRequestList.add(LogEdit.fromJson(i));
    //   }
    //   setState(() {
    //     logEditRequestList = _editRequestList;
    //   });
    // }).catchError((onError) => print(onError));
    List<LogEdit> v = new List();
    v.add(new LogEdit(
        1,
        0,
        0,
        "note",
        "me",
        1,
        DateTime.now(),
        0.0,
        1,
        "1",
        "2",
        1,
        1,
        1,
        "1213",
        123.12,
        1231.123,
        1,
        "as",
        DateTime.now(),
        1,
        "1"));
    v.add(new LogEdit(
        2,
        0,
        0,
        "note",
        "me",
        1,
        DateTime.now(),
        0.0,
        1,
        "1",
        "2",
        1,
        1,
        1,
        "1213",
        123.12,
        1231.123,
        1,
        "as",
        DateTime.now(),
        1,
        "1"));

    setState(() {
      logEditRequestList = v;
    });
    return;
  }

  final List<SteplineData> sampleData = <SteplineData>[
    SteplineData(x: 00, y: 1.5, xStr: '00'),
    // SteplineData(x: 0.05, y: 2.5, xStr: '00'),
    // SteplineData(x: 0.5, y: 1.5, xStr: '00'),
    // SteplineData(x: 0.75, y: 1.5, xStr: '00'),
    SteplineData(x: 01, y: 2.5, xStr: '01'),
    // SteplineData(x: 1.25, y: 2.5, xStr: '01'),
    // SteplineData(x: 1.5, y: 2.5, xStr: '01'),
    // SteplineData(x: 1.75, y: 2.5, xStr: '01'),
    SteplineData(x: 02, y: 0.5, xStr: '02'),
    // SteplineData(x: 2.25, y: 0.5, xStr: '02'),
    // SteplineData(x: 2.5, y: 0.5, xStr: '02'),
    // SteplineData(x: 2.75, y: 0.5, xStr: '02'),
    SteplineData(x: 03, y: 1.5, xStr: '03'),
    SteplineData(x: 3.05, y: 2.5, xStr: '03'),
    SteplineData(x: 3.1, y: 1.5, xStr: '03'),
    // SteplineData(x: 3.75, y: 1.5, xStr: '03'),
    SteplineData(x: 04, y: 1.5, xStr: '04'),
    // SteplineData(x: 4.25, y: 1.5, xStr: '04'),
    // SteplineData(x: 4.5, y: 1.5, xStr: '04'),
    // SteplineData(x: 4.75, y: 1.5, xStr: '04'),
    SteplineData(x: 05, y: 1.5, xStr: '05'),
    // SteplineData(x: 5.25, y: 1.5, xStr: '05'),
    // SteplineData(x: 5.5, y: 1.5, xStr: '05'),
    // SteplineData(x: 5.75, y: 1.5, xStr: '05'),
    SteplineData(x: 06, y: 3.5, xStr: '06'),
    // SteplineData(x: 6.25, y: 3.5, xStr: '06'),
    // SteplineData(x: 6.5, y: 3.5, xStr: '06'),
    // SteplineData(x: 6.75, y: 3.5, xStr: '06'),
    SteplineData(x: 07, y: 3.5, xStr: '07'),
    // SteplineData(x: 7.25, y: 3.5, xStr: '07'),
    // SteplineData(x: 7.5, y: 3.5, xStr: '07'),
    // SteplineData(x: 7.75, y: 3.5, xStr: '07'),
    SteplineData(x: 08, y: 3.5, xStr: '08'),
    // SteplineData(x: 8.25, y: 3.5, xStr: '08'),
    // SteplineData(x: 8.5, y: 3.5, xStr: '08'),
    // SteplineData(x: 8.75, y: 3.5, xStr: '08'),
    SteplineData(x: 09, y: 3.5, xStr: '09'),
    // SteplineData(x: 9.25, y: 3.5, xStr: '09'),
    // SteplineData(x: 9.5, y: 3.5, xStr: '09'),
    // SteplineData(x: 9.75, y: 3.5, xStr: '09'),
    SteplineData(x: 10, y: 3.5, xStr: '10'),
    // SteplineData(x: 10.25, y: 3.5, xStr: '10'),
    // SteplineData(x: 10.5, y: 3.5, xStr: '10'),
    // SteplineData(x: 10.75, y: 3.5, xStr: '10'),
    SteplineData(x: 11, y: 1.5, xStr: '11'),
    // SteplineData(x: 11.25, y: 1.5, xStr: '11'),
    // SteplineData(x: 11.5, y: 1.5, xStr: '11'),
    // SteplineData(x: 11.75, y: 1.5, xStr: '11')

    SteplineData(x: 12, y: 0.5, xStr: '02'),
    SteplineData(x: 13, y: 1.5, xStr: '03'),
    SteplineData(x: 14, y: 1.5, xStr: '04'),
    SteplineData(x: 15, y: 1.5, xStr: '05'),
    SteplineData(x: 16, y: 3.5, xStr: '06'),
    SteplineData(x: 17, y: 3.5, xStr: '07'),
    SteplineData(x: 18, y: 3.5, xStr: '08'),
    SteplineData(x: 19, y: 3.5, xStr: '09'),
    SteplineData(x: 20, y: 3.5, xStr: '10'),
    SteplineData(x: 21, y: 1.5, xStr: '11'),
    SteplineData(x: 22, y: 1.5, xStr: '00'),
    SteplineData(x: 23, y: 2.5, xStr: '01'),
    SteplineData(x: 24, y: 2.5, xStr: '01'),
  ];

  datesList() {
    List<DateTime> _dates = [
      DateTime.now(),
      DateTime.now(),
      DateTime.now(),
      DateTime.now(),
      DateTime.now(),
      DateTime.now(),
      DateTime.now(),
      DateTime.now(),
      DateTime.now(),
      DateTime.now(),
      DateTime.now(),
      DateTime.now(),
      DateTime.now(),
      DateTime.now(),
    ];
    return _dates;
  }

  _logEventData() {
    List<LogEvent> _data = [
      LogEvent(1),
      LogEvent(2),
      LogEvent(3),
      LogEvent(4),
      LogEvent(5),
    ];

    return _data;
  }
}
