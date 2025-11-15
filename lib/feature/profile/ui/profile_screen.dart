import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:round_7_mobile_cure_team3/core/routes/app_routes.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_colors.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_icons.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/data/repo/profile_repository.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/logic/Cubit/profile_cubit.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/ui/widget/delete_and_logout_dialog.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/ui/widget/profile_item.dart';

class ProfileScreen extends StatefulWidget {

 

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isNotificationOn = true;

  @override
  void initState() {
    super.initState();
    
    context.read<ProfileCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileCubit(ProfileRepository()),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 70, horizontal: 20),
          child: BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ProfileLoaded) {
                final profile = state.profile;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Profile Header
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.lightGrey,
                        borderRadius: const BorderRadius.all(Radius.circular(8)),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: profile.imgUrl.isNotEmpty
                                ? NetworkImage(profile.imgUrl)
                                : const AssetImage("assets/images/profile_image.png")
                                    as ImageProvider,
                          ),
                          const Gap(10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  profile.fullName,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                                const Gap(5),
                                Row(
                                  children: [
                                    Image.asset(AppIcons.location, height: 16),
                                    const Gap(5),
                                    Expanded(
                                      child: Text(
                                        profile.address.isNotEmpty
                                            ? profile.address
                                            : "No address",
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              context.push(AppRoutes.profileEdit);
                            },
                            icon: SvgPicture.asset("assets/icons/arrow_back.svg"),
                          ),
                        ],
                      ),
                    ),

                    const Gap(40),

                    // Profile Items
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
                        context.push(AppRoutes.paymentMethodScreen);
                      },
                    ),
                    const Gap(10),
                    ProfileItem(
                      icon: AppIcons.favorite,
                      title: "Favorite",
                      onTap: () => context.push(AppRoutes.favourites),
                    ),
                    const Gap(20),
                    ProfileItem(
                      icon: AppIcons.chatLine,
                      title: "Settings",
                      onTap: () {
                        context.push(AppRoutes.settingScreen);
                      },
                    ),
                    const Gap(10),
                    ProfileItem(
                      icon: AppIcons.chatLine,
                      title: "FAQS",
                      onTap: () {
                        context.push(AppRoutes.faqsSreen);
                      },
                    ),
                    const Gap(10),
                    ProfileItem(
                      icon: AppIcons.locke,
                      title: "Privacy Policy",
                      onTap: () {
                        context.push(AppRoutes.privacyPolicyScreen);
                      },
                    ),
                    const Gap(10),

                    // Logout Bottom Sheet
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          backgroundColor: Colors.white,
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(25)),
                          ),
                          builder: (context) {
                            return FractionallySizedBox(
                              heightFactor: 0.35,
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: DeleteAndLogoutDialog(
                                  title: "Logout",
                                  message:
                                      "Are you sure you want to log out?",
                                  confirmText: "Yes, Logout",
                                  onConfirm: () {
                                    Navigator.pop(context);
                                    WidgetsBinding.instance.addPostFrameCallback((_) {
                                      if (context.mounted) {
                                        context.push(AppRoutes.profileEdit);
                                      }
                                    });
                                  },
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: ProfileItem(
                        icon: AppIcons.logout,
                        title: "Log out",
                        showArrow: false,
                      ),
                    ),
                  ],
                );
              } else if (state is ProfileError) {
                return Center(child: Text(state.message));
              } else {
                return const Center(child: Text("No data available"));
              }
            },
          ),
        ),
      ),
    );
  }
}
