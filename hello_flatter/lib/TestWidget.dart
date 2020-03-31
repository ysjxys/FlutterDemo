import 'package:flutter/material.dart';



class TestWidget extends StatelessWidget {

  final String text;
  final Color backgroundColor;

  const TestWidget({
    Key key,

    @required
    this.text,

//    this.backgroundColor:Colors.purple,
    @required
    this.backgroundColor,

  }):super(key:key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: backgroundColor,
        child: Text(text),
      ),
    );
  }
}