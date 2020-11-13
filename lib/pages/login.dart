import 'dart:convert';

import 'package:driver_app_flutter/API.dart';
import 'package:driver_app_flutter/ui/input_style.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  BuildContext scaffoldContext;
  final loginCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final forgotCtrl = TextEditingController();

  var token = "", deviceId = "", vehicleId = "";
  var loginText = "", passText = "", forgotText = "";
  var processing = false;
  var onLoginView = true;

  initState() {
    super.initState();
    SharedPreferences.getInstance().then((shared) {
      deviceId = shared.getString("deviceId");
      token = shared.getString("auth_token");
      vehicleId = shared.getString('vehicleId');
      isLoggedIn();
      setState(() {});
    });
  }

  @override
  void dispose() {
    loginCtrl.dispose();
    passCtrl.dispose();
    forgotCtrl.dispose();
    super.dispose();
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
                  child: Column(children: [
                    SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      height: 120,
                      child: Image.asset(
                        'assets/logo.png',
                      ),
                    ),
                    SizedBox(
                      height: 42,
                    ),
                    onLoginView ? renderLoginView() : renderForgotPassView(),
                  ]),
                ),
              ),
              FlatButton(
                onPressed: onLoginView
                    ? loginText.length == 0 ||
                            passText.length == 0 ||
                            processing
                        ? null
                        : () => processAuth()
                    : forgotText.length == 0 || processing
                        ? null
                        : () => forgotPassword(),
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
                              onLoginView ? "Получить доступ" : "Send Password",
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

  renderForgotPassView() {
    return Column(children: [
      SizedBox(
          width: 350.0,
          child: TextField(
            onChanged: (value) => {
              setState(() {
                forgotText = value;
                print(forgotText);
              })
            },
            style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.9),
                fontSize: 20.0,
                fontWeight: FontWeight.w600),
            controller: forgotCtrl,
            decoration: InputStyle.textFieldStyle(
                hint: "Email", icon: "assets/ic_email.png"),
          )),
      Container(
        padding: EdgeInsets.only(left: 18, right: 18, top: 10),
        alignment: Alignment.center,
        child: GestureDetector(
            child: Text(
              "Login",
              textAlign: TextAlign.right,
              style: TextStyle(
                  decoration: TextDecoration.underline,
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w400),
            ),
            onTap: () => setState(() {
                  onLoginView = true;
                })),
      ),
    ]);
  }

  renderLoginView() {
    return Column(children: [
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
            controller: loginCtrl,
            decoration: InputStyle.textFieldStyle(
                hint: "Login", icon: "assets/ic_login.png"),
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
            controller: passCtrl,
            decoration: InputStyle.textFieldStyle(
                hint: "Password", icon: "assets/ic_pass.png"),
          )),
      Container(
        padding: EdgeInsets.only(left: 18, right: 18, top: 10),
        alignment: Alignment.center,
        child: GestureDetector(
            child: Text(
              "Forgot Password",
              textAlign: TextAlign.right,
              style: TextStyle(
                  decoration: TextDecoration.underline,
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w400),
            ),
            onTap: () => setState(() {
                  onLoginView = false;
                })),
      ),
    ]);
  }

  void processAuth() async {
    processing = true;
    var login = loginCtrl?.text;
    var pass = passCtrl?.text;
    print(">>> processing $login, $pass");

    FocusScope.of(context).requestFocus(new FocusNode());
    await API.login(login, pass).then((response) {
      // print(">>> response:" + response);
      if (mounted) {
        setState(() {
          if (response.statusCode == 401) {
            final snackBar = SnackBar(
              content: Text('Incorrect username/password',
                  style: TextStyle(fontSize: 20.0)),
              backgroundColor: Colors.red,
            );
            Scaffold.of(scaffoldContext).showSnackBar(snackBar);
          } else if (json.decode(response.body)["status"] == "success") {
            var token = json.decode(response.body)["auth_token"];
            SharedPreferences.getInstance().then((shared) {
              shared.setString("auth_token", token);
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/confirm-vehicle/', (Route<dynamic> route) => false);
            });
          } else {
            final snackBar = SnackBar(
              content: Text('Something went wrong',
                  style: TextStyle(fontSize: 20.0)),
              backgroundColor: Colors.red,
            );
            Scaffold.of(scaffoldContext).showSnackBar(snackBar);
          }
        });
      }
      processing = false;
    }).catchError((onError) {
      processing = false;
      setState(() {});
      print(onError);
      final snackBar = SnackBar(
        content: Padding(
            padding: EdgeInsets.all(4),
            child: Text('Проверьте подключение к интернету',
                style: TextStyle(fontSize: 20.0))),
        backgroundColor: Colors.red,
      );
      Scaffold.of(scaffoldContext).showSnackBar(snackBar);
    });
  }

  void forgotPassword() async {
    var _email = passCtrl?.text.trim();
    print(">>> email: " + _email);
    FocusScope.of(context).requestFocus(new FocusNode());
    await API.forgotPassword(_email).then((response) {
      if (mounted) {
        if (response.statusCode == 200 &&
            json.decode(response.body)["status"] == "success") {
          final snackBar = SnackBar(
            content: Text('Code Sent', style: TextStyle(fontSize: 20.0)),
            backgroundColor: Colors.green,
          );
          Scaffold.of(scaffoldContext).showSnackBar(snackBar);
          setState(() {
            onLoginView = true;
          });
        } else {
          final snackBar = SnackBar(
            content:
                Text('Something went wrong', style: TextStyle(fontSize: 20.0)),
            backgroundColor: Colors.red,
          );
          Scaffold.of(scaffoldContext).showSnackBar(snackBar);
        }
      }
      processing = false;
    }).catchError((onError) {
      print(onError);
      processing = false;
      setState(() {});
      final snackBar = SnackBar(
        content: Padding(
            padding: EdgeInsets.all(4),
            child: Text('Проверьте подключение к интернету',
                style: TextStyle(fontSize: 20.0))),
        backgroundColor: Colors.red,
      );
      Scaffold.of(scaffoldContext).showSnackBar(snackBar);
    });
  }

  void isLoggedIn() {
    print(">> isAuth? $token");
    if (token == null) {
      return;
    }
    processing = true;
    API.isAuthorized().then((response) {
      print(response);
      processing = false;
      // if (mounted) return;
      if (response.statusCode != 200 ||
          json.decode(response.body)["status"] != "success") return;

      if (vehicleId != null) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
      } else {
        Navigator.of(context).pushNamedAndRemoveUntil(
            '/confirm-vehicle/', (Route<dynamic> route) => false);
      }
    }).catchError((onError) => {print(onError)});
  }
}
