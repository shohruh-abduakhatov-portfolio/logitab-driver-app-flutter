import 'package:driver_app_flutter/models/dvir.dart';
import 'package:driver_app_flutter/pages/dvir_create.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class DVIRItemWidget extends StatelessWidget {
  final DVIR data;
  final Function onDelete, onEdit;
  DVIRItemWidget(this.data, {@required this.onDelete, this.onEdit});

  static const mainPadding = EdgeInsets.all(25);
  static const space = SizedBox(height: 20, width: 20);
  static const headStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 20);
  static TextStyle bodyStyle = TextStyle(
    fontWeight: FontWeight.w600,
    color: Colors.grey.shade500,
  );

  static Icon hasSignature(String sign) {
    return isEmpty(sign)
        ? Icon(Icons.check, color: Colors.green.shade400, size: 35)
        : Icon(Icons.close, color: Colors.red.shade400, size: 35);
  }

  static String dateFormat(DateTime date) {
    return new DateFormat.jm().format(date.toLocal());
  }

  static bool isEmpty(String str) {
    return str != null && str.length != 0;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(bottom: 15),
        child: Card(
            elevation: 4,
            child: Container(
                child: Column(children: [
              // Top Container
              Container(
                  padding: mainPadding,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // Left
                        Expanded(
                            child: Container(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Vehicle", style: headStyle),
                                Text(data.vehicleID, style: bodyStyle),
                                space,
                                Text("Status", style: headStyle),
                                Text(
                                    isEmpty(data.status)
                                        ? data.status
                                        : "No defects found",
                                    style: bodyStyle),
                                space,
                                Row(children: [
                                  Text("Driver's \nSignature",
                                      style: headStyle),
                                  space,
                                  hasSignature(data.driverSignature)
                                ]),
                              ]),
                        )),
                        // Right
                        Expanded(
                          child: Container(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(children: [
                                    Icon(Icons.access_time,
                                        color: Colors.green.shade400, size: 35),
                                    space,
                                    Text(dateFormat(data.datetime),
                                        style: bodyStyle),
                                  ]),
                                  space,
                                  Row(children: [
                                    Icon(Icons.location_on,
                                        color: Colors.green.shade400, size: 35),
                                    space,
                                    Text(data.location, style: bodyStyle),
                                  ]),
                                  space,
                                  Row(children: [
                                    Text("Mechanic's \nSignature",
                                        style: headStyle),
                                    space,
                                    hasSignature(data.mechanicsSignature)
                                  ]),
                                ]),
                          ),
                        )
                      ])),
              // space,
              // Bottom Container
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: EdgeInsets.only(right: 25, bottom: 25, left: 25),
                  // color: Colors.red.shade100,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Description", style: headStyle),
                        Text(
                            isEmpty(data.description)
                                ? data.description
                                : "None",
                            style: bodyStyle),
                      ]),
                ),
              ),
              Row(
                children: [
                  // data.status == DVIRStatus.TO_FIX.toString()
                  //     ?
                  Expanded(
                      child: FlatButton(
                    child: Text("DELETE",
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.white)),
                    onPressed: () => onDelete(data.id),
                    padding: EdgeInsets.only(
                        top: 16.0, bottom: 16.0, left: 24.0, right: 24.0),
                    color: Colors.red.shade300,
                  )),
                  // : null,
                  Expanded(
                      child: FlatButton(
                    child: Text("EDIT",
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.white)),
                    onPressed: () => onEdit(data.id),
                    padding: EdgeInsets.only(
                        top: 16.0, bottom: 16.0, left: 24.0, right: 24.0),
                    color: Colors.green.shade300,
                  )),
                ],
              ),
            ]))));
  }
}
