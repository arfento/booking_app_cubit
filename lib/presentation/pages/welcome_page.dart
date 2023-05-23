import 'package:auto_route/auto_route.dart';
import 'package:booking_app_cubit/config/constants/img_string.dart';
import 'package:booking_app_cubit/config/theme/app_color.dart';
import 'package:booking_app_cubit/config/theme/app_dimen.dart';
import 'package:booking_app_cubit/config/theme/app_font.dart';
import 'package:booking_app_cubit/presentation/cubit/welcome_cubit/welcome_cubit.dart';
import 'package:booking_app_cubit/presentation/widgets/primary_button.dart';
import 'package:booking_app_cubit/presentation/widgets/secondary_button.dart';
import 'package:booking_app_cubit/utils/extension/extension.dart';
import 'package:booking_app_cubit/utils/helper/pref_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';

@RoutePage()
class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    Logger.root.info("WelcomePage build ${PrefHelper.instance.token}");
    return BlocProvider(
      create: (BuildContext context) => WelcomeCubit(),
      child: Builder(
        builder: (context) => _buildPage(context),
      ),
    );
  }

  Widget _buildPage(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.accentBlue,
      body: Column(
        children: [
          welcomeTitle(context),
          welcomeButton(context),
          welcomeImage(context)
        ],
      ),
    );
  }

  Widget welcomeTitle(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppDimen.w16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          24.0.height,
          Text(
            "Find the Perfect Roommate",
            style: AppFont.h3,
          ),
          Text(
            "We've helped millions across the nation find their perfect match... and you're next!",
            style: AppFont.paragraphMedium,
          )
        ],
      ),
    );
  }

  Widget welcomeButton(BuildContext context) {
    var cubit = context.watch<WelcomeCubit>();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppDimen.w16),
      child: Row(
        children: [
          Expanded(
            child: PrimaryButton(
                onPressed: cubit.handleBtnExplorer, text: "Explore"),
          ),
          16.0.width,
          Expanded(
            child:
                SecondaryButton(onPressed: cubit.handleBtnLogin, text: "Login"),
          ),
        ],
      ),
    );
  }

  Widget welcomeImage(BuildContext context) {
    return Expanded(
      child: Image.asset(
        ImgString.giantPhone,
        fit: BoxFit.contain,
      ),
    );
  }
}
