//import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class TapBtn extends StatefulWidget {
  _TapBtnState createState() => new _TapBtnState();
}

class _TapBtnState extends State<TapBtn> {

  bool _isActive = false;

  void _handleTap() {
    setState(() {
      _isActive = !_isActive;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: _handleTap,
      child: new Container(
        child: new Center(
          child: new Text(
            _isActive ? 'Active' : 'Inactive',
//            style: new TextStyle(fontSize: 32, color: Colors.white),
            style: new TextStyle(fontSize: 32, color: CupertinoColors.white),
          ),
        ),
        width: 200.0,
        height: 200.0,
        decoration: new BoxDecoration(
//          color: _isActive ? Colors.lightGreen[700] : Colors.grey[600],
          color: _isActive ? CupertinoColors.activeGreen : CupertinoColors.inactiveGray,
        ),
      ),
    );
  }
}










