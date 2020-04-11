import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;

import 'package:pdf_viewer_plugin/pdf_viewer_plugin.dart';
import 'package:image/image.dart' as im;
import 'package:flutter/services.dart' show rootBundle;

class PDFPageWidget extends StatefulWidget {
  @override
  _PDFPageWidgetState createState() => _PDFPageWidgetState();
}

class _PDFPageWidgetState extends State<PDFPageWidget> {
  String path;

  @override
  void initState() {
    super.initState();
  }

  Future<PdfImage> getImageFileFromAssets(
      pw.Document pdfDoc, String path) async {
    final byteData = await rootBundle.load('$path');

    print('byteData: $byteData');
    File file =
        File('${(await getApplicationSupportDirectory()).path}/tempFile');
    file = await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    im.Image imImage = im.decodeImage(file.readAsBytesSync());

    return PdfImage(
      pdfDoc.document,
      image: imImage.data.buffer.asUint8List(),
      width: imImage.width,
      height: imImage.height,
    );
  }

  void createAndSavePdf() async {
    final pdf = new pw.Document();

    final image =
        await getImageFileFromAssets(pdf, 'assets/images/add_blue.png');
    final image2 = await getImageFileFromAssets(
        pdf, 'assets/images/home_adverting_default.png');


    print('PdfColor: ${PdfColor.fromRYB(0.5, 0.5, 0.5).toHex()}');

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Container(
              child: pw.Center(
                  child: pw.Column(children: [
            pw.Text("Hello World", style: pw.TextStyle(fontSize: 18)),
            pw.Text("来个中文", style: pw.TextStyle(fontSize: 18)),

            pw.Container(
              width: 200,
              height: 200,

//              color: PdfColor.fromRYB(0.5, 0.5, 0.5),
              color: PdfColor.fromHex('#ff9b7449'),
//              child: pw.Image(image2),
            ),
                    pw.Image(image),//, width: 100, height: 200
//            pw.Container(
//                height: 500,
//                width: 200,
//                color: PdfColor.fromRYB(0.5, 0.5, 0.5)),
          ])));
        },
      ),
    );
    pdf.addPage(pw.Page());

    final output = await getApplicationSupportDirectory();
    final filePdf = File("${output.path}/example.pdf");
    print(filePdf);
    path = filePdf.path;

    await filePdf.writeAsBytes(pdf.save());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Plugin example app'),
          leading: FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_ios)),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              path != null
                  ? Container(
                      height: 300.0,
                      child: PdfViewer(
                        filePath: path,
                      ),
                    )
                  : Text("Pdf is not Loaded"),
              RaisedButton(
                child: Text("Load pdf"),
                onPressed: () {
                  createAndSavePdf();
                },
              ),
              RaisedButton(
                  child: Text('share pdf'),
                  onPressed: () {
                    print('share pdf select');
                  }),
              Image.asset('assets/images/add_blue.png'),
              Image(image: AssetImage('assets/images/add_blue.png')),
            ],
          ),
        ),
      ),
    );
  }
}
