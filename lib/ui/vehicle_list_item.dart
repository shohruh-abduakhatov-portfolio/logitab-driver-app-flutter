import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:driver_app_flutter/rxbus.dart';
import 'package:driver_app_flutter/models/vehicle.dart';
import 'package:driver_app_flutter/event/route_event.dart';

class VehicleListItem extends StatelessWidget {
  final Vehicle vehicle;
  final Function onChanged;
  final int id;

  VehicleListItem(this.vehicle, {this.id = -1, this.onChanged});

  @override
  Widget build(BuildContext context) {
    print(">> VehicleListItem: redraw ${vehicle.id}");
    return InkWell(
      onTap: () {
        onChanged(vehicle);
      },
      child: Column(
        children: <Widget>[
          new Container(
            height: 2.0,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(top: 10.0, right: 10.0, left: 4.0),
                  child: Image.asset(
                    'assets/ic_truck.png',
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                  )),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 6, right: 8, top: 6, bottom: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "${vehicle.id} ${vehicle.make} / ${vehicle.model}",
                        style: TextStyle(
                            color: Color.fromRGBO(0, 0, 0, 0.9),
                            fontWeight: FontWeight.w500,
                            fontSize: 18.0),
                      ),
                      true
                          ? Container(
                              color: Color(0xff2EAB2E),
                              margin: EdgeInsets.only(top: 4, bottom: 4),
                              padding: EdgeInsets.only(
                                  left: 6, right: 6, top: 2, bottom: 2),
                              child: Text(
                                "${vehicle.vin}",
                                style: TextStyle(
                                    color: Color(0xffffffff), fontSize: 14),
                              ))
                          : SizedBox(),
                      SizedBox(height: 3),
                      true
                          ? Container(
                              padding: EdgeInsets.only(top: 4.0),
                              child: Text(
                                "${vehicle.notes}",
                                style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 17.0),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),
              Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.only(top: 0.0),
                  child: RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: "${vehicle.serialNo}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            color: Color(0xffE23E43))),
                  ]))),
              Checkbox(
                value: id == vehicle.id ? true : false,
                onChanged: (bool newValue) {
                  onChanged(vehicle);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
