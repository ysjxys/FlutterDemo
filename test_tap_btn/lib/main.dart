import 'package:flutter/material.dart';
import 'TapBtn.dart';

void main() => runApp(new TestTapBtn());

class TestTapBtn extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
//      title: 'TestTapBtn',
//      theme: new ThemeData(
//        primarySwatch: Colors.blue,
//      ),
      home: new HomePage(),
    );
  }

}


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}


class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {

    DefaultTextStyle (
      style:TextStyle(
        color: Colors.red,
        fontSize: 20,
      ),
      textAlign: TextAlign.start,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('hello'),
          Text('world'),
          Text('shit',
            style: TextStyle(
              inherit: false,
              color: Colors.grey
            ),
          )
        ],
      ),
    );

    const textStyle = const TextStyle(
      fontSize: 15,
      backgroundColor: Colors.pink
    );

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('fuck ft'),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text('fuck flutter',
              style: textStyle,
            ),
            new Text('fuck flutter '*6,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textScaleFactor: 1.5,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 18,
//                  backgroundColor: Colors.grey[500],
                  background: new Paint()..color=Colors.yellow
              ),
            ),
            new TapBtn(),

            new RaisedButton(
                child: Text('raiseBtn push'),
                onPressed: () {
                  print('raiseBtn');
                }
            ),

            new FlatButton(
                onPressed: () {
                  print('flatBtn');
                },
                child: Text('flatBtn'),
//                colorBrightness: Brightness.dark,
                padding: EdgeInsets.all(0.5),
            ),
            
            new RaisedButton(
              onPressed: (){
                print('submit select');
                }, 
              color: Colors.blue,
              child: Text('submitt'),
              highlightColor: Colors.blue[700],
              colorBrightness: Brightness.dark,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ),

            new Image(
              image: AssetImage('images/bg1.png'), 
              width: 100,
            ),
            
            new Image.asset(
              'images/btn_product_normal.png',
              width: 100,
              color: Colors.purple,
            ),

            new Image(
              image: NetworkImage('http://img5.duitang.com/uploads/item/201411/08/20141108134043_a5tJf.jpeg'),
              width: 100,
            ),

//            new Image.network('http://img5.duitang.com/uploads/item/201411/08/20141108134043_a5tJf.jpeg',
//              width: 100,
//            )

          ],
        ),
      ),
    );
  }
}









