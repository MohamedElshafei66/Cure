import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_strings.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_styles.dart';
import 'package:round_7_mobile_cure_team3/core/widgets/custom_button.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/ui/widget/Password_field%20.dart';


class PasswordManagment extends StatefulWidget {
  @override
  State<PasswordManagment> createState() => _PasswordManagmentState();
}

class _PasswordManagmentState extends State<PasswordManagment> {
  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmNewpasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.grey),
          onPressed: () {
            context.pop();
          },
        ),
        title: Text(
          AppStrings.passwordManagementTitle,
          style: AppStyle.styleRegular24(context),
        ),
        centerTitle: true,
      ),
      body: 
        Padding(
          padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
        
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Current password", style: AppStyle.styleMedium20(context)),
              Gap(13),
        
              PasswordField(
                controller: currentPasswordController,
                hintText: "enter your password",
               
              ),
              Gap(20),
              Text("New password", style: AppStyle.styleMedium20(context)),
              Gap(13),
              PasswordField(
                controller: newPasswordController,
                hintText: "enter your password",
               
              ),
              Gap(20),
              Text(
                "Confirm new password",
                style: AppStyle.styleMedium20(context),
              ),
              Gap(13),
              PasswordField(
                controller: confirmNewpasswordController,
                hintText: "enter your password",
               
              ),
                Gap(250),
              CustomButton(text: 'Change Password', onPressed: () {}),
              Gap(40),
            ],
          ),
        ),
      
    );
  }
}
