import 'dart:io';
import 'dart:ui';

import 'package:driver_app_flutter/API.dart';
import 'package:driver_app_flutter/ui/signature_widget.dart';
import 'package:fdottedline/fdottedline.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:signature/signature.dart';

class SignaturePage extends StatefulWidget {
  @override
  _SignaturePageState createState() => _SignaturePageState();
}

class _SignaturePageState extends State<SignaturePage> {
  var _data;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            //OK AND CLEAR BUTTONS
            Container(
              padding: EdgeInsets.only(top: 15),
              // decoration: const BoxDecoration(color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  //SHOW EXPORTED IMAGE IN NEW ROUTE
                  Stack(children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 15),
                      height: 290,
                      color: Colors.white,
                    ),
                    // Padding(padding: null, child: ,)
                    Center(
                        child: Text(
                      "I hereby certify thath my date entries and my record of duty status for this 24-hour period are true and correct",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                    _data != null
                        ? Center(
                            child: Container(
                                color: Colors.grey[300],
                                child: Image.memory(_data)),
                          )
                        : Positioned(
                            bottom: 25.0,
                            left: 25.0,
                            right: 25.0,
                            top: 35.0,
                            child: Container(
                              child: InkWell(
                                  onTap: () async {
                                    showDialog(
                                        context: context,
                                        builder: (_) =>
                                            new SignatureWidget(onSignSave));
                                  },
                                  child: FDottedLine(
                                    color: Colors.grey.shade400,
                                    strokeWidth: 6.0,
                                    dottedLength: 18.0,
                                    height: 320.0,
                                    width: 300,
                                    space: 10.0,
                                    corner: FDottedLineCorner.all(6.0),
                                  )),
                            ),
                          ),
                  ]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  onSignSave(data) async {
    print("data received");
    // Image.memory(data);
    if (data == null) {
      return;
    }
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              // CupertinoAlertDialog
              title: new Text("Confirm Save"),
              content: new Text("Do you want to save this signature?"),
              actions: <Widget>[
                FlatButton(
                  child: Text('No'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    data = null;
                    setState(() {
                      _data = null;
                    });
                  },
                ),
                FlatButton(
                  child: Text('Yes'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    setState(() {
                      _data = data;
                    });
                    pushSign();
                  },
                )
              ],
            ));
  }

  pushSign() async {
    API.saveSignature(_data, "test.png");
    // todo send to api
  }
}
