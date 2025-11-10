import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:round_7_mobile_cure_team3/core/routes/app_routes.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_icons.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_strings.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_styles.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/ui/widget/profile_item.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () => context.pop(),
          child: Icon(Icons.arrow_back_ios_new, color: Colors.grey),
        ),

        title: Text(
          AppStrings.settings,
          style: AppStyle.styleRegular24(context),
        ),
        centerTitle: true,
      ),

      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 15, vertical: 40),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                context.push(AppRoutes.passwordManagement);
              },
              child: ProfileItem(
                icon: AppIcons.password,
                title: "Password Management",
              ),
            ),
            Gap(30),
            ProfileItem(
              icon: AppIcons.person,
              title: "Delete Account",
              showArrow: false,
            ),
          ],
        ),
      ),
    );
  }
}
