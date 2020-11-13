import 'package:flutter_blue/flutter_blue.dart';
import 'dart:async'; //For StreamController/Stream

class BluetoothManageSingleton {
  FlutterBlue flutterBlue = FlutterBlue.instance;
  bool hasConnection = false;

  static final BluetoothManageSingleton _singleton =
      new BluetoothManageSingleton._internal();
  BluetoothManageSingleton._internal();

  //This is what's used to retrieve the instance through the app
  static BluetoothManageSingleton getInstance() => _singleton;

  StreamController blueConnController = new StreamController.broadcast();
  //This is how we'll allow subscribing to connection changes

  void initialize() {
    checkConnection();
  }

  Stream get connectionChange => blueConnController.stream;

  void dispose() {
    blueConnController.close();
  }

  Future<bool> checkConnection() async {
    bool previousConnection = hasConnection;

    flutterBlue.isOn.then((bool isOn) {
      if (isOn) {
        print('bluetooth is available');
        hasConnection = true;
      } else {
        print('bluetooth is NOT available, device may be incompatible');
        hasConnection = false;
      }
    });

    //The connection status changed send out an update to all listeners
    if (previousConnection != hasConnection) {
      blueConnController.add(hasConnection);
    }

    return hasConnection;
  }
}
