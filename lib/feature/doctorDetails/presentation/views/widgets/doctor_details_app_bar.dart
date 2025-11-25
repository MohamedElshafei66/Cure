import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:round_7_mobile_cure_team3/core/constants/auth_provider.dart';
import 'package:round_7_mobile_cure_team3/core/routes/app_routes.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_images.dart';
import 'package:round_7_mobile_cure_team3/feature/chat/data/data_sources/chat_remote_data_source.dart';
import 'package:round_7_mobile_cure_team3/feature/chat/data/repositories/ChatRepositoryImp.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/cubit/doctor_details_cubit.dart';
import 'package:svg_image/svg_image.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_styles.dart';

class DoctorDetailsAppbar extends StatelessWidget
    implements PreferredSizeWidget {
  final bool showActions;
  final String text;
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  const DoctorDetailsAppbar({
    super.key,
    this.showActions = false,
    required this.text,
  });
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.whiteColor,
      centerTitle: true,
      elevation: 0,
      title: Text(
        text,
        style: AppStyle.styleRegular24(
          context,
        ).copyWith(color: AppColors.blackColor),
      ),
      leading: IconButton(
        onPressed: () {
          context.pop();
        },
        icon: Icon(Icons.arrow_back_ios_rounded, color: AppColors.textPrimary),
      ),
      actions: showActions
          ? [
              BlocBuilder<DoctorDetailsCubit, DoctorDetailsState>(
                builder: (context, state) {
                  return InkWell(
                    onTap: () {
                      if (state is DoctorDetailsLoaded) {
                        final doctor = state.doctorDetails;
                        final authProvider = context.read<AuthProvider>();

                        // Create chat repository
                        final chatRemote = ChatRemoteDataSource(
                          authProvider: authProvider,
                        );
                        final chatRepository = ChatRepositoryImpl(chatRemote);

                        // Navigate to chat screen with doctor info
                        print('🔵 Opening chat with doctor:');
                        print('  - Doctor ID: ${doctor.doctorId}');
                        print('  - User ID: ${doctor.doctorUserId}');
                        print('  - Name: ${doctor.doctorName}');

                        context.push(
                          AppRoutes.chatScreen,
                          extra: {
                            'doctorName': doctor.doctorName,
                            'doctorImage': doctor.doctorImage,
                            'receiverId':
                                doctor.doctorUserId, // Use doctor's user GUID
                            'chatId': '', // Will be created on first message
                            'chatRepository': chatRepository,
                          },
                        );
                      } else {
                        // Show message if doctor details not loaded
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Please wait for doctor details to load',
                            ),
                          ),
                        );
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: SvgImage(
                        AppImages.chatImage,
                        type: PathType.assets,
                      ),
                    ),
                  );
                },
              ),
            ]
          : [],
    );
  }
}
