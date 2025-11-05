import 'package:flutter/material.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_colors.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_strings.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_styles.dart';

class FaqsScreen extends StatefulWidget {
  const FaqsScreen({super.key});

  @override
  State<FaqsScreen> createState() => _FaqsScreenState();
}

class _FaqsScreenState extends State<FaqsScreen> {
  int? expandedIndex;

  final List<Map<String, String>> faqs = [
    {
      'question': 'What is this app used for?',
      'answer':
          'This app allows you to search for doctors book appointments, and consult in person easily from your phone.',
    },
    {
      'question': 'Is the app free to use?',
      'answer': 'Yes, the app is free to download and use for basic features.',
    },
    {
      'question': 'How can I find a doctor?',
      'answer': 'You can search for doctors by specialty, name, or location.',
    },
    {
      'question': 'Can I cancel my appointment?',
      'answer':
          'Yes, you can cancel or reschedule from the “My Bookings” section.',
    },
    {
      'question': 'What payment methods are supported?',
      'answer':
          'We support multiple payment options including cards and wallets.',
    },
    {
      'question': 'How do I edit my profile?',
      'answer':
          'Go to Profile > Settings and update your personal information.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      //app Bar
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const Icon(Icons.arrow_back_ios_new),
        title: Text(
          AppStrings.fAQs,
          style: AppStyle.styleRegular24(context),
        ),
        centerTitle: true,
      ),
        //
      body: ListView.builder(
        itemCount: faqs.length,
        itemBuilder: (_, index) {
          final faq = faqs[index];
          final isExpanded = expandedIndex == index;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                
               
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.lightGrey,
                   
                  ),
                ],
              ),
              child: ExpansionTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                collapsedShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                tilePadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                childrenPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                title: Text(
                  faq["question"]!,
                  style: AppStyle.styleRegular20(context)
                      
                ),
                trailing: Icon(
                  isExpanded ? Icons.remove : Icons.add,
                  
                ),
                onExpansionChanged: (value) {
                  setState(() {
                    expandedIndex = value ? index : null;
                  });
                },
                children: [
                  Divider(color: AppColors.textHint),
                  Text(
                    faq["answer"]!,
                    style: AppStyle.styleMedium16(context)
                       
                  ),
                   SizedBox(height: 10),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
