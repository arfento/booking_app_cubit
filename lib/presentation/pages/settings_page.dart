import 'package:auto_route/auto_route.dart';
import 'package:booking_app_cubit/config/theme/app_color.dart';
import 'package:booking_app_cubit/config/theme/app_dimen.dart';
import 'package:booking_app_cubit/config/theme/app_font.dart';
import 'package:booking_app_cubit/presentation/cubit/settings_cubit/settings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SettingsCubit(),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    // final cubit = BlocProvider.of<FavoriteCubit>(context);

    return Scaffold(
      backgroundColor: AppColor.ink05,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: AppDimen.w16,
              right: AppDimen.w16,
              top: AppDimen.h60,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  "Settings",
                  style: AppFont.h3,
                ),
                const Expanded(child: SizedBox()),
              ],
            ),
          )
        ],
      ),
    );
  }
}
