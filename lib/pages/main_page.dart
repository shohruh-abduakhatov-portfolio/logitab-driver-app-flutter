import 'dart:io';
import 'dart:math';

// import 'package:geolocator/geolocator.dart';
// import 'package:device_id/device_id.dart';
import 'package:driver_app_flutter/data.dart';
import 'package:driver_app_flutter/event/error_event.dart';
import 'package:driver_app_flutter/models/check_status.dart';
import 'package:driver_app_flutter/models/choice.dart';
import 'package:driver_app_flutter/models/log_edit.dart';
import 'package:driver_app_flutter/pages/change_pass_page.dart';
import 'package:driver_app_flutter/pages/duty_status_page.dart';
import 'package:driver_app_flutter/pages/dvir_create.dart';
import 'package:driver_app_flutter/pages/inspection_page.dart';
import 'package:driver_app_flutter/pages/signature_page.dart';
import 'package:driver_app_flutter/ui/checkbox_labeled.dart';
import 'package:driver_app_flutter/ui/home_widget.dart';
import 'package:driver_app_flutter/pages/login.dart';
import 'package:driver_app_flutter/pages/logs_page.dart';
import 'package:driver_app_flutter/ui/signature_widget.dart';
import 'package:driver_app_flutter/ui/status_widget.dart';
import 'package:driver_app_flutter/ui/tab_bar_widget.dart';
import 'package:driver_app_flutter/ui/tab_widget.dart';
import 'package:driver_app_flutter/utils/main_page_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:collection';
import 'dart:io' show Platform;
import 'package:async/async.dart';
import 'dart:async';
import 'dart:io';
import 'package:driver_app_flutter/rxbus.dart';
import 'package:driver_app_flutter/event/search_event.dart';
import 'package:driver_app_flutter/event/route_event.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  Animation<double> animation;
  Animation<double> transitionAnimation;
  AnimationController controller;
  AnimationController transitionController;

  var geopositionEnabled = true;
  var serverNotAvailable = false;
  var networkFailure = false;
  var serverFailure = false;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String _selectedRoute;
  var routes = new List();

  var _delay;
  var focused = false;
  var _showShadow = true;
  var _showBackBtn = false;
  var _showHomeBar = true;
  var _showFloatingBtn = true;
  var scroll = true;
  var pattern;

  Timer _timer;
  String _nowTime, _nowDate;
  String _pageTitle;
  String _floatingBtnPath = "/duty-status/create/";
  CancelableOperation suggestion;
  FocusNode _focus = new FocusNode();

  TabController tabController;
  ScrollController _scrollViewController;

  Widget body = Container();

  void initState() {
    super.initState();
    startTimer();

    WidgetsBinding.instance.renderView.automaticSystemUiAdjustment = false;

    // requestLocationPermission();
    // new LocationRequestWindow(context);

    WidgetsBinding.instance.addObserver(this);
    _focus.addListener(_onFocusChange);

    RxBus.register<SearchEvent>().listen((event) {
      if (event.text == "") {
        focused = false;
        controller.reverse();
      } else {
        focused = true;
      }
      setState(() {});
    });

    RxBus.register<RouteEvent>().listen((event) {
      _onOpen(event.route, event);
    });

    RxBus.register<ErrorEvent>().listen((event) {
      _onErrorEvent(event.error);
    });

    _scrollViewController = new ScrollController();
    tabController = new TabController(vsync: this, length: choices.length);

    controller = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
    animation = Tween(begin: 48.0, end: 0.0).animate(controller)
      ..addListener(() {
        setState(() {
          // the state that has changed here is the animation object’s value
        });
      });
    transitionController = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
    transitionAnimation =
        Tween(begin: 24.0, end: 0.0).animate(transitionController)
          ..addListener(() {
            setState(() {
              // the state that has changed here is the animation object’s value
            });
          });

    _onOpen("/");
  }

  dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _focus.dispose();
    controller.dispose();

    _scrollViewController.dispose();
    tabController.dispose();
    _timer.cancel();

    super.dispose();
  }

  void pop() {
    routes.removeLast();
    var route = routes.last;
    _selectedRoute = route;
    _getDrawerItemScreen(_selectedRoute);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Theme.of(context)
            .primaryColorDark, //or set color with: Color(0xFF0000FF)
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light));

    // Draw menu drawer
    List<Widget> drawerOptions = [];
    drawerOptions.add(Container(
        padding: EdgeInsets.only(bottom: 8.0, right: 30.0),
        child: SizedBox(
          height: 80,
          child: Image.asset(
            'assets/logo.png',
          ),
        )));
    drawerOptions += Data.renderMenu(_selectedRoute, _onSelectItem);

    return WillPopScope(
      onWillPop: () {
        if (!focused) {
          if (routes.length > 0) {
            pop();
          }
        } else {
          focused = false;
          setState(() {});
          return null;
        }
        return new Future(() => routes.length < 1);
      },
      child: Scaffold(
        drawer: Container(
          color: Theme.of(context).primaryColorDark,
          padding: EdgeInsets.only(left: 0.0, top: 16.0),
          width: MediaQuery.of(context).size.width - 40 < 310.0
              ? MediaQuery.of(context).size.width - 40
              : 310.0,
          child: ListView(children: drawerOptions),
        ),
        key: scaffoldKey,
        backgroundColor: Colors.grey.shade100,
        body: new NestedScrollView(
          controller: _scrollViewController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              new SliverAppBar(
                backgroundColor: Theme.of(context).primaryColorDark,
                brightness: Brightness.light,
                iconTheme: IconThemeData(
                  color: Colors.white,
                ),
                leading: Row(children: [
                  _showHomeBar
                      ? new SizedBox(
                          height: 48.0,
                          width:
                              animation.value > 48.0 ? 48.0 : animation.value,
                          child: IconButton(
                            icon: Image.asset(
                              'assets/ic_menu.png',
                              height: 18,
                              color: Colors.white,
                              fit: BoxFit.contain,
                            ),
                            onPressed: () =>
                                scaffoldKey.currentState.openDrawer(),
                            color: Theme.of(context).primaryColorDark,
                            iconSize: 28,
                          ))
                      : new SizedBox(),
                  _showBackBtn
                      ? new SizedBox(
                          height: 48.0,
                          width:
                              animation.value > 48.0 ? 48.0 : animation.value,
                          child: IconButton(
                            icon: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                            onPressed: () => _onOpen("/"),
                            color: Theme.of(context).primaryColorDark,
                            iconSize: 28,
                          ))
                      : new SizedBox(),
                ]),
                actions: [
                  _showHomeBar
                      ? IconButton(
                          icon: Icon(Icons.alarm_add),
                          tooltip: 'Check in/out',
                          onPressed: () => {}, //_showCheckInOutDialog(),
                        )
                      : new SizedBox(),
                ],
                textTheme: TextTheme(
                  headline6: TextStyle(
                      fontFamily: 'RobotoMono',
                      color: Colors.deepOrange,
                      fontSize: 36.0),
                ),
                pinned: true, //<-- pinned to true
                floating: true, //<-- floating to true
                flexibleSpace: FlexibleSpaceBar(
                  titlePadding: EdgeInsets.zero,
                  centerTitle: true,
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                                margin: EdgeInsets.only(top: 24),
                                child: RichText(
                                  text: _pageTitle != null
                                      ? TextSpan(
                                          text: _pageTitle,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 25))
                                      : TextSpan(
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14.0),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: _nowDate,
                                                style: TextStyle(
                                                    color:
                                                        Colors.grey.shade300)),
                                            TextSpan(text: "  "),
                                            TextSpan(
                                                text: _nowTime,
                                                style: TextStyle(fontSize: 16)),
                                          ],
                                        ),
                                )),
                          ]),
                    ],
                  ),
                ),
                forceElevated:
                    innerBoxIsScrolled, //<-- forceElevated to innerBoxIsScrolled
                bottom: _showHomeBar
                    ? TabBar(
                        tabs: choices.map((Choice choice) {
                          return TabCard(choice: choice);
                        }).toList(),
                        // onTap: (value) => _onTabChange(value),
                        controller: tabController,
                        indicatorColor: Colors.deepOrange,
                      )
                    : null,
              ),
            ];
          },
          body: Column(
            children: [
              networkFailure
                  ? StatusWidget("Проверьте соединение с интернетом")
                  : SizedBox(),
              serverFailure
                  ? StatusWidget("Сервер временно недоступен")
                  : SizedBox(),
              body
            ],
          ),
        ),
        floatingActionButton: _showFloatingBtn
            ? FloatingActionButton(
                onPressed: () {
                  _onOpen(_floatingBtnPath);
                },
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                backgroundColor: Theme.of(context).primaryColorDark,
              )
            : SizedBox(),
      ),
    );
  }

  void startTimer() {
    _nowDate = dtToString('MMM-dd');
    _nowTime = dtToString('h:mm a');

    _timer = new Timer.periodic(
      Duration(minutes: 1),
      (Timer timer) => setState(
        () {
          // if (!mounted) return;
          setState(() {
            _nowDate = dtToString('MMM-dd');
            _nowTime = dtToString('h:mm a');
          });
        },
      ),
    );
  }

  _getDrawerItemScreen(String route, [RouteEvent data]) {
    routes.add(route);
    _showShadow = true;

    setState(() {
      _floatingBtnPath = MyRoute.INSERT_DUTY_STATUS;
    });
    print("${_floatingBtnPath} - $route");
    if (route == "/") {
      routes.clear();
      _pageTitle = null;
      _showBackBtn = false;
      _showHomeBar = true;
      _showFloatingBtn = true;
      body = HomeWidget(controller: tabController);
      return;
    } else if (route == "/logs/") {
      _pageTitle = "Logs";
      _showBackBtn = true;
      _showHomeBar = false;
      _showFloatingBtn = false;
      body = HomeWidget(screen: new LogsPage());
    } else if (route == "/password/edit/") {
      _pageTitle = "Change Password";
      _showBackBtn = true;
      _showHomeBar = false;
      _showFloatingBtn = false;
      body = HomeWidget(screen: new ChangePassPage());
    } else if (route == "/inspection/") {
      _pageTitle = "Inspection Module";
      _showBackBtn = true;
      _showHomeBar = false;
      _showFloatingBtn = false;
      body = HomeWidget(screen: new InspectionPage());
    } else if (route == "/duty-status/create/") {
      _pageTitle = "Insert Duty Status";
      _showBackBtn = true;
      _showHomeBar = false;
      _showFloatingBtn = false;
      body = HomeWidget(screen: new DutyStatusPage());
    } else if (route == "/dvir/") {
      _floatingBtnPath = "/dvir/create/";
    } else if (route == MyRoute.DVIR_CREATE) {
      _pageTitle = "New DVIR";
      _showBackBtn = true;
      _showHomeBar = false;
      _showFloatingBtn = false;
      body = HomeWidget(screen: new DVIRStatusPage());
    } else if (route == MyRoute.DVIR_EDIT) {
      _pageTitle = "Edit DVIR";
      _showBackBtn = true;
      _showHomeBar = false;
      _showFloatingBtn = false;
      _floatingBtnPath = "/dvir/create/";
      body = HomeWidget(screen: new DVIRStatusPage(data: data.data));
    } else if (route == MyRoute.SET_DUTY_STATUS) {
      _pageTitle = "Change Duty Status";
      _showBackBtn = true;
      _showHomeBar = false;
      _showFloatingBtn = false;
      body = HomeWidget(screen: new DutyStatusPage(data: data.data));
    } else if (route == MyRoute.CHANGE_DUTY_STATUS) {
      _pageTitle = "Update Duty Status";
      _showBackBtn = true;
      _showHomeBar = false;
      _showFloatingBtn = false;
      body = HomeWidget(
          screen:
              new DutyStatusPage(data: data.data, mode: DutyStatusEnum.EDIT));
    } else if (route == MyRoute.INSERT_DUTY_STATUS) {
      _pageTitle = "Insert Duty Status";
      _showBackBtn = true;
      _showHomeBar = false;
      _showFloatingBtn = false;
      body = HomeWidget(
          screen: new DutyStatusPage(data: null, mode: DutyStatusEnum.INSERT));
    }
  }

  _onOpen(String route, [RouteEvent data]) {
    focused = false;
    if (route != null) {
      if (_selectedRoute == null || route.compareTo(_selectedRoute) != 0) {
        transitionController.reset();
        transitionController.forward();

        _selectedRoute = route;
        _getDrawerItemScreen(_selectedRoute, data);
        setState(() {});
      }
    } else {
      pop();
    }
  }

  _onErrorEvent(event) {
    switch (event) {
      case MyError.SERVER_UNAVAILABLE:
        serverNotAvailable = true;
        break;
      default:
    }
    setState(() {});
  }

  void _onFocusChange() {
    if (_focus.hasFocus) {
      // if (!focused) {
      controller.forward();
      // }
    }
    focused = _focus.hasFocus;
  }

  _onSelectItem(String route) {
    _onOpen(route);
    Navigator.of(context).pop();
  }

  // var check_status = CheckStatus.CHECKED_OUT;
  // var currentCheckStatus = " ";
  // var checkboxInd = 0;
  // _showCheckInOutDialog() {
  //   var text = "Please enter your status";
  //   var btnText = "Check In";
  //   Function action = _checkIn;

  //   if (check_status != CheckStatus.CHECKED_OUT) {
  //     text = "Do you want to change your status?";
  //     btnText = "Check Out";
  //     action = _checkOut;
  //   }

  //   showDialog(
  //       context: context,
  //       builder: (_) => new AlertDialog(
  //             title: new Text(text),
  //             content: Column(
  //               children: [
  //                 LabeledCheckbox(
  //                   label: 'Other',
  //                   index: 0,
  //                   selected: checkboxInd,
  //                   onChanged: onCheckStatus,
  //                 ),
  //                 LabeledCheckbox(
  //                   label: 'Delivery',
  //                   index: 1,
  //                   selected: checkboxInd,
  //                   onChanged: onCheckStatus,
  //                 ),
  //                 // LabeledCheckbox(
  //                 //   label: 'Pick Up',
  //                 //   index: 2,
  //                 //   selected: checkboxInd,
  //                 //   onChanged: onCheckStatus,
  //                 // ),
  //               ],
  //             ),
  //             actions: <Widget>[
  //               FlatButton(
  //                   child: Text(btnText), onPressed: () => action(context)),
  //               FlatButton(
  //                 child: Text('CANCEL'),
  //                 onPressed: () {
  //                   Navigator.of(context).pop();
  //                 },
  //               )
  //             ],
  //           ));
  // }

  // void onCheckStatus(int index) {
  //   setState(() {
  //     checkboxInd = index;
  //   });
  // }

  void _checkIn(BuildContext cntx) {
    // cntx.widget.
  }

  void _checkOut(cntx) {}
}
