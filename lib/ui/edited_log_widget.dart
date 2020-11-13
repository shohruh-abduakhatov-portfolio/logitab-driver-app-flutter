import 'dart:convert';
import 'dart:io';

import 'package:driver_app_flutter/API.dart';
import 'package:driver_app_flutter/models/choice.dart';
import 'package:driver_app_flutter/ui/pdf_widget.dart';
import 'package:driver_app_flutter/ui/tab_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EditedLogWidget extends StatelessWidget {
  final Function onReject, onAccept;
  final int logId;

  EditedLogWidget(this.logId, this.onAccept, this.onReject, {this.urls}) {
    // this.urls = this.urls ?? fetchUrls();
  }

  Map<String, String> urls;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('{Date}', style: TextStyle(color: Colors.white)),
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Theme.of(context).primaryColorDark,
          bottom: TabBar(
            indicatorColor: Colors.deepOrange,
            tabs: [
              TabCard(
                  choice:
                      Choice(title: "CURRENT LOG", icon: Icons.access_time)),
              TabCard(
                  choice: Choice(title: "EDITED LOG", icon: Icons.access_time))
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
                this.onReject();
              },
              icon: Icon(Icons.close),
            ),
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
                this.onAccept();
              },
              icon: Icon(Icons.check),
            ),
          ],
        ),
        body: TabBarView(
          children: [
            new PdfWidget(urls != null ? urls['edited'] : ""),
            new PdfWidget(urls != null ? urls['current'] : ""),
          ],
        ),
      ),
    );
  }

  fetchUrls() async {
    return Map<String, String>();
    // return API.editRequestDetail(logId).then((response) {
    //   if (response.statusCode != 200) return;
    //   return jsonDecode(response.body)['data'];
    // }).catchError((onError) => print(onError));
  }
}
