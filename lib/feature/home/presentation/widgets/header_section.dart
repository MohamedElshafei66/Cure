import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:provider/provider.dart';
import 'package:round_7_mobile_cure_team3/core/constants/secure_storage_data.dart';
=======
import 'package:round_7_mobile_cure_team3/core/constants/shared_data.dart';
>>>>>>> 8fc1234635d783872ebafe8a5be92910c4f6d3ab
import 'package:round_7_mobile_cure_team3/core/network/api_services.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_colors.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_icons.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_images.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_styles.dart';
import 'package:round_7_mobile_cure_team3/feature/home/data/models/user_model.dart';
import 'package:round_7_mobile_cure_team3/feature/home/data/repositories/user_repo_impl.dart';

class HeaderSection extends StatelessWidget {
  final VoidCallback onNotificationTap;
  final VoidCallback onFavoritesTap;

  const HeaderSection({
    super.key,
    required this.onNotificationTap,
    required this.onFavoritesTap,
  });

<<<<<<< HEAD
  Future<UserModel> getUser(BuildContext context) async {
    final secureStorage = Provider.of<SecureStorageService>(
      context,
      listen: false,
    );
    return await UserReposotryImpl(
      ApiServices(secureStorage: secureStorage),
=======
  Future<UserModel> getUser() async {
    return await UserReposotryImpl(
      ApiServices(token: SharedData.testToken),
>>>>>>> 8fc1234635d783872ebafe8a5be92910c4f6d3ab
    ).getUser();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserModel>(
<<<<<<< HEAD
      future: getUser(context),
=======
      future: getUser(),
>>>>>>> 8fc1234635d783872ebafe8a5be92910c4f6d3ab
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }

        final currentUser = snapshot.data!;

        return Container(
          margin: const EdgeInsets.only(top: 24),
          child: Row(
            children: [
              Flexible(
                child: Image.network(
                  currentUser.imgUrl!,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(AppImages.profileImage);
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
