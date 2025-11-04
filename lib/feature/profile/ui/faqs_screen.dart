import 'package:flutter/material.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_colors.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_strings.dart';

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
          'This app allows you to search for doctors, book appointments, and consult in person easily from your phone.',
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
      'question': 'What payment are supported?',
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
      appBar: AppBar(
        leading: Icon(Icons.arrow_back_ios_new),
        title: Text(AppStrings.fAQs),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: faqs.length,

        itemBuilder: (_, index) {
          final faq = faqs[index];
          final isExpanded = expandedIndex == index;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                ),

                 ExpansionTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  collapsedShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  tilePadding: const EdgeInsets.symmetric(horizontal: 15),
                  childrenPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  title: Text(faq["question"]!),
                  trailing: isExpanded ? Icon(Icons.remove) : Icon(Icons.add),
                  onExpansionChanged: (value) {
                    setState(() {
                      expandedIndex = value ? index : null;
                    });
                  },
                  children: [
                    Divider(color: Colors.grey.shade300),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100, //
                        borderRadius: BorderRadius.circular(8),
                      ),

                      child: Text(faq["answer"]!),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
