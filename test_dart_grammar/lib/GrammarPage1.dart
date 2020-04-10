import 'package:flutter/material.dart';
import 'dart:math';

class GrammarPage1 extends StatefulWidget {
  @override
  _GrammarPage1State createState() => _GrammarPage1State();
}

class _GrammarPage1State extends State<GrammarPage1> {

  //test get
  int testGetProperty1 = 1;
  int testGetProperty2 = 2;
  int get getProperty1 => testGetProperty1 + testGetProperty2;
  //实现get后若要赋值需同时实现set
  set getProperty1 (newGetProperty1) {}
  get getProperty2 => testGetProperty1 + testGetProperty2;
  get getProperty3  {
    return testGetProperty1 + testGetProperty2;
  }

  //test set
  //等于 (radian * 180 / 3.14).toInt()      ~/   除以并取整
  int get degree => radian * 180 ~/ 3.14;
  set degree (newDegree){
    radian = newDegree * 3.14 / 180;
  }
  double radian = 0;

  //test no init property
  //所有变量未初始化  初始值则为null  null也是一个对象， 是核心类Null的唯一实例，一切皆对象嘛
  int noInitProperty;

  //类变量  未初始化也为null
  static int testStaticProperty;

  //final  有get没set 毕竟final嘛  所以也必须在声明时就初始化
  final int testFinalProperty = 10086;

  //位置参数 靠位置确定具体的参数含义，与其包含的可选参数，可选参数需用[]包裹放在参数列表的最后，可赋默认值，
  void testParamMethod1(int i, [int j = 100]) {
    print('i: $i  j: $j');
  }

  //命名参数 需要输入对应的参数名才可赋值的参数，类似widget的各个属性，命名参数都是可选的，以{}包裹放在参数列表的最后
  void testParamMethod2(int m, {int j, int k = 200}) {
    print('m: $m  j: $j  k: $k');
  }

  @override
  Widget build(BuildContext context) {
    getProperty1 = 2;
    print('getProperty1: $getProperty1');
    print('getProperty2: $getProperty2');
    print('getProperty3: $getProperty3');

    print('old  degree:$degree     radian:$radian');
    degree = 120;
    print('new  degree:$degree     radian:$radian');


    print('noInitProperty: $noInitProperty');

    print('testStaticProperty: $testStaticProperty');

    TestClass1 testClass1 = TestClass1(1, 2, 3);
    print('testClass1.property1: ${testClass1.property1}   testClass1.property2: ${testClass1.property2}');

    Student student = Student();
    student.songName = 'mo li hua';
    student.singTheSong(student.songName);

    testParamMethod1(1);
    testParamMethod1(1, 2);
    testParamMethod2(1);
    testParamMethod2(1, j: 5, k: 10);

    return Scaffold(
      appBar: AppBar(
        title: Text('title'),
      ),
      body: Center(),
    );
  }
}

class TestClass1 {
  int property1;
  int property2;
  //构造函数
//  TestClass1(this.property1, this.property2);
  //实例变量初始化的4种方法之   初始化列表
//  TestClass1(int a, int b) : property1 = a, property2 = b;

  //重定向构造函数
  TestClass1.inConstruction(this.property1, this.property2);
  //暴露在外的构造函数  TestClass1(int a, int b, int c)   重定向到  TestClass1.inConstruction(this.property1, this.property2)
  TestClass1(int a, int b, int c) : this.inConstruction(a + b, a - c);

}

/*
  mixin用于修饰类，
  和abstract类似，该类可以拥有成员变量、普通方法、抽象方法，但是不可以实例化。
  mixin一般用于描述一种具有某种功能的组块，而某一对象可以拥有多个不同功能的组块
 */


//mixin Sing {
//限定范围则要求with的类需是其子类，子类子类，指定的限定类都不行
mixin Sing on Person {
  String songName = 'default song name';
  void singIndeed();
  void singTheSong(String songName){
    print('sing the song: $songName');
  }
}

class Person {}

//class Student with Sing {
class Student extends Person with Sing {
  // mixin with 的抽象方法必须实现
  @override
  void singIndeed() {
    // TODO: implement singIndeed
  }
}

mixin Work {

}

//mixin  多个类型
class Worker extends Person with Work, Sing {
  @override
  void singIndeed() {
    // TODO: implement singIndeed
  }
}
