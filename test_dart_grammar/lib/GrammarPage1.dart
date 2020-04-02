import 'package:flutter/material.dart';

class GrammarPage1 extends StatefulWidget {
  @override
  _GrammarPage1State createState() => _GrammarPage1State();
}

class _GrammarPage1State extends State<GrammarPage1> {

  int testGetProperty1 = 1;
  int testGetProperty2 = 2;
  int get getProperty1 => testGetProperty1 + testGetProperty2;
  get getProperty2 => testGetProperty1 + testGetProperty2;
  get getProperty3  {
    return testGetProperty1 + testGetProperty2;
  }

  @override
  Widget build(BuildContext context) {

    print('getProperty1: $getProperty1');
    print('getProperty2: $getProperty2');
    print('getProperty3: $getProperty3');


    return Scaffold(
      appBar: AppBar(
        title: Text('title'),
      ),
      body: Center(),
    );
  }
}
