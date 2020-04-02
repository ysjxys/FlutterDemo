import 'package:flutter/material.dart';
import 'package:test_data_pass/GenericDataProvider.dart';
import 'package:test_data_pass/LoginNotifier.dart';
import 'package:provider/provider.dart';

class ResetPasswordWidget extends StatefulWidget {
  @override
  _ResetPasswordWidgetState createState() => _ResetPasswordWidgetState();
}

class _ResetPasswordWidgetState extends State<ResetPasswordWidget> {

  LoginNotifier loginNotifier;
  TextEditingController userNameTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
//    loginNotifier = GenericDataProvider.of<LoginNotifier>(context);
//    userNameTextController.text = loginNotifier.userName;
//    passwordTextController.text = loginNotifier.password;
    userNameTextController.addListener((){
      loginNotifier.setUserName(userNameTextController.text);
    });

    passwordTextController.addListener((){
      loginNotifier.setPassword(passwordTextController.text);
    });
  }

  @override
  Widget build(BuildContext context) {

    loginNotifier = GenericDataProvider.of<LoginNotifier>(context);
    userNameTextController.text = loginNotifier.userName;
    passwordTextController.text = loginNotifier.password;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginNotifier>(
          create: (_) => loginNotifier,
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text('reset'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Text(loginNotifier.userName),
              TextField(
                controller: userNameTextController,
              ),

              TextField(
                controller: passwordTextController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
