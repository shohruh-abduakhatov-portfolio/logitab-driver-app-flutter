import 'package:geolocator/geolocator.dart';
import 'dart:async'; //For StreamController/Stream
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:android_intent/android_intent.dart';

class LocationManageSingleton {
  GeolocationStatus geolocationStatus;
  bool hasConnection = false;

  static final LocationManageSingleton _singleton =
      new LocationManageSingleton._internal();
  LocationManageSingleton._internal();

  //This is what's used to retrieve the instance through the app
  static LocationManageSingleton getInstance() => _singleton;

  StreamController locController = new StreamController.broadcast();
  //This is how we'll allow subscribing to connection changes

  void initialize() {
    checkConnection();
  }

  Stream get connectionChange => locController.stream;

  void dispose() {
    locController.close();
  }

  Future<bool> checkConnection() async {
    Geolocator geolocator = Geolocator()..forceAndroidLocationManager = true;
    geolocationStatus = await geolocator.checkGeolocationPermissionStatus();
    bool previousConnection = hasConnection;

    if (geolocationStatus.value == 1) {
      print('Location is available');
      hasConnection = true;
    } else {
      print('Location is NOT available, device may be incompatible');
      hasConnection = false;
    }

    //The connection status changed send out an update to all listeners
    if (previousConnection != hasConnection) {
      locController.add(hasConnection);
    }

    return hasConnection;
  }
}

class LocationRequestWindow {
  LocationRequestWindow(this.context) {
    _gpsService();
  }

  final BuildContext context;

  Future _checkGps() async {
    print("_checkGps");
    if (!(await Geolocator().isLocationServiceEnabled())) {
      if (Theme.of(context).platform == TargetPlatform.android) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Can't get gurrent location"),
                content:
                    const Text('Please make sure you enable GPS and try again'),
                actions: <Widget>[
                  FlatButton(
                      child: Text('Ok'),
                      onPressed: () {
                        final AndroidIntent intent = AndroidIntent(
                            action:
                                'android.settings.LOCATION_SOURCE_SETTINGS');
                        intent.launch();
                        Navigator.of(context, rootNavigator: true).pop();
                        _gpsService();
                      })
                ],
              );
            });
      }
    }
  }

  /*Check if gps service is enabled or not*/
  Future _gpsService() async {
    print("_gpsService");
    if (!(await Geolocator().isLocationServiceEnabled())) {
      _checkGps();
      return null;
    } else
      return true;
  }
}

/*Checking if your App has been Given Permission*/
Future<bool> requestLocationPermission({Function onPermissionDenied}) async {
  print("requestLocationPermission");
  final PermissionHandler _permissionHandler = PermissionHandler();
  var result =
      await _permissionHandler.requestPermissions([PermissionGroup.location]);
  if (result[PermissionGroup.location] != PermissionStatus.granted) {
    requestLocationPermission();
  }
  debugPrint('requestContactsPermission $result[PermissionGroup.location]');
  return true;
}
