import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_colors.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_icons.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_images.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_styles.dart';
import 'package:round_7_mobile_cure_team3/feature/home/presentation/cubits/user_cubit.dart';

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
        if (state is UserLoading || state is UserInitial) {
          return const Center(
            child: SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          );
        }

        if (state is UserError) {
          return Center(
            child: Text(
              'Failed to load profile',
              style: AppStyle.styleMedium14(context),
            ),
          );
        }

        if (state is! UserLoaded) {
          return const SizedBox();
        }

        final currentUser = state.user;

        return Container(
          margin: const EdgeInsets.only(top: 24),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image.network(
                  currentUser.imgUrl ?? AppImages.profileImage,
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome back, ${currentUser.fullName.trim()}',
                    style: AppStyle.styleRegular16(context),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Image.asset(AppIcons.location),
                      const SizedBox(width: 4),
                      Text(
                        currentUser.address == ""
                            ? "Please add address"
                            : currentUser.address!,
                        style: AppStyle.styleMedium12(context),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.arrow_drop_down, color: AppColors.grey),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              IconButtonWidget(icon: AppIcons.heartPng, onTap: onFavoritesTap),
              const SizedBox(width: 8),
              IconButtonWidget(
                icon: AppIcons.notification,
                onTap: onNotificationTap,
              ),
            ],
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