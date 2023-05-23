import 'package:auto_route/auto_route.dart';
import 'package:booking_app_cubit/config/router/app_router.gr.dart';
import 'package:booking_app_cubit/config/router/middleware/auth_guard.dart';
import 'package:booking_app_cubit/config/router/middleware/first_install_guard.dart';

@AutoRouterConfig(
  replaceInRouteName: 'Page,Route',
)
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: OnboardingRoute.page,
          path: '/onboarding',
          initial: true,
          guards: [FirstInstallGuard()],
        ),
        AutoRoute(
          page: WelcomeRoute.page,
          path: '/welcome',
          guards: [AuthGuard()],
        ),
        AutoRoute(page: LoginRoute.page, path: '/login'),
        AutoRoute(page: RegisterRoute.page, path: '/register'),
        AutoRoute(page: DiscoverRoute.page, path: '/discover'),
        AutoRoute(page: TripsRoute.page, path: '/trips'),
        AutoRoute(page: DetailRoute.page, path: '/detail'),
        AutoRoute(page: SettingsRoute.page, path: '/settings'),
        AutoRoute(page: FavoriteRoute.page, path: '/favorite'),
        RedirectRoute(path: "*", redirectTo: "/discover")
        // AutoRoute(page: NotFoundPage, path: '*', name: 'NotFoundPage'),
      ];
}
