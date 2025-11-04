import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_strings.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back_ios_new),
      
        title: Text(AppStrings.privacyPolicy),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Last Updated: ',
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  TextSpan(
                    text: '19/11/2024',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Gap(10),
            Text(
              "Welcome to Cure. Your privacy is important to\n us. This Privacy Policy explains how we collect,\n use, and protect your personal information\n when you use our doctor appointment booking\n app.",
            ),
               Gap(50),
            

            Text("terms & conditions"),
               Gap(5),
            Text(
              "By registering, accessing, or using this app, you \n confirm that you are at least 18 years old (or have \n parental/guardian consent if younger) and agree\n to be bound by these Terms and our Privacy \nPolicy.",
            ),
            Text('You agree to:'),
            Padding(
              padding: const EdgeInsets.only(right: 8,left: 8),
              child: Text(
                '- Use the app only for lawful purposes.\n'
                '- Provide accurate and complete information \n  during registration and booking.\n'
                '- Not impersonate others or create fake \n  accounts.'
              ),
            ),
            Text('You may not:'),
            Padding(
              padding: const EdgeInsets.only(right: 8,left: 8),
              child: Text( 
                  '- Disrupt or interfere with the app’s functionality.\n'
                  '- Try to access data or systems not meant for you.\n'
                  '- Use the app to harass or abuse doctors or\n  staff.'
                  ),
                 
            ),
            Text('Your data is handled in accordance with our\n[Privacy Policy] . '
                  'You are responsible for keeping your login credentials secure.',)
          ],
        ),
      ),
    );
  }
}
