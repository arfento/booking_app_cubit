import 'package:bloc/bloc.dart';
import 'package:booking_app_cubit/config/networking/base_response.dart';
import 'package:booking_app_cubit/config/networking/http_state.dart';
import 'package:booking_app_cubit/config/router/app_router.dart';
import 'package:booking_app_cubit/config/router/app_router.gr.dart';
import 'package:booking_app_cubit/domain/controller/auth_controller.dart';
import 'package:booking_app_cubit/utils/helper/pref_helper.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> implements HttpState {
  LoginCubit() : super(LoginState().init());
  late final AuthController _authController = AuthController(this);

  void login() async {
    BaseResponse baseResponse = await _authController.login(
        state.emailController.text, state.passwordController.text);
    PrefHelper.instance.saveToken(baseResponse.result?.login?.token ?? "");
    Logger.root.info("TOKENKU ${PrefHelper.instance.token}");
    if (baseResponse.result?.login?.token != null) {
      GetIt.I<AppRouter>().replace(const DiscoverRoute());
    }
  }

  @override
  void onEndRequest(String url, String method) {
    Logger.root.info("onEndRequest $url $method");
  }

  @override
  void onErrorRequest(String url, String method) {
    Logger.root.info("onErrorRequest $url $method");
    emit(state.clone()..httpStateStatus = HttpStateStatus.error);
  }

  @override
  void onStartRequest(String url, String method) {
    Logger.root.info("onStartRequest $url $method");
    emit(state.clone()..httpStateStatus = HttpStateStatus.loading);
  }

  @override
  void onSuccessRequest(String url, String method) {
    Logger.root.info("onSuccessRequest $url $method");
    emit(state.clone()..httpStateStatus = HttpStateStatus.success);
  }
}
