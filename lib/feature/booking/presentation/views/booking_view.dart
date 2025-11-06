import 'package:flutter/material.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_colors.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_strings.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_styles.dart';
import 'package:round_7_mobile_cure_team3/feature/booking/presentation/views/widgets/booking_view_body.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:AppColors.whiteColor,
      appBar:AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title:Text(
         AppStrings.booking,
          style:AppStyle.styleRegular20(context).copyWith(
            color:AppColors.textPrimary
          )
        ),
      ),
      body:BookingViewBody(),
    );
  }
}

