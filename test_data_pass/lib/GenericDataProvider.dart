import 'package:flutter/material.dart';


class GenericDataProvider<T> extends InheritedWidget {
  final T data;

  GenericDataProvider({Key key, Widget child, this.data})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(GenericDataProvider oldWidget) {
    return data != oldWidget.data;
  }

  static T of<T>(BuildContext context) {
//    return (context.dependOnInheritedWidgetOfExactType());
    return (context.inheritFromWidgetOfExactType(
        GenericDataProvider<T>().runtimeType) as GenericDataProvider<T>).data;
  }
}
