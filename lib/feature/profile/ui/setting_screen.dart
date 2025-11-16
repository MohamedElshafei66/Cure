import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:round_7_mobile_cure_team3/core/routes/app_routes.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_icons.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_strings.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_styles.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/ui/widget/delete_and_logout_dialog.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/ui/widget/profile_item.dart';
import 'package:round_7_mobile_cure_team3/feature/splash/splash_screen.dart';

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
          child: const Icon(Icons.arrow_back_ios_new, color: Colors.grey),
        ),
        title: Text(
          AppStrings.settings,
          style: AppStyle.styleRegular24(context),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          children: [
            // Logout Bottom Sheet
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.white,
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(25),
                    ),
                  ),
                  builder: (context) {
                    return FractionallySizedBox(
                      heightFactor: 0.35,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: DeleteAndLogoutDialog(
                          title: "Delete account",
                          message:
                              "Are you sure you want to delete your account?",
                          confirmText: "Yes, delete",
                          onConfirm: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SplashScreen()),
                            );
                          },
                        ),
                      ),
                    );
                  },
                );
              },
              child: ProfileItem(
                icon: AppIcons.person,
                title: "Delete account",
                showArrow: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
