import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;

import 'package:pdf_viewer_plugin/pdf_viewer_plugin.dart';
import 'package:printing/printing.dart';
import 'dart:ui';
import 'package:image/image.dart' as im;
import 'package:flutter/services.dart' show rootBundle;

class PDFPageWidget extends StatefulWidget {
  @override
  _PDFPageWidgetState createState() => _PDFPageWidgetState();
}

class _PDFPageWidgetState extends State<PDFPageWidget> {
  String path;
  final imageProvider = AssetImage('assets/images/add_blue.png');

  @override
  void initState() {
    super.initState();
  }

  Future<File> getImageFileFromAssets(String path) async {

    final byteData = await rootBundle.load('assets/$path');

    print('byteData: $byteData');
    final file = File('${(await getApplicationSupportDirectory()).path}/$path');
    await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    return file;
  }

  void createAndSavePdf() async {
    final pdf = pw.Document();


    final byteData = await rootBundle.load('assets/images/add_blue.png');

    print('byteData: $byteData');
    File file = File('${(await getApplicationSupportDirectory()).path}/$path');
    file = await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));


    final img = im.decodeImage(file.readAsBytesSync());

    final image = PdfImage(
      pdf.document,
      image: img.data.buffer.asUint8List(),
      width: img.width,
      height: img.height,
    );

    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Container(
              child: pw.Center(
                  child: pw.Column(children: [
            pw.Text("Hello World", style: pw.TextStyle(fontSize: 18)),
            pw.Text("Hello World", style: pw.TextStyle(fontSize: 18)),
            pw.Image(image),
          ])));
        })); // Page

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
              RaisedButton(child: Text('share pdf'), onPressed: () {}),
              Image.asset('assets/images/add_blue.png'),
              Image(image: imageProvider),
            ],
          ),
        ),
      ),
    );
  }
}
