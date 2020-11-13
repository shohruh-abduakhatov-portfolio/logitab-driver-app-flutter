import 'dart:convert';

import 'package:driver_app_flutter/API.dart';
import 'package:driver_app_flutter/ui/input_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class InspectionEmail extends StatefulWidget {
  @override
  _InspectionEmailState createState() => _InspectionEmailState();
}

class _InspectionEmailState extends State<InspectionEmail> {
  BuildContext scaffoldContext;
  final emailCtrl = TextEditingController();
  String emailText = "";

  var processing = false;

  initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorDark,
        title: const Text('Inspection Email',
            style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
          color: Theme.of(context).primaryColorDark,
          child: new Column(
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
                          onChanged: (value) => setState(() {
                            emailText = value;
                            print(emailText);
                          }),
                          style: TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 0.9),
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600),
                          controller: emailCtrl,
                          decoration: InputStyle.textFieldStyle(
                              hint: "Email Address",
                              icon: "assets/ic_email.png"),
                        )),
                  ]),
                ),
              ),
              FlatButton(
                onPressed: emailText.length == 0 || processing
                    ? null
                    : () => sendEmail(),
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
                              "SEND",
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
          )),
    );
  }

  void sendEmail() async {
    // processing = true;
    // var _currPass = emailCtrl?.text;
    // print(">>> processing ${_currPass}, ${_newPass}");

    // FocusScope.of(context).requestFocus(new FocusNode());

    // API.changePassword(_currPass).then((response) {
    //   if (mounted) {
    //     if (response.statusCode == 401) {
    //       final snackBar = SnackBar(
    //         content:
    //             Text('Incorrect password', style: TextStyle(fontSize: 20.0)),
    //         backgroundColor: Colors.red,
    //       );
    //       Scaffold.of(scaffoldContext).showSnackBar(snackBar);
    //     } else if (json.decode(response.body)["status"] == "success") {
    //       Navigator.of(context).pop();
    //     } else {
    //       final snackBar = SnackBar(
    //         content:
    //             Text('Something went wrong', style: TextStyle(fontSize: 20.0)),
    //         backgroundColor: Colors.red,
    //       );
    //       Scaffold.of(scaffoldContext).showSnackBar(snackBar);
    //     }
    //   }
    // }).catchError((onError) {
    //   final snackBar = SnackBar(
    //     content: Padding(
    //         padding: EdgeInsets.all(4),
    //         child: Text('Проверьте подключение к интернету',
    //             style: TextStyle(fontSize: 20.0))),
    //     backgroundColor: Colors.red,
    //   );
    //   Scaffold.of(scaffoldContext).showSnackBar(snackBar);
    //   processing = true;
    //   setState(() {});
    // });
  }
}
