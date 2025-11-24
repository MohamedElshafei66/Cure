import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:round_7_mobile_cure_team3/core/routes/app_routes.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_colors.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_icons.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_images.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_styles.dart';
import 'package:round_7_mobile_cure_team3/feature/home/presentation/cubits/user_cubit.dart';
import 'package:round_7_mobile_cure_team3/feature/map/services/location_search_service.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HeaderSection extends StatelessWidget {
  final VoidCallback onNotificationTap;
  final VoidCallback onFavoritesTap;

  const HeaderSection({
    super.key,
    required this.onNotificationTap,
    required this.onFavoritesTap,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        final loading = state is UserLoading || state is UserInitial;
        return Skeletonizer(
          enableSwitchAnimation: true,
          enabled: loading,
          child: Container(
            margin: const EdgeInsets.only(top: 24),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Profile Image or Skeleton
                ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: loading
                      ? Container(
                          width: 50,
                          height: 50,
                          color: Colors.grey[300],
                        )
                      : Image.network(
                          (state as UserLoaded).user.imgUrl ??
                              AppImages.profileImage,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              AppImages.profileImage,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                ),

                const SizedBox(width: 8),

                // Name + Address
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    loading
                        ? Container(
                            width: 150,
                            height: 14,
                            color: Colors.grey[300],
                          )
                        : Text(
                            "Welcome back, ${(state as UserLoaded).user.fullName.trim()}",
                            style: AppStyle.styleRegular16(context),
                          ),
                    const SizedBox(height: 6),

                    Row(
                      children: [
                        if (!loading) Image.asset(AppIcons.location, width: 18),

                        if (!loading) const SizedBox(width: 4),

                        loading
                            ? Container(
                                width: 120,
                                height: 12,
                                color: Colors.grey[300],
                              )
                            : Text(
                                ((state as UserLoaded)
                                            .user
                                            .address
                                            ?.isNotEmpty ??
                                        false)
                                    ? state.user.address!
                                    : "Please add address",
                                style: AppStyle.styleMedium12(context),
                              ),

                        if (!loading) const SizedBox(width: 4),

                        // Change Location Button
                        if (!loading)
                          Builder(
                            builder: (builderContext) {
                              return IconButton(
                                onPressed: () async {
                                  final result = await builderContext.push(
                                    AppRoutes.map,
                                  );
                                  if (result is Position &&
                                      builderContext.mounted) {
                                    final address =
                                        await LocationSearchService.getAddressFromCoordinates(
                                          LatLng(
                                            result.latitude,
                                            result.longitude,
                                          ),
                                        );

                                    if (builderContext.mounted) {
                                      ScaffoldMessenger.of(
                                        builderContext,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Location updated: $address',
                                          ),
                                          backgroundColor: AppColors.primary,
                                          duration: const Duration(seconds: 2),
                                        ),
                                      );

                                      builderContext
                                          .read<UserCubit>()
                                          .refreshUser();
                                    }
                                  }
                                },
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  color: AppColors.grey,
                                ),
                              );
                            },
                          ),
                      ],
                    ),
                  ],
                ),

                const Spacer(),

                // Favourites Icon
                loading
                    ? Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                      )
                    : IconButtonWidget(
                        icon: AppIcons.heartPng,
                        onTap: onFavoritesTap,
                      ),

                const SizedBox(width: 8),

                // Notification Icon
                loading
                    ? Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                      )
                    : IconButtonWidget(
                        icon: AppIcons.notification,
                        onTap: onNotificationTap,
                      ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class IconButtonWidget extends StatelessWidget {
  final String icon;
  final VoidCallback onTap;

  const IconButtonWidget({super.key, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border(left: BorderSide(color: AppColors.grey, width: 1)),
        ),
        child: Image.asset(icon, width: 16, height: 18),
      ),
    );
  }
}
