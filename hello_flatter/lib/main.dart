import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'TestWidget.dart';

void main() => runApp(new MyApp2());


class MyApp extends StatelessWidget {

  var a;
  int a1 = 1;//int 只能为整型
  double a2 = 1.1;//double 只能为浮点型
  num a3 = 1.11;//num皆可
  String aa;//不能同时用 var 与 类型名进行声明
  bool isDoorOpen = true;
  int z = int.parse('10');
  double numberDouble = double.parse('44.4');

  dynamic b;//全方法支持，慎用 避免因类型不对找不到对应方法导致的崩溃
  Object c;

  //final 和 const的不同在于，const是编译时常量。在编译时必须要有一个值
  //final变量只能被赋值一次，他不需要在编译时就赋值，可以在运行时赋值

  final String d = "final";
  final dd = "final";//类型可省略

  static const e = "final";
  static const String ee = "final";

  List<int> list = [1,2,3,4];
  var list2 = [1, 2, 3, 'Flutter', true];
  var listConst = const [1,2,3,4];

  var map = {
    'key1': 'value1',
    'key2': 'value2',
    'key3': 'value3'
  };

//  var entries = map.entries;//获取key
//  var values = map.values;//获取value


  void testMethod() {
    a = "fuck";

    b = "bb";
    c = "cc";

    print(b.length);
//    print(c.length);//error object类型没有全方法支持
  }

  //标准函数样式
  bool numberCount(int a, int b, int c) {
    return a + b + c > 5;
  }

  //省略返回类型样式
  numberCount2(int a, int b, int c) {
    return a + b + c > 5;
  }

  void testNumber(bool b) {
    print(a);
  }

  void testResultValidateMethod(int a) {
    testNumber(numberCount(1, 2, 3));
    testNumber(numberCount2(1, 2, 3));
  }

  //单行函数表达式
  bool isNoble(int atomicNumber) => atomicNumber > 0;

  //命名参数式函数，调用时指定参数名称
  fullName({String firstName, String lastName}) {
    return "$firstName $lastName";
  }

  //参数默认值，需要命名参数才可指定默认值
  fullName2({String firstName, String lastName = "Lazy"}) {
    return "$firstName $lastName";
  }

  //可选参数
  fullName3(String firstName, String lastName, [int age]) {
    return "$firstName $lastName";
  }

  //error
//  fullName4({String firstName, String lastName, [int age]}) {
//    return "$firstName $lastName";
//  }

  //函数作匿名参数
  methodAsParam(method1(String str), String b) {
//    print(str);
      print(b);
      method1("fuck");
  }


  @override
  Widget build(BuildContext context) {

//    var name2 = fullName("1", "2") //error
    var name = fullName(firstName: "123", lastName: "223");

    Future.delayed(new Duration(seconds: 2),() {
      print("123456");
      throw AssertionError("myError");
    }).then((data) {
      print("then:$data");
    }).catchError((error) {
      print("error:%errot");
    }).whenComplete((){
      print("complete");
    });

    print("-------------------------------");

    Future.wait([
      Future.delayed(new Duration(seconds: 1),() {
        print("delay 1 second");
      }),
      Future.delayed(new Duration(seconds: 2),() {
        print("delay 2 second");
      })
    ]).then((data) {
      print("all success");
    }, onError: (e) {
      print("$e");
    }).whenComplete(() {
      print("all over");
    });

    print("-------------------------------");

    //嵌套调用
    Future loginFuture = new Future.delayed(new Duration(seconds: 3), () {
      print("delay 3s 嵌套开始");
      return "loginSuccess";
    });

    loginFuture.then((data){
      print("loginFutureThen1Success");
      print(data);
      return "then1 data pass success";

    }).then((data2) {
      print("loginFutureThen2Success");
      print(data2);
      return "then2 data pass success";

    }).whenComplete( () {

      print("嵌套结束");
    });

    final wordPair = new WordPair.random();

    return new MaterialApp(
      title: 'Welcome to Flutter',
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Welcome to Flutter'),
        ),
        body: new Center(
          child: new Text('Hello World'),
//          child: new Text(wordPair.asPascalCase),
        ),
      ),
    );

  }

}











class MyApp2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        "new_page": (context) => new NewPage2(),
        "TestWidget": (context) => new TestWidget(text: "123456"),
//        "TestWidget": (context) => new TestWidget(text: "123456", backgroundColor: Colors.green),
      },
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {

  const MyHomePage({
    Key key,

    @required
    this.title
  });
//  MyHomePage({Key key, this.title}) : super(key: key);//省略写法

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("build");
    return new Scaffold(
      appBar: new AppBar(
       title: new Text(widget.title),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'You have pushed the button this many times:',
            ),
            new Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
            FlatButton(
              child: Text("push 1"),
              textColor: Colors.blue,
              onPressed: (){
                //常态push
                Navigator.push(context, new MaterialPageRoute(builder: (context) {
                  return new NewPage();
                }));
              },
            ),

            FlatButton(
              child: Text("push 2"),
              textColor: Colors.blue,
              onPressed: (){

                //命名路由参数push
                Navigator.of(context).pushNamed("new_page", arguments: ["paramsss", "sss"]);

//                //命名路由参数push
//                Navigator.pushNamed(context, "new_page");
              },
            ),

            FlatButton(
              child: Text("push TestWidget"),
              textColor: Colors.blue,
              onPressed: (){
                Navigator.of(context).pushNamed("TestWidget");
              },
            ),

//            new TestWidget(text: "fuck world"),
            new TestWidget(text: "223456", backgroundColor: Colors.green),
          ],
        ),
      ),

      floatingActionButton: new FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  //1 initState   当Widget第一次插入到Widget树时会被调用
  @override
  void initState() {
    super.initState();
    _counter = 2;
    print("initState");
  }

  //2 didChangeDependencies   当State对象的依赖发生变化时会被调用
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("didChangeDependencies");
  }

  //3 build   主要是用于构建Widget子树

  //4 reassemble    专门为了开发调试而提供的，在热重载(hot reload)时会被调用，此回调在Release模式下永远不会被调用
  @override
  void reassemble() {
    super.reassemble();
    print("reassemble");
  }

  //5 didUpdateWidget   在新旧widget的key和runtimeType同时相等时didUpdateWidget()就会被调用
  @override
  void didUpdateWidget(MyHomePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("didUpdateWidget");
  }

  //6 build
  /*
  在调用initState()之后。
  在调用didUpdateWidget()之后。
  在调用setState()之后。
  在调用didChangeDependencies()之后。
  在State对象从树中一个位置移除后（会调用deactivate）又重新插入到树的其它位置之后。
   */

  //从widget树中移除时，deactive和dispose会依次被调用。

  //当State对象从树中被移除时，会调用
  @override
  void deactivate() {
    super.deactivate();
    print("deactivate");
  }

  //当State对象从树中被永久移除时调用；通常在此回调中释放资源
  @override
  void dispose() {
    super.dispose();
    print("dispose");
  }

}

class NewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New route"),
      ),
      body: Center(
        child: Text("This is new route"),
      ),
    );
  }
}

class NewPage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    //命名路由参数
    var param = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text("New route2"),
      ),
      body: Center(
        child: Text("This is new route2 $param"),
      ),
    );
  }
}