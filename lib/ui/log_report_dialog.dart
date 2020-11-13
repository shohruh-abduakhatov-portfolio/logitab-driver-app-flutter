import 'package:driver_app_flutter/ui/pdf_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
// import 'package:simple_pdf_viewer/simple_pdf_viewer.dart';

class LogReport extends StatelessWidget {
  final String url;

  LogReport(this.url);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColorDark,
          title:
              const Text('Log Report', style: TextStyle(color: Colors.white)),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: Container(color: Colors.white, child: new PdfWidget(url)));
  }
}
