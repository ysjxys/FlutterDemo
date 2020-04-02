import 'package:flutter/material.dart';
import 'package:test_data_pass/GenericDataProvider.dart';
import 'ResetPasswordWidget.dart';
import 'package:provider/provider.dart';
import 'package:test_data_pass/LoginNotifier.dart';

class LoginWidget extends StatefulWidget {
  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  TextEditingController userNameTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();

  LoginNotifier loginNotifier = LoginNotifier();

  @override
  void initState() {
    super.initState();
    userNameTextController.addListener((){
      loginNotifier.setUserName(userNameTextController.text);
    });

    passwordTextController.addListener((){
      loginNotifier.setPassword(passwordTextController.text);
    });
  }

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginNotifier>(
          create: (_) => loginNotifier,
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text('login'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Consumer<LoginNotifier>(builder: (context, loginNotifier, _) {
                userNameTextController.text = loginNotifier.userName;
                return TextField(
                  controller: userNameTextController,
                );
              }),

              Consumer<LoginNotifier>(builder: (context, loginNotifier, _) {
                passwordTextController.text = loginNotifier.password;
                return TextField(
                  controller: passwordTextController,
                );
              }),

              Consumer<LoginNotifier>(builder: (context, loginNotifier, _) {
                return Text('${loginNotifier.message}');
              }),

              Consumer<LoginNotifier>(builder: (context, loginNotifier, _) {
                return FlatButton(
                  onPressed: () {
//                    loginNotifier.requestToLogin(userNameTextController.text, passwordTextController.text);
                    loginNotifier.requestLogin();
                  },
                  child: Icon(Icons.directions_bike),
                );
              }),

              Consumer<LoginNotifier>(builder: (context, loginNotifier, _) {
                return FlatButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute<LoginNotifier>(builder: (context){
                      return GenericDataProvider(
                        data: loginNotifier,
                        child: ResetPasswordWidget(),
                      );
                    }));
                  },
                  child: Icon(Icons.arrow_forward),
                );
              }),

            ],
          ),
        ),
      ),
    );
  }
}
