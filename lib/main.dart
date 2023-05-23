import 'package:booking_app_cubit/config/router/app_router.dart';
import 'package:booking_app_cubit/config/router/app_router.gr.dart';
import 'package:booking_app_cubit/config/router/middleware/first_install_guard.dart';
import 'package:booking_app_cubit/utils/helper/pref_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:logging/logging.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PrefHelper.instance.init();
  GetIt.I.registerSingleton<AppRouter>(
    AppRouter(),
  );
  Logger.root.level = Level.OFF;
  Logger.root.onRecord.listen((record) {
    debugPrint(record.message);
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final router = GetIt.I<AppRouter>();
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp.router(
            title: 'Booking App',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              fontFamily: 'Poppins',
            ),
            routerDelegate: router.delegate(),
            routeInformationParser: router.defaultRouteParser(),
          );
        });
  }
}
