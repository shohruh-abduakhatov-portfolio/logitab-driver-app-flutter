import 'package:driver_app_flutter/models/dvir.dart';
import 'package:driver_app_flutter/ui/input_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class DVIRStatusPage extends StatefulWidget {
  DVIR data;
  DVIRStatusPageMode mode;
  DVIRStatusPage({Key key, data}) : super(key: key) {
    this.mode =
        data == null ? DVIRStatusPageMode.CREATE : DVIRStatusPageMode.EDIT;
    this.data = data ?? new DVIR();
  }

  @override
  _DVIRStatusPageState createState() =>
      _DVIRStatusPageState(data: this.data, mode: this.mode);
}

enum DVIRStatus { DEFECT, NO_DEFECT, FIXED, TO_FIX }
enum DVIRStatusPageMode { CREATE, EDIT }

class _DVIRStatusPageState extends State<DVIRStatusPage> {
  final DVIR data;
  DVIRStatusPageMode mode;

  _DVIRStatusPageState({this.data, this.mode}) {
    print(">> ${this.data}");
    this.actionBtns = setActionBtns();
  }

  static TextStyle btnTextStyle = TextStyle(
      color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w500);
  static const headStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 20);
  static TextStyle bodyStyle =
      TextStyle(fontWeight: FontWeight.w600, color: Colors.grey.shade500);
  static const space = SizedBox(height: 10, width: 10);
  final descriptionCtrl = TextEditingController();
  DVIRStatus status = DVIRStatus.DEFECT;
  List<Widget> actionBtns;

  setActionBtns() {
    print(mode);
    var leftBtnAction = onCancelBtn;
    var leftBtnText = 'CANCEL';
    var rightBtnAction = onAddSignBtn;
    var rightBtnText = 'ADD SIGNATURE';
    if (mode == DVIRStatusPageMode.EDIT) {
      rightBtnAction = onDriverSign;
      rightBtnText = "DRIVER'S SIGNATURE";
    } else if (status == DVIRStatus.DEFECT) {
      leftBtnAction = onToWorkBtn;
      leftBtnText = 'WORK ON IT';
      rightBtnAction = onFixedBtn;
      rightBtnText = 'FIXED';
    }
    return [
      space,
      space,
      Row(
        children: [
          Expanded(
              child: FlatButton(
            child: Text(
              leftBtnText,
              style: btnTextStyle,
            ),
            onPressed: () => leftBtnAction,
            padding: EdgeInsets.only(
                top: 16.0, bottom: 16.0, left: 24.0, right: 24.0),
            color: Color(0xff87CEEB),
          )),
          space,
          Expanded(
              child: FlatButton(
            child: Text(
              rightBtnText,
              style: btnTextStyle,
            ),
            onPressed: () => rightBtnAction,
            padding: EdgeInsets.only(
                top: 16.0, bottom: 16.0, left: 24.0, right: 24.0),
            color: Color(0xff87CEEB),
          ))
        ],
      )
    ];
  }

  String dtFormat(DateTime dt) =>
      new DateFormat.Hms().format(dt ?? DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.all(10),
              color: Colors.white,
              child: new Column(
                children: <Widget>[
                  Column(
                    children: [
                      Text("VEHICLE", style: headStyle),
                      Text(data.vehicleID ?? "Loading...", style: bodyStyle),
                      space,
                      Text("TIME", style: headStyle),
                      Text(dtFormat(data.datetime), style: bodyStyle),
                      space,
                      Text("LOCATION", style: headStyle),
                      Text(data.location ?? "Loading...", style: bodyStyle),
                      space,
                    ],
                  ),
                  Column(
                    children: [
                      ListTile(
                        onTap: () => onRadioBtnClick(DVIRStatus.NO_DEFECT),
                        title: Text(mode == DVIRStatusPageMode.CREATE
                            ? 'I detected no deficiency in this motor vehicle as would be likely to affect the safety of its operation on result in its mechanical breakdown'
                            : 'Defects corrected'),
                        leading: Radio(
                          value: DVIRStatus.NO_DEFECT,
                          groupValue: status,
                          onChanged: (DVIRStatus value) =>
                              onRadioBtnClick(DVIRStatus.NO_DEFECT),
                        ),
                      ),
                      ListTile(
                        onTap: () => onRadioBtnClick(DVIRStatus.DEFECT),
                        title: Text(mode == DVIRStatusPageMode.CREATE
                            ? 'I detected the following defects defects or defiencies in this motor vehicle that would be likely to affect the safety of its operation on result in its mechanical breakdown.'
                            : 'Defects need to be corrected for safe opearation of vehicle'),
                        leading: Radio(
                          value: DVIRStatus.DEFECT,
                          groupValue: status,
                          onChanged: (DVIRStatus value) =>
                              onRadioBtnClick(value),
                        ),
                      ),
                      space,
                      mode == DVIRStatusPageMode.CREATE &&
                              status == DVIRStatus.DEFECT
                          ? TextField(
                              onChanged: (value) => setState(() {}),
                              keyboardType: TextInputType.multiline,
                              maxLines: 3,
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w600),
                              // controller: emailCtrl,
                              decoration: InputStyle.textFieldLightStyle(
                                hint: "Description",
                                // icon: "assets/ic_email.png",
                              ))
                          : SizedBox(),
                    ],
                  ),
                  ...actionBtns
                ],
              )),
        ));
  }

  onRadioBtnClick(DVIRStatus _status) {
    print(">>> _status" + _status.toString());
    setState(() {
      this.status = _status;
      print(">>> _status" + this.status.toString());
      actionBtns = setActionBtns();
    });
  }

  void onCancelBtn() {}
  void onAddSignBtn() {}
  void onToWorkBtn() {}
  void onFixedBtn() {}
  void onDriverSign() {}

  @override
  void dispose() {
    descriptionCtrl.dispose();
    super.dispose();
  }
}
