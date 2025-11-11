import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_icons.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_images.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_styles.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/ui/widget/custom_profile_image.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          CustomProfileImage(imageAsset: AppImages.profileImage),
          const Gap(10),
          Text("Seif Mohamed", style: AppStyle.styleRegular20(context)),
          const Gap(8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(AppIcons.location, height: 16),
              const Gap(5),
              Text(
                "129, El-Nasr Street, Cairo",
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: AppStyle.styleRegular14(context),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

