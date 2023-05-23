import 'package:auto_route/auto_route.dart';
import 'package:booking_app_cubit/config/constants/img_string.dart';
import 'package:booking_app_cubit/config/networking/http_state.dart';
import 'package:booking_app_cubit/config/theme/app_color.dart';
import 'package:booking_app_cubit/config/theme/app_dimen.dart';
import 'package:booking_app_cubit/config/theme/app_font.dart';
import 'package:booking_app_cubit/presentation/cubit/login_cubit/login_cubit.dart';
import 'package:booking_app_cubit/presentation/widgets/app_input_text.dart';
import 'package:booking_app_cubit/presentation/widgets/primary_button.dart';
import 'package:booking_app_cubit/utils/extension/double_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    // final cubit = BlocProvider.of<LoginCubit>(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          return state.httpStateStatus == HttpStateStatus.loading
              ? const Center(
                  child: CupertinoActivityIndicator(),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      60.0.height,
                      loginImage(context),
                      48.0.height,
                      loginForm(context),
                      16.0.height,
                      loginFooter(context),
                    ],
                  ),
                );
        },
      ),
    );
  }

  Widget loginImage(BuildContext context) {
    return Image.asset(ImgString.cittaPlants2);
  }

  Widget loginForm(BuildContext context) {
    final cubit = BlocProvider.of<LoginCubit>(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppDimen.w24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Login",
            style: AppFont.h3,
          ),
          16.0.height,
          AppInputText(
            label: "Email",
            controller: cubit.state.emailController,
          ),
          16.0.height,
          AppInputText(
            label: "Password",
            controller: cubit.state.passwordController,
          ),
          16.0.height,
          PrimaryButton(
            onPressed: cubit.login,
            text: "Login",
            width: double.infinity,
            type: PrimaryButtonType.type3,
          ),
        ],
      ),
    );
  }

  Widget loginFooter(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        RichText(
            text: TextSpan(children: [
          TextSpan(
              text: 'Forgot password? ',
              style: AppFont.paragraphSmall.copyWith(color: AppColor.ink02)),
          TextSpan(
            text: ' Forgot',
            style: AppFont.paragraphSmallBold,
          ),
        ])),
        8.0.height,
        RichText(
            text: TextSpan(children: [
          TextSpan(
              text: 'Don\'t have an account? ',
              style: AppFont.paragraphSmall.copyWith(color: AppColor.ink02)),
          TextSpan(
            text: ' Create New',
            style: AppFont.paragraphSmallBold,
          ),
        ])),
      ],
    );
  }
}
