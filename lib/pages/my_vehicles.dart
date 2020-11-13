import 'dart:convert';

import 'package:driver_app_flutter/API.dart';
import 'package:driver_app_flutter/pages/main_page.dart';
import 'package:driver_app_flutter/ui/custom_loader_widget.dart';
import 'package:flutter/material.dart';
import 'package:driver_app_flutter/models/vehicle.dart';
import 'package:flutter/services.dart';
import 'package:driver_app_flutter/ui/status_widget.dart';
import 'package:driver_app_flutter/ui/vehicle_list_item.dart';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class VehiclesPage extends StatefulWidget {
  @override
  _VehiclesPageState createState() => _VehiclesPageState();
}

class _VehiclesPageState extends State<VehiclesPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  Vehicle vehicle;
  List<Vehicle> vehicles;

  var geopositionEnabled = true;
  var serverNotAvailable = false;
  var networkFailure = false;
  var serverFailure = false;
  var vehicleSelected = -1;

  void initState() {
    super.initState();
    _loadVehicles();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Theme.of(context)
          .primaryColorDark, //or set color with: Color(0xFF0000FF)
    ));

    return WillPopScope(
        onWillPop: () {
          return new Future(() => true);
        },
        child: Scaffold(
            key: scaffoldKey,
            backgroundColor: Colors.white,
            appBar: PreferredSize(
                preferredSize: Size.fromHeight(164.0),
                child: Material(
                  color: Theme.of(context).primaryColorDark,
                  child: Container(
                    decoration: new BoxDecoration(
                      color: Theme.of(context).primaryColorDark,
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(80, 20, 20, 20),
                          blurRadius:
                              5.0, // has the effect of softening the shadow
                          spreadRadius:
                              1.0, // has the effect of extending the shadow
                          offset: Offset(
                            0.0, // horizontal, move right 10
                            0.0, // vertical, move down 10
                          ),
                        )
                      ],
                    ),
                    padding: const EdgeInsets.only(top: 32.0, bottom: 0.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 4.0, top: 0.0, bottom: 0.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    new SizedBox(
                                        height: 48.0,
                                        width: 48.0,
                                        child: IconButton(
                                          padding: EdgeInsets.only(
                                              left: 10.0,
                                              right: 10.0,
                                              bottom: 10.0,
                                              top: 10.0),
                                          icon: Icon(
                                            Icons.arrow_back,
                                            color: Colors.white,
                                          ),
                                          onPressed: () => logout(),
                                          color: Theme.of(context)
                                              .primaryColorDark,
                                          iconSize: 28,
                                        )),
                                    Container(
                                      margin: EdgeInsets.only(left: 12),
                                      child: Text(
                                        "My Vehicles",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.0),
                                      ),
                                    ),
                                  ]),
                              vehicle != null
                                  ? InkWell(
                                      // borderRadius: BorderRadius.circular(48.0),
                                      onTap: () => _confirmVehicle(),
                                      child: Stack(
                                        children: <Widget>[
                                          new SizedBox(
                                              height: 48.0,
                                              width: 48.0,
                                              child: IconButton(
                                                padding: EdgeInsets.only(
                                                    left: 10.0,
                                                    right: 10.0,
                                                    bottom: 10.0,
                                                    top: 10.0),
                                                icon: Icon(
                                                  Icons.check,
                                                  color: Colors.white,
                                                ),
                                                onPressed: () =>
                                                    _confirmVehicle(),
                                                color: Theme.of(context)
                                                    .primaryColorDark,
                                                iconSize: 28,
                                              )),
                                        ],
                                      ),
                                    )
                                  : new Container(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
            body: RefreshIndicator(
                key: refreshKey,
                onRefresh: () => _loadVehicles(),
                child: Material(
                    child: Container(
                        decoration: new BoxDecoration(color: Colors.white),
                        child: SingleChildScrollView(
                            child: Column(children: <Widget>[
                          networkFailure
                              ? StatusWidget(
                                  "Проверьте соединение с интернетом")
                              : SizedBox(),
                          serverFailure
                              ? StatusWidget("Сервер временно недоступен")
                              : SizedBox(),
                          Column(children: <Widget>[
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(
                                  left: 16.0,
                                  right: 16.0,
                                  top: 10.0,
                                  bottom: 10.0),
                              child: Text(
                                "Confirm vehicle:",
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromRGBO(0, 0, 0, 0.5)),
                              ),
                            ),
                            vehicles == null
                                ? CustomLoaderWidget()
                                : Container(
                                    margin: EdgeInsets.only(
                                        left: 12, right: 8, bottom: 12),
                                    child: Material(
                                      child: ListView.separated(
                                        itemCount: vehicles.length,
                                        separatorBuilder: (context, index) {
                                          return Divider();
                                        },
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          return VehicleListItem(
                                            vehicles[index],
                                            id: vehicleSelected,
                                            onChanged: _selectVehicle,
                                          );
                                        },
                                      ),
                                    ))
                          ])
                        ]))))))
        // )
        );
  }

  logout() {
    // todo logout
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              // CupertinoAlertDialog
              title: new Text("Log out"),
              content: new Text("You will be returned to login screen."),
              actions: <Widget>[
                FlatButton(
                  child: Text('LOG OUT'),
                  onPressed: () {
                    SharedPreferences.getInstance().then((shared) {
                      shared.setString("auth_token", null);
                      shared.setString("vehicleId", null);
                      shared.setString("driverId", null);
                    });
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/login/', (Route<dynamic> route) => false);
                  },
                ),
                FlatButton(
                  child: Text('CANCEL'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
    print("logout");
  }

  void _confirmVehicle() {
    if (vehicle == null) {
      return;
    }
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              // CupertinoAlertDialog
              title: new Text("Email to send"),
              content: new Text(
                  "Would you like to select vehicle:\n${vehicle.toString()}?"),
              actions: <Widget>[
                FlatButton(
                  child: Text('CANCEL'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                FlatButton(
                  child: Text('CONFIRM'),
                  onPressed: () {
                    onVehicleConfirmed();
                    SharedPreferences.getInstance()
                        .then((value) => value.setInt("vehicleId", vehicle.id));

                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => MyApp()),
                        ModalRoute.withName("/"));
                    // Navigator.of(context).pushNamedAndRemoveUntil(
                    //     '/', (Route<dynamic> route) => false);
                  },
                )
              ],
            ));
    print("confirm vehicle ${vehicle}");
  }

  void onVehicleConfirmed() async {}

  _loadVehicles() async {
    setState(() {
      vehicleSelected = -1;
      vehicle = null;
    });
    print(">>> LOADING DATA");

    await API.vehiclesList().then((response) {
      if (!mounted) return Future(null);
      if (response.statusCode == 401) {
        Navigator.of(context).pushNamedAndRemoveUntil(
            '/login/', (Route<dynamic> route) => false);
      }
      if (response.statusCode != 200) return Future(null);
      var parsed = jsonDecode(response.body);
      var driver = parsed['driver'];
      SharedPreferences.getInstance()
          .then((shared) => {shared.setInt("driverId", driver['id'])});
      // var _vehicles =
      //     parsed['vehicles'].map((i) => Vehicle.fromJson(i)).toList<Vehicle>();
      List<Vehicle> _vehicles = new List();
      for (int i = 0; i < parsed['vehicles'].length; i++) {
        _vehicles.add(Vehicle.fromJson(parsed['vehicles'][i]));
      }
      setState(() {
        vehicles = _vehicles;
      });
    }).catchError((onError, stack) {
      print(">>onError");
      print(onError);
      print(stack);
    });
  }

  // copyData()

  _selectVehicle(Vehicle v) {
    setState(() {
      vehicle = v;
      vehicleSelected = v.id;
    });
  }
}
