import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_strings.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_styles.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () => context.pop(),
          child: Icon(Icons.arrow_back_ios_new),
        ),

        title: Text(
          AppStrings.privacyPolicy,
          style: AppStyle.styleRegular24(context),
        ),
        centerTitle: true,
      ),
      body: 
         Padding(
          padding: const EdgeInsets.all(20.0),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Last Updated: ',
                      style: AppStyle.styleRegular20(context),
                    ),
                    TextSpan(
                      text: '19/11/2024',
                      style: AppStyle.styleMedium16(context),
                    ),
                  ],
                ),
              ),
              Gap(10),
              Text(
                "Welcome to Cure. Your privacy is important to\n us. This Privacy Policy explains how we collect,\n use, and protect your personal information \n when you use our doctor appointment booking\n app.",
                style: AppStyle.styleMedium16(context),
              ),
              Gap(50),

              Text(
                "terms & conditions",
                style: AppStyle.styleRegular24(context),
              ),
              Gap(5),
              Text(
                "By registering, accessing, or using this app, you confirm that you are at least 18 years old (or have parental/guardian consent if younger) and agree to be bound by these Terms and our Privacy Policy.",
                style: AppStyle.styleMedium16(context),
              ),
              Text('You agree to:', style: AppStyle.styleMedium16(context)),
              Padding(
                padding: const EdgeInsets.only(right: 8, left: 8),
                child: Text(
                  '. Use the app only for lawful purposes.\n'
                  '. Provide accurate and complete information \n  during registration and booking.\n'
                  '. Not impersonate others or create fake \n  accounts.',
                  style: AppStyle.styleMedium16(context),
                ),
              ),
              Text('You may not:', style: AppStyle.styleMedium16(context)),
              Padding(
                padding: const EdgeInsets.only(right: 8, left: 8),
                child: Text(
                  '. Disrupt or interfere with the app’s\n  functionality.\n'
                  '. Try to access data or systems not meant for you.\n'
                  '. Use the app to harass or abuse doctors or\n  staff.',
                  style: AppStyle.styleMedium16(context),
                ),
              ),
              Text(
                'Your data is handled in accordance with our\n[Privacy Policy] . '
                'You are responsible for keeping your login credentials secure.',
                style: AppStyle.styleMedium16(context),
              ),
            ],
          ),
        ),
      
    );
  }
}
