import 'package:auto_route/auto_route.dart';
import 'package:booking_app_cubit/config/constants/img_string.dart';
import 'package:booking_app_cubit/config/networking/http_state.dart';
import 'package:booking_app_cubit/config/theme/app_color.dart';
import 'package:booking_app_cubit/config/theme/app_dimen.dart';
import 'package:booking_app_cubit/config/theme/app_font.dart';
import 'package:booking_app_cubit/data/models/trip.dart';
import 'package:booking_app_cubit/presentation/cubit/trips_cubit/trips_cubit.dart';
import 'package:booking_app_cubit/utils/extension/double_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logging/logging.dart';

@RoutePage()
class TripsPage extends StatefulWidget {
  const TripsPage({Key? key}) : super(key: key);

  @override
  State<TripsPage> createState() => _TripsPageState();
}

class _TripsPageState extends State<TripsPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => TripsCubit(),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    final cubit = BlocProvider.of<TripsCubit>(context);
    cubit.getTrips();
    return BlocBuilder<TripsCubit, TripsState>(
      builder: (context, state) {
        Logger.root.info('TripsPage build');
        return Column(
          children: [
            tripsYourRoomies(
              context: context,
              yourRoomies: cubit.state.yourRoomies,
            ),
            otherMatchesWidget(
              context: context,
              otherMatches: state.otherMatches,
            )
          ],
        );
      },
    );
  }

  Widget tripsYourRoomies(
      {required BuildContext context, required List<Trip> yourRoomies}) {
    return Expanded(
      child: Column(
        children: [_header(), _roomiesList(context, yourRoomies)],
      ),
    );
  }

  Widget _roomiesList(BuildContext context, List<Trip> yourRoomies) {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (c, i) => _roomiesItem(yourRoomies[i]),
        itemCount: yourRoomies.length,
      ),
    );
  }

  Widget _roomiesItem(Trip trip) {
    return Container(
      height: 72,
      margin: EdgeInsets.only(
          bottom: AppDimen.h16, left: AppDimen.w16, right: AppDimen.w16),
      padding:
          EdgeInsets.symmetric(horizontal: AppDimen.w16, vertical: AppDimen.h8),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColor.ink06,
        borderRadius: BorderRadius.circular(AppDimen.w8),
      ),
      child: Row(
        children: [
          _avatar(),
          8.0.width,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  trip.name ?? '',
                  style: AppFont.paragraphMediumBold,
                ),
                Text(
                  trip.location ?? '',
                  style: AppFont.paragraphSmall.copyWith(
                    color: AppColor.ink02,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.more_vert)
        ],
      ),
    );
  }

  Widget _avatar() {
    return SizedBox(
      height: 56.w,
      width: 56.w,
      child: Stack(
        children: [
          Center(
            child: CircleAvatar(
              radius: 28.w,
              backgroundColor: AppColor.ink03,
            ),
          ),
          Center(
            child: CircleAvatar(
              radius: 26.w,
              backgroundColor: AppColor.ink06,
              backgroundImage: const AssetImage(ImgString.avatar),
            ),
          )
        ],
      ),
    );
  }

  Widget _header() {
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
            "Your Roomies",
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

  Widget otherMatchesWidget(
      {required BuildContext context, required List<Trip> otherMatches}) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [_headerOthers(), _roomiesListOthers(context, otherMatches)],
      ),
    );
  }

  Widget _roomiesListOthers(BuildContext context, List<Trip> otherMatches) {
    final cubit = BlocProvider.of<TripsCubit>(context);
    Logger.root.info('OtherMatches build ${cubit.state.status.name}');
    return Expanded(
      child: cubit.state.status == HttpStateStatus.loading
          ? const Center(
              child: CupertinoActivityIndicator(),
            )
          : cubit.state.status == HttpStateStatus.error
              ? Center(
                  child: Text("Error!!", style: AppFont.paragraphLargeBold),
                )
              : ListView.builder(
                  itemBuilder: (c, i) =>
                      _roomiesItemOther(context, otherMatches[i]),
                  itemCount: otherMatches.length,
                  scrollDirection: Axis.horizontal,
                ),
    );
  }

  Widget _roomiesItemOther(BuildContext context, Trip trip) {
    return Container(
      margin: EdgeInsets.only(
          left: AppDimen.w16, top: AppDimen.h24, bottom: AppDimen.h16),
      padding: EdgeInsets.only(
          right: AppDimen.w16,
          left: AppDimen.w16,
          bottom: AppDimen.h16,
          top: 49.h),
      width: (MediaQuery.of(context).size.width / 2) - AppDimen.w38,
      decoration: BoxDecoration(
        color: AppColor.ink06,
        borderRadius: BorderRadius.circular(AppDimen.w16),
      ),
      child: Column(
        children: [
          Expanded(child: Image.asset(ImgString.cittaPlants1)),
          37.0.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: Text(
                trip.name ?? "",
                style: AppFont.paragraphLargeBold,
                overflow: TextOverflow.ellipsis,
              )),
              Text(
                "\$${trip.price ?? 0}",
                style: AppFont.paragraphSmall,
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _headerOthers() {
    return Padding(
      padding: EdgeInsets.only(
        left: AppDimen.w16,
        right: AppDimen.w16,
        top: AppDimen.h24,
      ),
      child: Text(
        "Other Matches",
        style: AppFont.h3,
      ),
    );
  }
}
