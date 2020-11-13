import 'package:driver_app_flutter/models/category.dart';
import 'package:driver_app_flutter/pages/login.dart';

import 'package:flutter/material.dart';

class Data {
  static List<Category> categories = [
    // Category("My account", "/account/", "assets/ic_home.png"),
    Category("Home", "/", "assets/ic_account.png"),
    Category(null, null, null),
    // Category("Login", "/login/", "assets/ic_settings.png"),
    // Category("Vehicles", "/confirm-vehicle/", "assets/ic_settings.png"),
    // Category("Logs", "/logs/", "assets/ic_settings.png"),
    Category("Change Password", "/password/edit/", "assets/ic_pass.png"),
    Category("Inspection", "/inspection/", "assets/ic_police.png"),
  ];

  static Category getCategoryFromName(name) {
    return categories.firstWhere(
        (c) => c.name.toLowerCase() == name.toString().toLowerCase());
  }

  static List<Widget> renderMenu(
      String _selectedRoute, Function _onSelectItem) {
    var drawerOptions = new List<Widget>();
    for (var i = 0; i < categories.length; i++) {
      var d = categories[i];
      if (d.name == null) {
        drawerOptions.add(new Divider(
          color: Color.fromRGBO(255, 255, 255, 0.1),
        ));
      } else {
        var color = d.route == _selectedRoute
            ? Colors.white
            : Color.fromRGBO(255, 255, 255, 0.5);
        drawerOptions.add(new Container(
            color: d.route == _selectedRoute
                ? Color.fromRGBO(0, 0, 0, 0.1)
                : Colors.transparent,
            child: new ListTileTheme(
                contentPadding: EdgeInsets.all(0),
                selectedColor: Colors.white,
                dense: true,
                child: new ListTile(
                  contentPadding: EdgeInsets.only(left: 28.0, right: 18.0),
                  leading: Image.asset(
                    d.icon,
                    width: 20,
                    color: color,
                    height: 20,
                  ),
                  title: new Text(
                    d.name,
                    style: new TextStyle(
                        fontSize: 19.0,
                        fontWeight: FontWeight.w400,
                        color: color),
                  ),
                  selected: d.route == _selectedRoute,
                  onTap: () => _onSelectItem(d.route),
                ))));
      }
    }
    return drawerOptions;
  }
}
