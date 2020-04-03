import 'package:bloc/bloc.dart';
import 'package:test_flutter_bloc/LoginEvent.dart';
import 'package:test_flutter_bloc/LoginState.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {

  String userName;
  String password;

  String loginResultMessage;

  @override
  LoginState get initialState => LoginInitState();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginInitEvent) {
      print('LoginInitEvent');
      yield this.initialState;

    }else if (event is LoginInEvent) {
      print('LoginInEvent');

      userName = event.userName;
      password = event.password;
      if (event.userName == '11' && event.password == '22') {
        loginResultMessage = '登录成功';
        yield LoginSuccessState();
      }else {
        loginResultMessage = '登录失败';
        yield LoginFailedState();
      }

    }else if (event is NewVersionEvent) {
      print('NewVersionEvent');
    }
  }

}