import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
// import 'package:simple_pdf_viewer/simple_pdf_viewer.dart';

class PdfWidget extends StatelessWidget {
  // https://www.reddit.com/r/FlutterDev/comments/bu14p4/flutter_pdf_viewer_tutorial_android_ios_from_url/
  final String url;
  // PDFDocument doc;

  PdfWidget(this.url) {
    // get_doc();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SfPdfViewer.network(
          'http://www.africau.edu/images/default/sample.pdf'),
    );
  }

  // get_doc() async {
  //   this.doc = await PDFDocument.fromURL(
  //       'http://www.africau.edu/images/default/sample.pdf');
  // }
}
