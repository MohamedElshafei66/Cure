import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:round_7_mobile_cure_team3/core/constants/auth_provider.dart';
import 'package:round_7_mobile_cure_team3/core/network/api_services.dart';
import 'package:round_7_mobile_cure_team3/core/routes/app_routes.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_icons.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/data/ProfileRemoteDataSource.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/data/repo/profile_repository.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/logic/Cubit/notification_cubit.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/logic/Cubit/profile_cubit.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/ui/widget/delete_and_logout_dialog.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/ui/widget/profile_header.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/ui/widget/profile_item.dart';
import 'package:round_7_mobile_cure_team3/feature/splash/splash_screen.dart';

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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ProfileCubit(
            ProfileRepository(ProfileRemoteDataSource(ApiServices(authProvider:context.read<AuthProvider>()))),
          )..getProfile(),
        ),

        BlocProvider(
          create: (_) => NotificationCubit(
            ProfileRepository(ProfileRemoteDataSource(ApiServices(authProvider:context.read<AuthProvider>()))),
          )..loadStatus(),
        ),
      ],

      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
            child: BlocBuilder<ProfileCubit, ProfileState>(
              builder: (context, state) {
                if (state is ProfileLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ProfileLoaded) {
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const ProfileHeader(),
                        const Gap(40),

                        BlocBuilder<NotificationCubit, NotificationState>(
                          builder: (context, state) {
                            bool isOn = false;

                            if (state is NotificationLoaded) {
                              isOn = state.isOn;
                            }

                            return ProfileItem(
                              icon: AppIcons.notification,
                              title: "Notification",
                              switchValue: isOn,
                              onSwitchChanged: (value) {
                                context.read<NotificationCubit>().toggle();
                              },
                            );
                          },
                        ),

                        const Gap(10),

                        ProfileItem(
                          icon: AppIcons.banknote,
                          title: "Payment Method",
                          onTap: () =>
                              context.push(AppRoutes.paymentMethodScreen),
                        ),
                        const Gap(10),

                        ProfileItem(
                          icon: AppIcons.favorite,
                          title: "Favorite",
                          onTap: () => context.push(AppRoutes.favourites),
                        ),
                        const Gap(10),

                        ProfileItem(
                          icon: AppIcons.settings,
                          title: "Settings",
                          onTap: () => context.push(AppRoutes.settingScreen),
                        ),
                        const Gap(10),

                        ProfileItem(
                          icon: AppIcons.chatLine,
                          title: "FAQS",
                          onTap: () => context.push(AppRoutes.faqsSreen),
                        ),
                        const Gap(10),

                        ProfileItem(
                          icon: AppIcons.locke,
                          title: "Privacy Policy",
                          onTap: () =>
                              context.push(AppRoutes.privacyPolicyScreen),
                        ),
                        const Gap(10),

                        // Logout Button
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
                                      title: "Logout",
                                      message:
                                      "Are you sure you want to log out?",
                                      confirmText: "Yes, Logout",
                                      onConfirm: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                SplashScreen(),
                                          ),
                                        );

                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              "Logged out successfully",
                                            ),
                                          ),
                                        );
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
                    ),
                  );
                } else if (state is ProfileError) {
                  return Center(
                    child: Text(
                      "Error: ${state.message}",
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                } else {
                  return const Center(child: Text("No profile data available"));
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}