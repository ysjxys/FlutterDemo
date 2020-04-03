import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_bloc/LoginBloc.dart';

class ResetWidget extends StatefulWidget {
  final BuildContext blocContext;

  ResetWidget({@required this.blocContext});

  @override
  _ResetWidgetState createState() => _ResetWidgetState();
}

class _ResetWidgetState extends State<ResetWidget> {
  LoginBloc _loginBloc;

  TextEditingController _userNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of(widget.blocContext);
    _userNameController.text = _loginBloc.userName;
    _passwordController.text = _loginBloc.password;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _loginBloc,
      listener: (context, state) {
        print(state);
      },
      child: BlocBuilder(
        bloc: _loginBloc,
        builder: (context, state) {
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
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
