import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:round_7_mobile_cure_team3/core/routes/app_routes.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_icons.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_images.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_styles.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/logic/Cubit/profile_cubit.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/ui/widget/custom_profile_image.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  String resolveImageUrl(String imgUrl) {
    if (imgUrl.isEmpty) return "";
    if (!imgUrl.startsWith("http")) {
      return "https://cure-doctor-booking.runasp.net$imgUrl";
    }
    return imgUrl;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoaded) {
          final profile = state.profile;
          final hasImage = profile.imgUrl.isNotEmpty;
          final imageUrl = hasImage
              ? resolveImageUrl(profile.imgUrl)
              : AppImages.profileImage;

          return Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomProfileImage(imageAsset: imageUrl, isNetwork: hasImage),
                const Gap(15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        profile.fullName.isNotEmpty
                            ? profile.fullName
                            : "No Name",
                        style: AppStyle.styleRegular20(context).copyWith(
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Gap(6),
                      Row(
                        children: [
                          Image.asset(AppIcons.location, height: 16),
                          const Gap(5),
                          Expanded(
                            child: Text(
                              profile.address.isNotEmpty
                                  ? profile.address
                                  : "No Address",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: AppStyle.styleRegular14(
                                context,
                              ).copyWith(color: Colors.grey.shade600),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(50),
                  onTap: () async {
                    final result = await context.push(
                      AppRoutes.profileEdit,
                      extra: profile,
                    );
                    if (result == true && context.mounted) {
                      context.read<ProfileCubit>().getProfile();
                    }
                  },
                  child: Image.asset(AppIcons.arrow, width: 50, height: 50),
                ),
              ],
            ),
          );
        }

        if (state is ProfileLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomProfileImage(
              imageAsset: AppImages.profileImage,
              isNetwork: false,
            ),
            const Gap(10),
            Text(
              "No Profile Data",
              style: AppStyle.styleRegular20(
                context,
              ).copyWith(color: Colors.grey.shade600),
            ),
          ],
        );
      },
    );
  }
}
