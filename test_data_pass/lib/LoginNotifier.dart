import 'package:flutter/material.dart';

class LoginNotifier with ChangeNotifier {

  String _userName = '';
  String get userName => _userName;

  String _password = '';
  String get password => _password;

  String _message = '';
  String get message => _message;

  void setUserName(String userName) {
    _userName = userName;
  }

  void setPassword(String password) {
    _password = password;
  }

  void requestLogin() {
//  void requestToLogin(String userName, String password) {
//    _userName = userName;
//    _password = password;
    if (_userName == '' || _userName.isEmpty) {
      _message = '用户名不能为空';
    }else if (_password == '' || _password.isEmpty) {
      _message = '密码不能为空';
    }else {
      _message = '登录成功';
    }
    notifyListeners();
  }
}