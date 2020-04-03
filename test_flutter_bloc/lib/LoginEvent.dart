import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class LoginEvent extends Equatable {
  LoginEvent([List props = const []]) : super(props);
}

class LoginInitEvent extends LoginEvent {

}

class LoginInEvent extends LoginEvent {
  final String userName;
  final String password;
  LoginInEvent({@required this.userName, @required this.password}) : super([userName, password]);
}

class NewVersionEvent extends LoginEvent {

}