import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_images.dart';
import 'package:svg_image/svg_image.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../cubit/booking_search_cubit.dart';

void cancelBooking(BuildContext context, String bookingId) {
  // Get the cubit from the original context before showing dialog
  final cubit = context.read<BookingSearchCubit>();
  
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext dialogContext) {
      final size = MediaQuery.of(dialogContext).size;
      final isSmallScreen = size.width < 400;

      return BlocProvider.value(
        value: cubit,
        child: Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.symmetric(
            horizontal: isSmallScreen ? 20 : 40,
            vertical: isSmallScreen ? 40 : 80,
          ),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: isSmallScreen ? 20 : 40,
              vertical: isSmallScreen ? 25 : 40,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: BlocListener<BookingSearchCubit, BookingSearchState>(
              listener: (listenerContext, state) {
                if (state is BookingSearchSuccess) {
                  Navigator.pop(dialogContext);
                } else if (state is BookingSearchError) {
                  Navigator.pop(dialogContext);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: AppColors.red,
                    ),
                  );
                }
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgImage(
                      AppImages.warningImage,
                      type:PathType.assets
                  ),
                  SizedBox(
                    height:30,
                  ),
                  FittedBox(
                    fit:BoxFit.fill,
                    child: Text(
                        AppStrings.warning,
                        textAlign: TextAlign.center,
                        style:AppStyle.styleRegular20(dialogContext).copyWith(
                            color:AppColors.orange,
                            fontWeight:FontWeight.w600
                        )
                    ),
                  ),
                  SizedBox(
                      height:8
                  ),
                  Text(
                    textAlign:TextAlign.center,
                    AppStrings.cancelBooking,
                    style:AppStyle.styleRegular14(dialogContext).copyWith(
                        color:AppColors.textSecondary
                    ),
                  ),
                  SizedBox(
                      height:15
                  ),
                  Text(
                      AppStrings.areYouSure,
                      style:AppStyle.styleRegular14(dialogContext).copyWith(
                          color:AppColors.textSecondary
                      )
                  ),
                  SizedBox(
                      height:15
                  ),
                  BlocBuilder<BookingSearchCubit, BookingSearchState>(
                    builder: (builderContext, state) {
                      final isLoading = state is BookingSearchLoading;
                      return SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: isLoading ? null : () {
                            cubit.cancelBooking(bookingId);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:AppColors.textPrimary,
                            padding: EdgeInsets.symmetric(
                              vertical: isSmallScreen ? 12 : 15,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          child: isLoading
                              ? SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.whiteColor),
                                  ),
                                )
                              : Text(
                                  AppStrings.yesCancel,
                                  style:AppStyle.styleRegular16(dialogContext).copyWith(
                                      color:AppColors.whiteColor
                                  )
                              ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}