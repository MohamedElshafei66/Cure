import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_colors.dart';
import 'package:svg_image/svg_image.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 70,horizontal: 20),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
          children: [
         Container(
      
          decoration: BoxDecoration(
            color: AppColors.lightGrey,
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
             
            children: [
            //profile image
              Image.asset("assets/images/profile_image.png"),
                Gap(10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gap(10),
                    Text("Seif Mohamed",style: TextStyle(fontWeight: FontWeight.w400),),
                     Gap(5),
                    Row(
                      children: [
                        Image.asset("assets/icons/Location.png"),
                        Text("129,El-Nasr Street, Cairo"),
                      ],
                    )
                        
                  ],),
              ),
                IconButton(onPressed: (){}, icon:SvgPicture.asset("assets/icons/arrow_back.svg"))
                ],),),

                
        ],),
      ),
    );
  }
}
