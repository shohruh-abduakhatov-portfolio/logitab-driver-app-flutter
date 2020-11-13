import 'dart:convert';

import 'package:driver_app_flutter/API.dart';
import 'package:driver_app_flutter/event/route_event.dart';
import 'package:driver_app_flutter/models/log_edit.dart';
import 'package:driver_app_flutter/pages/main_page.dart';
import 'package:driver_app_flutter/ui/edited_log_widget.dart';
import 'package:flutter/material.dart';
import 'package:driver_app_flutter/rxbus.dart';
import 'package:intl/intl.dart';

class LogEditRequestListItem extends StatefulWidget {
  final LogEdit logEdit;
  final Function onUpdate;

  LogEditRequestListItem(this.logEdit, this.onUpdate);

  @override
  LogEditRequestListItemState createState() {
    return new LogEditRequestListItemState();
  }
}

class LogEditRequestListItemState extends State<LogEditRequestListItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        showDialog(
            context: context,
            builder: (_) => new EditedLogWidget(
                widget.logEdit.id,
                () => _action(API.acceptEditRequest),
                () => _action(API.rejectEditRequest)));
      },
      child: Container(
        margin:
            EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0, bottom: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  "LOG EDIT REQUEST: ${widget.logEdit.id}",
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 4),
                Text(
                  DateFormat('MMM-dd, yyyy h:mm a')
                      .format(widget.logEdit.dateCreated),
                  style: TextStyle(
                      fontSize: 17, color: Color.fromRGBO(0, 0, 0, 0.7)),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                rederActionBtn(
                    Icons.check, Colors.green.shade400, _acceptLogEdit),
                rederActionBtn(
                  Icons.clear,
                  Colors.red.shade400,
                  _rejectLogEdit,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget rederActionBtn(IconData icon, Color color, Function action) {
    return new SizedBox(
        height: 48.0,
        width: 48.0,
        child: IconButton(
          padding:
              EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0, top: 10.0),
          icon: Icon(
            icon,
            color: color,
          ),
          onPressed: () => action(),
          color: color,
          iconSize: 28,
        ));
  }

  bool _verifyAction(TextSpan text, func, api) {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              // CupertinoAlertDialog
              title: new Text("Confirm Action"),
              content: RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(text: 'Would you like to '),
                    text,
                    TextSpan(text: ' log edit request?'),
                  ],
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('CANCEL'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                FlatButton(
                  child: Text('YES'),
                  onPressed: () => func(api),
                )
              ],
            ));
  }

  _acceptLogEdit() {
    print(">> _acceptLogEdit");
    if (!_verifyAction(
        TextSpan(
            text: 'ACCEPT',
            style: TextStyle(color: Colors.lightGreen.shade400)),
        _action,
        API.acceptEditRequest)) {
      return;
    }
  }

  _rejectLogEdit() {
    print(">> _rejectLogEdit");
    if (!_verifyAction(
        TextSpan(text: 'REJECT', style: TextStyle(color: Colors.red.shade400)),
        _action,
        API.acceptEditRequest)) {
      return;
    }
  }

  _action(Function api) {
    print(">>> removing: $widget.logEdit.id");

    // api(widget.logEdit.id).then((response) {
    //   if (response.statusCode == 401) {
    //     Navigator.of(context).pushNamedAndRemoveUntil(
    //         '/login/', (Route<dynamic> route) => false);
    //   }
    //   if (response.statusCode != 200) return;
    //   setState(() {
    //     widget.onUpdate(widget.logEdit.id);
    //   });
    // }).catchError((onError) => print(onError));
  }
}
