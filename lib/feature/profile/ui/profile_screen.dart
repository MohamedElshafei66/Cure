import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:round_7_mobile_cure_team3/core/routes/app_routes.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_colors.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_icons.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/ui/widget/profile_item.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int currentIndex = 3;
  bool isNotificationOn = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 70, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.lightGrey,
                borderRadius: const BorderRadius.all(Radius.circular(8)),
              ),
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset("assets/images/profile_image.png", height: 60),
                  const Gap(10),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Seif Mohamed",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                        const Gap(5),
                        Row(
                          children: [
                            Image.asset(AppIcons.location, height: 16),
                            const Gap(5),
                            const Expanded(
                              child: Text(
                                "129, El-Nasr Street, Cairo",
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  IconButton(
                    onPressed: () {},
                    icon: SvgPicture.asset("assets/icons/arrow_back.svg"),
                  ),
                ],
              ),
            ),

            const Gap(40),

            // profile item
            ProfileItem(
              icon: AppIcons.notification,
              title: "Notification",
              switchValue: isNotificationOn,
              onSwitchChanged: (value) {
                setState(() {
                  isNotificationOn = value;
                });
              },
            ),
            const Gap(20),
            ProfileItem(
              icon: AppIcons.banknote,
              title: "Payment Method",
              onTap: () {
                context.go(AppRoutes.paymentMethodScreen);
              },
            ),
            const Gap(20),
            ProfileItem(icon: AppIcons.favorite, title: "Favorite"),
            const Gap(20),
            ProfileItem(
              icon: AppIcons.chatLine,
              title: "Settings",
              onTap: () {
                context.go(AppRoutes.settingScreen);
              },
            ),
            const Gap(20),
            ProfileItem(
              icon: AppIcons.locke,
              title: "Privacy Policy",
              onTap: () {
                context.go(AppRoutes.privacyPolicyScreen);
              },
            ),
            const Gap(20),
            ProfileItem(
              icon: AppIcons.logout,
              title: "Log out",
              showArrow: false,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.chatRecieve,
        showUnselectedLabels: true,

        items: [
          BottomNavigationBarItem(
            icon: Image.asset(AppIcons.home, height: 24, width: 24),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(AppIcons.booking, height: 24, width: 24),
            label: 'Booking',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(AppIcons.chat, height: 24, width: 24),
            label: 'Chat',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
