import 'package:bloc/bloc.dart';
import 'package:booking_app_cubit/config/router/app_router.dart';
import 'package:booking_app_cubit/config/router/app_router.gr.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

part 'welcome_state.dart';

class WelcomeCubit extends Cubit<WelcomeState> {
  WelcomeCubit() : super(WelcomeState().init());

  AppRouter get _appRouter => GetIt.I<AppRouter>();

  void handleBtnExplorer() {
    _appRouter.replace(const DiscoverRoute());
  }

  void handleBtnLogin() {
    _appRouter.push(const LoginRoute());
  }
}
