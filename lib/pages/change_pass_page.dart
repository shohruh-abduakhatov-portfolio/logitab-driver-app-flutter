import 'dart:convert';

import 'package:driver_app_flutter/API.dart';
import 'package:driver_app_flutter/ui/input_style.dart';
import 'package:driver_app_flutter/ui/signature_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePassPage extends StatefulWidget {
  @override
  _ChangePassPageState createState() => _ChangePassPageState();
}

class _ChangePassPageState extends State<ChangePassPage> {
  BuildContext scaffoldContext;
  final currentPassCtrl = TextEditingController();
  final newPassCtrl = TextEditingController();

  var token = "", deviceId = "";
  var loginText = "", passText = "";
  var processing = false;

  initState() {
    super.initState();

    // showDialog(context: context, builder: (_) => new SignatureWidget(null));
    SharedPreferences.getInstance().then((shared) {
      deviceId = shared.getString("deviceId");
      token = shared.getString("token");
      setState(() {});
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    currentPassCtrl.dispose();
    newPassCtrl.dispose();
    super.dispose();
    // exit(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColorDark,
        body: new Builder(builder: (BuildContext context) {
          scaffoldContext = context;
          return new Column(
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  child: Column(children: <Widget>[
                    SizedBox(
                      height: 60,
                    ),
                    SizedBox(
                        width: 350.0,
                        child: TextField(
                          onChanged: (value) => {
                            setState(() {
                              loginText = value;
                              print(loginText);
                            })
                          },
                          style: TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 0.9),
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600),
                          controller: currentPassCtrl,
                          decoration: InputStyle.textFieldStyle(
                              hint: "Current Password",
                              icon: "assets/ic_pass.png"),
                        )),
                    SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                        // password box
                        width: 350.0,
                        child: TextField(
                          onChanged: (value) => {
                            setState(() {
                              passText = value;
                              print(passText);
                            })
                          },
                          obscureText: true,
                          style: TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 0.9),
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600),
                          controller: newPassCtrl,
                          decoration: InputStyle.textFieldStyle(
                              hint: "New Password", icon: "assets/ic_pass.png"),
                        )),
                  ]),
                ),
              ),
              FlatButton(
                onPressed:
                    loginText.length == 0 || passText.length == 0 || processing
                        ? null
                        : () => changePass(),
                disabledColor: Colors.black26,
                child: Container(
                    padding: EdgeInsets.only(left: 24.0, right: 24.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(right: 8.0, left: 12.0),
                            child: Text(
                              "SAVE",
                              maxLines: 1,
                              style: TextStyle(
                                  color: Color(0xff243665),
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w500),
                            ))
                      ],
                    )),
                padding: EdgeInsets.symmetric(vertical: 16.0),
                color: Color(0xff87CEEB),
              )
            ],
          );
        }));
  }

  void changePass() async {
    processing = true;
    var _currPass = currentPassCtrl?.text;
    var _newPass = newPassCtrl?.text;
    print(">>> processing ${_currPass}, ${_newPass}");

    FocusScope.of(context).requestFocus(new FocusNode());

    API.changePassword(_currPass, _newPass).then((response) {
      if (mounted) {
        if (response.statusCode == 401) {
          final snackBar = SnackBar(
            content:
                Text('Incorrect password', style: TextStyle(fontSize: 20.0)),
            backgroundColor: Colors.red,
          );
          Scaffold.of(scaffoldContext).showSnackBar(snackBar);
        } else if (json.decode(response.body)["status"] == "success") {
          Navigator.of(context).pop();
        } else {
          final snackBar = SnackBar(
            content:
                Text('Something went wrong', style: TextStyle(fontSize: 20.0)),
            backgroundColor: Colors.red,
          );
          Scaffold.of(scaffoldContext).showSnackBar(snackBar);
        }
      }
    }).catchError((onError) {
      final snackBar = SnackBar(
        content: Padding(
            padding: EdgeInsets.all(4),
            child: Text('Проверьте подключение к интернету',
                style: TextStyle(fontSize: 20.0))),
        backgroundColor: Colors.red,
      );
      Scaffold.of(scaffoldContext).showSnackBar(snackBar);
      processing = true;
      setState(() {});
    });
  }
}
