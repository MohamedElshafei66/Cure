import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_images.dart';
import 'package:svg_image/svg_image.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../cubit/appointment_cubit.dart';

void successAppointment(
  BuildContext context, {
  String? doctorName,
  DateTime? selectedDate,
  String? selectedTime,
}) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      final size = MediaQuery.of(context).size;
      final isSmallScreen = size.width < 400;
      
      // Try to get appointment data from AppointmentCubit if not provided
      String? finalDoctorName = doctorName;
      DateTime? finalSelectedDate = selectedDate;
      String? finalSelectedTime = selectedTime;
      
      try {
        final appointmentCubit = context.read<AppointmentCubit>();
        final appointmentState = appointmentCubit.state;
        
        // Use AppointmentCubit data if parameters are not provided
        finalDoctorName ??= appointmentState.doctorDetails?.doctorName;
        finalSelectedDate ??= appointmentState.selectedDate;
        finalSelectedTime ??= appointmentState.selectedTime;
      } catch (e) {

        print('AppointmentCubit not available: $e');
      }
      

      finalDoctorName ??= 'Doctor';
      
      // Format date
      String formattedDate = '';
      if (finalSelectedDate != null) {
        final weekdays = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
        final months = ['January', 'February', 'March', 'April', 'May', 'June', 
                        'July', 'August', 'September', 'October', 'November', 'December'];
        final weekday = weekdays[finalSelectedDate.weekday - 1];
        final month = months[finalSelectedDate.month - 1];
        formattedDate = '$weekday, $month ${finalSelectedDate.day}';
      }
      
      // Format time (already in 12-hour format like "10:00 AM")
      String formattedTime = finalSelectedTime ?? '';

      return Dialog(
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgImage(
                  AppImages.checkImage,
                  type:PathType.assets
              ),
              SizedBox(
                height:30,
              ),
              FittedBox(
                fit:BoxFit.fill,
                child: Text(
                    AppStrings.congratulations,
                    textAlign: TextAlign.center,
                    style:AppStyle.styleRegular20(context).copyWith(
                        color:AppColors.textPrimary,
                        fontWeight:FontWeight.w600
                    )
                ),
              ),
              SizedBox(
                  height:8
              ),
              if (finalDoctorName.isNotEmpty || formattedDate.isNotEmpty || formattedTime.isNotEmpty) ...[
              Text(
                textAlign:TextAlign.center,
                "Your appointment with $finalDoctorName is confirmed for $formattedDate - $formattedTime",
                style:AppStyle.styleRegular14(context).copyWith(
                  color:AppColors.textSecondary
                ),
              ),
              ],
              SizedBox(
                  height:15
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed:() => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:AppColors.textPrimary,
                    padding: EdgeInsets.symmetric(
                      vertical: isSmallScreen ? 12 : 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: Text(
                      AppStrings.done,
                      style:AppStyle.styleRegular16(context).copyWith(
                          color:AppColors.whiteColor
                      )
                  ),
                ),
              ),
              SizedBox(
                  height: 15
              ),
              GestureDetector(
                onTap:(){},
                child: Text(
                    AppStrings.editAppointment,
                    style:AppStyle.styleRegular14(context).copyWith(
                        color:AppColors.textPrimary
                    )
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}