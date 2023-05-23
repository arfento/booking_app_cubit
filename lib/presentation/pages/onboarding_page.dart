import 'package:auto_route/auto_route.dart';
import 'package:booking_app_cubit/config/theme/app_color.dart';
import 'package:booking_app_cubit/config/theme/app_font.dart';
import 'package:booking_app_cubit/presentation/cubit/onboarding_cubit/onboarding_cubit.dart';
import 'package:booking_app_cubit/presentation/widgets/primary_button.dart';
import 'package:booking_app_cubit/presentation/widgets/secondary_button.dart';
import 'package:booking_app_cubit/utils/extension/double_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => OnboardingCubit(),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          top: 16,
          left: 16,
          right: 16,
        ),
        child: Column(
          children: [
            onboardingImage(context),
            32.0.height,
            onboardingTitle(context),
            45.0.height,
            onboardingIndicator(context),
            53.0.height,
            onboardingButton(context),
            82.9.height,
          ],
        ),
      ),
    );
  }

  Widget onboardingImage(BuildContext context) {
    final cubit = BlocProvider.of<OnboardingCubit>(context);
    return Expanded(
      child: PageView.builder(
        itemBuilder: (c, i) => Image.asset(
          cubit.state.onboardingList[i].image ?? "",
        ),
        itemCount: cubit.state.onboardingList.length,
        onPageChanged: cubit.swiping,
      ),
    );
  }

  Widget onboardingTitle(BuildContext context) {
    final cubit = BlocProvider.of<OnboardingCubit>(context);
    return BlocBuilder<OnboardingCubit, OnboardingState>(
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              cubit.state.onboardingList[cubit.state.currentIndex].title ?? "",
              style: AppFont.h3,
              textAlign: TextAlign.center,
            ),
            8.0.height,
            Text(
              cubit.state.onboardingList[cubit.state.currentIndex]
                      .description ??
                  "",
              textAlign: TextAlign.center,
              style: AppFont.paragraphMedium,
            ),
          ],
        );
      },
    );
  }

  Widget onboardingIndicator(BuildContext context) {
    final cubit = BlocProvider.of<OnboardingCubit>(context);
    return BlocBuilder<OnboardingCubit, OnboardingState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            cubit.state.onboardingList.length,
            (index) => index == cubit.state.currentIndex
                ? _activeIndicator(index)
                : _inactiveIndicator(index),
          ),
        );
      },
    );
  }

  Widget _activeIndicator(int index) {
    return Container(
      width: 16,
      height: 6,
      margin: EdgeInsets.symmetric(horizontal: index == 1 ? 12 : 0),
      decoration: BoxDecoration(
        color: AppColor.accentPink,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  Widget _inactiveIndicator(int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: index == 1 ? 12 : 0),
      width: 6,
      height: 6,
      decoration: BoxDecoration(
        color: AppColor.ink03,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  Widget onboardingButton(BuildContext context) {
    final cubit = BlocProvider.of<OnboardingCubit>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SecondaryButton(
          onPressed: cubit.skip,
          text: "Skip",
          width: 147.5,
        ),
        16.0.width,
        PrimaryButton(
          onPressed: cubit.next,
          text: "Next",
          width: 147.5,
        ),
      ],
    );
  }
}
