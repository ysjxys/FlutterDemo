import 'package:flutter/material.dart';

class CustomFontWidget extends StatefulWidget {
  @override
  _CustomFontWidgetState createState() => _CustomFontWidgetState();
}

class _CustomFontWidgetState extends State<CustomFontWidget> {

  static const textStyleAli = const TextStyle(
      fontFamily: 'Ali',
      fontSize: 20,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('title'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text('123456  abcdef  我是汉字默认'),
            Text('123456  abcdef  我是汉字默认', style: TextStyle(fontSize: 20),),
            Text('123456  abcdef  我是汉字Ali', style: textStyleAli,),
            Text('123456  abcdef  我是汉字', style: TextStyle(
              fontFamily: 'Ali',
              fontSize: 20,
            ),),
          ],
        ),
      ),
    );
  }
}
