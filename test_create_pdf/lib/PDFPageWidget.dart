import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;

import 'package:pdf_viewer_plugin/pdf_viewer_plugin.dart';
import 'package:image/image.dart' as im;
import 'package:flutter/services.dart' show rootBundle;
import 'package:modal_progress_hud/modal_progress_hud.dart';

class PDFPageWidget extends StatefulWidget {
  @override
  _PDFPageWidgetState createState() => _PDFPageWidgetState();
}

class _PDFPageWidgetState extends State<PDFPageWidget> {
  String path;
  bool _isLoading = false;

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
    setState(() {
      _isLoading = true;
    });
    final pdf = new pw.Document();

    var myTheme = pw.Theme.withFont(
//      base: pw.Font.ttf(await rootBundle.load("fonts/Alibaba-PuHuiTi-Regular.ttf")),
      base: pw.Font.ttf(
          await rootBundle.load("fonts/SourceHanSansCN-Normal.ttf")), //思源黑体
      bold: pw.Font.ttf(
          await rootBundle.load("fonts/SourceHanSansCN-Normal.ttf")),
      italic: pw.Font.ttf(
          await rootBundle.load("fonts/SourceHanSansCN-Normal.ttf")),
      boldItalic: pw.Font.ttf(
          await rootBundle.load("fonts/SourceHanSansCN-Normal.ttf")),
    );

    final image =
        await getImageFileFromAssets(pdf, 'assets/images/add_blue.png');
    final image2 = await getImageFileFromAssets(
        pdf, 'assets/images/home_adverting_default.png');

    print('PdfColor: ${PdfColor.fromRYB(0.5, 0.5, 0.5).toHex()}');

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        theme: myTheme,
        build: (pw.Context context) {
          return pw.Container(
              child: pw.Center(
                  child: pw.Column(children: [
            pw.Text("Hello World aaaa",
                style: pw.TextStyle(
                  fontSize: 18,
                )),
            pw.Text(
              "Hello World aaaa",
            ),
            pw.Text("中文支持，今天天气怎么样，天气好吗",
                style:
                    pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
            pw.Container(
                width: 200, height: 200, color: PdfColor.fromInt(0xFF9b7449)
//              child: pw.Image(image2),
                ),
            pw.Image(image),
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
    setState(() {
      _isLoading = false;
    });
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
        body: ModalProgressHUD(
          inAsyncCall: _isLoading,
          child: Center(
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
                  child: Text(
                    "Load pdf aaa",
                    style: TextStyle(fontSize: 20, fontFamily: 'Ali'),
                  ),
                  onPressed: () {
                    createAndSavePdf();
                  },
                ),
                RaisedButton(
                  child: Text(
                    'share pdf aaa',
                    style:
                        TextStyle(fontSize: 20, fontFamily: 'SourceHanSansCN'),
                  ),
                  onPressed: () {
                    print('share pdf select');
                  },
                ),
                Image.asset('assets/images/add_blue.png'),
                Image(image: AssetImage('assets/images/add_blue.png')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
