import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_icons.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_strings.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_styles.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/ui/widget/profile_button.dart';

class PaymentMethodSecondScreen extends StatelessWidget {
  const PaymentMethodSecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.white,
       appBar: AppBar(
        backgroundColor:Colors.white, 
        leading: Icon(Icons.arrow_back_ios_new,color: Colors.grey,),
      
        title: Text(AppStrings.paymentMethod,style: AppStyle.styleRegular24(context),),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 100,left: 20,right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Image.asset(AppIcons.card),
          Text("Nothing to display here!",style: AppStyle.styleRegular24(context),),
          Text("Add your cards to make payment easier",style: AppStyle.styleRegular16(context).copyWith(color: Colors.grey),),
          Spacer(),
          ProfileButton(title: "Add Card"),
          Gap(50)
        ],),
      ),

    );
  }
}