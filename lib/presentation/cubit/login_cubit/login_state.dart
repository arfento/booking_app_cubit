part of 'login_cubit.dart';

@immutable
class LoginState {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  HttpStateStatus httpStateStatus = HttpStateStatus.idle;

  LoginState init() {
    return LoginState();
  }

  LoginState clone() {
    return LoginState();
  }
}
