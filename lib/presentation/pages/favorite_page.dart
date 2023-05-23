import 'package:auto_route/auto_route.dart';
import 'package:booking_app_cubit/config/constants/img_string.dart';
import 'package:booking_app_cubit/config/theme/app_color.dart';
import 'package:booking_app_cubit/config/theme/app_dimen.dart';
import 'package:booking_app_cubit/config/theme/app_font.dart';
import 'package:booking_app_cubit/presentation/cubit/favorite_cubit/favorite_cubit.dart';
import 'package:booking_app_cubit/utils/extension/double_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => FavoriteCubit(),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    // final cubit = BlocProvider.of<FavoriteCubit>(context);

    return Scaffold(
      backgroundColor: AppColor.ink05,
      body: Column(
        children: [
          favoriteTitle(context),
          favoriteHeader(context),
          favoriteList(context)
        ],
      ),
    );
  }

  Widget favoriteTitle(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: AppDimen.w16,
        right: AppDimen.w16,
        top: AppDimen.h60,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            "Favorites",
            style: AppFont.h3,
          ),
          const Expanded(child: SizedBox()),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                color: AppColor.ink02,
              )),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.star,
                color: AppColor.ink02,
              )),
        ],
      ),
    );
  }

  Widget favoriteHeader(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(AppDimen.w16),
      padding: EdgeInsets.all(AppDimen.w8),
      height: 163.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          Image.asset(ImgString.cittaPlants3),
          24.0.width,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Itally",
                  style: AppFont.paragraphSmall,
                ),
                8.0.height,
                Text(
                  "Meet new roomies and find new adventures.",
                  style: AppFont.h4.copyWith(
                    height: 1.2.sp,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget favoriteList(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (c, i) => _listItem(),
        itemCount: 10,
      ),
    );
  }

  Widget _listItem() {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: AppDimen.w16,
      ),
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(AppDimen.w16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "The Ngoding",
                    style: AppFont.paragraphMediumBold,
                  ),
                  Text(
                    "Jakarta, Indonesia",
                    style: AppFont.paragraphSmall.copyWith(
                      color: AppColor.ink02,
                    ),
                  ),
                ],
              ),
              const Icon(
                Icons.arrow_forward_ios,
                color: AppColor.ink01,
                size: 12,
              )
            ],
          ),
        ),
      ),
    );
  }
}
