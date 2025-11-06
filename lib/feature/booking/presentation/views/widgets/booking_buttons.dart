import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:round_7_mobile_cure_team3/core/routes/app_routes.dart';
import 'package:round_7_mobile_cure_team3/feature/booking/presentation/views/widgets/cancel_booking.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/utils/app_styles.dart';

Widget bookingButtons(String status,BuildContext context) {
  switch (status) {
    case 'Upcoming':
      return Row(
        children: [
          Expanded(
            child: MaterialButton(
              onPressed:(){
                cancelBooking(context);
              },
              shape:OutlineInputBorder(
                  borderSide:BorderSide(
                    color:AppColors.textHint,
                  ),
                  borderRadius:BorderRadius.circular(10)
              ),
              child:  Text(
                  AppStrings.cancel,
                  style:AppStyle.styleMedium14(context).copyWith(
                      color:AppColors.textSecondary,
                      fontWeight:FontWeight.w400
                  )
              ),
            ),
          ),
          const SizedBox(
              width: 10
          ),
          Expanded(
            child: MaterialButton(
              onPressed:(){
                context.push(AppRoutes.rescheduleScreen);
              },
              color:AppColors.primary,
              shape:OutlineInputBorder(
                  borderSide:BorderSide(
                      color:AppColors.primary
                  ),
                  borderRadius:BorderRadius.circular(10)
              ),
              child:Text(
                  AppStrings.reschedule,
                  style:AppStyle.styleMedium14(context).copyWith(
                      color:AppColors.whiteColor,
                      fontWeight:FontWeight.w400
                  )
              ),
            ),
          ),
        ],
      );
    case 'Completed':
      return Row(
        children: [
          Expanded(
            child:MaterialButton(
              onPressed:(){},
              shape:OutlineInputBorder(
                  borderSide:BorderSide(
                    color:AppColors.primary,
                  ),
                  borderRadius:BorderRadius.circular(10)
              ),
              child:  Text(
                  AppStrings.bookAgain,
                  style:AppStyle.styleMedium14(context).copyWith(
                      color:AppColors.primary,
                      fontWeight:FontWeight.w400
                  )
              ),
            ),
          ),
          const SizedBox(
              width: 10
          ),
          Expanded(
            child: MaterialButton(
              onPressed:(){},
              color:AppColors.primary,
              shape:OutlineInputBorder(
                  borderSide:BorderSide(
                      color:AppColors.primary
                  ),
                  borderRadius:BorderRadius.circular(10)
              ),
              child:Text(
                  AppStrings.feedBack,
                  style:AppStyle.styleMedium14(context).copyWith(
                      color:AppColors.whiteColor,
                      fontWeight:FontWeight.w400
                  )
              ),
            ),
          ),
        ],
      );
    case 'Canceled':
      return Row(
        children: [
          Expanded(
            child:MaterialButton(
              onPressed:(){},
              shape:OutlineInputBorder(
                  borderSide:BorderSide(
                    color:AppColors.primary,
                  ),
                  borderRadius:BorderRadius.circular(10)
              ),
              child:  Text(
                  AppStrings.bookAgain,
                  style:AppStyle.styleMedium14(context).copyWith(
                      color:AppColors.primary,
                      fontWeight:FontWeight.w400
                  )
              ),
            ),
          ),
          const SizedBox(
              width: 10
          ),
          Expanded(
            child: MaterialButton(
              onPressed:(){},
              color:AppColors.primary,
              shape:OutlineInputBorder(
                  borderSide:BorderSide(
                      color:AppColors.primary
                  ),
                  borderRadius:BorderRadius.circular(10)
              ),
              child:Text(
                  AppStrings.support,
                  style:AppStyle.styleMedium14(context).copyWith(
                      color:AppColors.whiteColor,
                      fontWeight:FontWeight.w400
                  )
              ),
            ),
          ),
        ],
      );
    default:
      return const SizedBox();
  }
}