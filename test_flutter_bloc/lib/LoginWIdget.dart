import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_bloc/LoginBloc.dart';
import 'package:test_flutter_bloc/LoginEvent.dart';
import 'package:test_flutter_bloc/LoginState.dart';
import 'package:test_flutter_bloc/ResetWidget.dart';

class LoginWidget extends StatefulWidget {
  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final LoginBloc _loginBloc = LoginBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _loginBloc,
      child: BlocListener<LoginBloc, LoginState>(
        bloc: _loginBloc,
        listener: (context, state) {},
        child: BlocBuilder<LoginBloc, LoginState>(
          bloc: _loginBloc,
          builder: (context, state) {
            if (state is LoginInitState) {
              print('this is LoginInitState');
            } else if (state is LoginInState) {
              print('this is LoginInState');
            } else if (state is NewVersionState) {
              print('this is NewVersionState');
            } else if (state is LoginSuccessState) {
              print('this is LoginSuccessState');
            } else if (state is LoginFailedState) {
              print('this is LoginFailedState');
            } else {
              print('unknown state');
            }

            return Scaffold(
              appBar: AppBar(
                title: Text('title'),
              ),
              body: Center(
                child: Column(
                  children: <Widget>[
                    TextField(
                      controller: _userNameController,
                    ),
                    TextField(
                      controller: _passwordController,
                    ),
                    Text(
                      _loginBloc.loginResultMessage ?? '',
                    ),
                    FlatButton(
                      onPressed: () {
                        print('login btn selected');
                        _loginBloc.add(LoginInEvent(
                            userName: _userNameController.text,
                            password: _passwordController.text));
                      },
                      child: Icon(Icons.directions_bike),
                    ),
                    FlatButton(
                      onPressed: () {

                        Navigator.push(context, MaterialPageRoute(builder: (context2) {
                          return ResetWidget(blocContext: context,);
                        }));
//                          Navigator.of(context)
//                              .push(MaterialPageRoute(builder: (context) {
//                            return ResetWidget(blocContext: context,);
//                          }));
                      },
                      child: Icon(Icons.arrow_forward_ios),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
