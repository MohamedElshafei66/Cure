import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_images.dart';
import '../utils/app_strings.dart';
import '../utils/app_styles.dart';
class ChatCard extends StatelessWidget {
   ChatCard({super.key,required this.doctorName,required this.doctorImage});
  String doctorImage;
  String doctorName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 5),
      child: Container(
        padding: EdgeInsets.all(8),
        height: 80,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: AppColors.lightGrey
        ),
        child: Row(
          children: [
            Image.asset(doctorImage),
            Column(
              children: [
                Text(doctorName,style: AppStyle.styleMedium16(context),),
                Text("It’s been around six.....",style: AppStyle.styleRegular14(context),)
              ],
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: Text("9:30",style: AppStyle.styleRegular14(context),),
            )
          ],
        ),
      ),
    );
  }
}
