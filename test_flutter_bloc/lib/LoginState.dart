import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class LoginState extends Equatable {
  LoginState([List props = const []]) : super(props);
}


class LoginInitState extends LoginState {

}

class LoginInState extends LoginState {
  final String userName;
  final String password;
  LoginInState({@required this.userName, @required this.password}) : super([userName, password]);
}

class NewVersionState extends LoginState{

}

class LoginSuccessState extends LoginState {

}

class LoginFailedState extends LoginState {

}