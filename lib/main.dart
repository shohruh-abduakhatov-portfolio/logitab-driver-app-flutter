import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:driver_app_flutter/utils/connection_manager.dart';
import 'package:driver_app_flutter/utils/bluetooth_manager.dart';
import 'package:driver_app_flutter/pages/main_page.dart';
import 'package:driver_app_flutter/pages/login.dart';
import 'package:driver_app_flutter/pages/my_vehicles.dart';
import 'package:syncfusion_flutter_core/core.dart';

void main() async {
  SyncfusionLicense.registerLicense(
      "NT8mJyc2IWhia31hfWN9ZmZoYmF8YGJ8ampqanNiYmlmamlmanMDHmggOzw4OyEmODsyMTcmMjsyNzwlEzQ+Mjo/fTA8Pg==");

  await initializeDateFormatting("en_US", null);

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight])
      .then((_) {
    // Network check
    ConnectionStatusSingleton connectionStatus =
        ConnectionStatusSingleton.getInstance();
    connectionStatus.initialize();

    // Location check
    // LocationManageSingleton locationStatus =
    //     LocationManageSingleton.getInstance();
    // locationStatus.initialize();

    // Bluetooth check
    BluetoothManageSingleton blueStatus =
        BluetoothManageSingleton.getInstance();
    blueStatus.initialize();

    runApp(MaterialApp(
        theme: ThemeData(
            // fontFamily: "Roboto",
            primaryColor: Color(0xffffffff),
            primaryColorDark: Color(0xff243665),
            canvasColor: Colors.transparent,
            highlightColor: Color(0x33243665),
            secondaryHeaderColor: Color(0xff222222)),
        debugShowCheckedModeBanner: false,
        initialRoute: '/login/',
        routes: {
          // When we navigate to the "/" route, build
          // '/': (context) => MyApp(),
          '/login/': (context) => LoginPage(),
          '/confirm-vehicle/': (context) => VehiclesPage(),
        })); // warming up
  });
}

// class App extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // return MaterialApp(
//     //   title: 'title'.tr(),
//     //   localizationsDelegates: context.localizationDelegates,
//     //   supportedLocales: context.supportedLocales,
//     //   locale: context.locale,
//     //   theme: ThemeData(
//     //     primarySwatch: Colors.blue,
//     //   ),
//     //   home: MyHomePage(title: 'Easy localization'),
//     // );

//     return MaterialApp(
//         theme: ThemeData(
//             // fontFamily: "Roboto",
//             primaryColor: Color(0xffffffff),
//             primaryColorDark: Color(0xff243665),
//             canvasColor: Colors.transparent,
//             highlightColor: Color(0x33243665),
//             secondaryHeaderColor: Color(0xff222222)),
//         debugShowCheckedModeBanner: false,
//         initialRoute: '/',
//         routes: {
//           // When we navigate to the "/" route, build
//           '/': (context) => MyApp(),
//           // '/account/': (context) => AccountPage(),
//         });
//   }
// }
