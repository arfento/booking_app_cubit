import 'package:auto_route/auto_route.dart';
import 'package:booking_app_cubit/config/theme/app_color.dart';
import 'package:booking_app_cubit/presentation/cubit/discover_cubit/discover_cubit.dart';
import 'package:booking_app_cubit/presentation/pages/favorite_page.dart';
import 'package:booking_app_cubit/presentation/pages/settings_page.dart';
import 'package:booking_app_cubit/presentation/pages/trips_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class DiscoverPage extends StatefulWidget {
  const DiscoverPage({Key? key}) : super(key: key);

  @override
  _DiscoverPageState createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => DiscoverCubit(),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    final cubit = BlocProvider.of<DiscoverCubit>(context);
    return Scaffold(
      backgroundColor: AppColor.ink05,
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<DiscoverCubit, DiscoverState>(
              builder: (context, state) {
                return state.selectedIndex == 0
                    ? const TripsPage()
                    : state.selectedIndex == 1
                        ? const FavoritePage()
                        : const SettingsPage();
              },
            ),
          ),
          BlocBuilder<DiscoverCubit, DiscoverState>(
            builder: (context, state) {
              return BottomMenu(
                cubit: cubit,
              );
            },
          )
        ],
      ),
    );
  }

  Widget BottomMenu({required DiscoverCubit cubit}) {
    return Container(
      height: 96.0.h,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildItem(
            onTap: () => cubit.changeIndex(0),
            icon: Icons.location_on_sharp,
            title: 'Trips',
            isSelected: cubit.state.selectedIndex == 0,
          ),
          _buildItem(
            onTap: () => cubit.changeIndex(1),
            icon: Icons.favorite,
            title: 'Favorite',
            isSelected: cubit.state.selectedIndex == 1,
          ),
          _buildItem(
            onTap: () => cubit.changeIndex(2),
            icon: Icons.settings,
            title: 'Settings',
            isSelected: cubit.state.selectedIndex == 2,
          ),
        ],
      ),
    );
  }

  Widget _buildItem({
    required GestureTapCallback? onTap,
    required IconData icon,
    required String title,
    bool isSelected = false,
  }) {
    return GestureDetector(
      onTap: () {
        onTap!();
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isSelected ? Colors.black : Colors.grey,
          ),
          const SizedBox(height: 4.0),
          Text(
            title,
            style: TextStyle(
              color: isSelected ? Colors.black : Colors.grey,
              fontSize: 12.0.sp,
            ),
          ),
        ],
      ),
    );
  }
}
