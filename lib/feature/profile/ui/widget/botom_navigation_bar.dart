import 'package:flutter/material.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_colors.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_icons.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/ui/privacy_policy_screen.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/ui/profile_screen.dart';

class BotomNavigationBar extends StatefulWidget {
  const BotomNavigationBar({super.key});

  @override
  State<BotomNavigationBar> createState() => _BotomNavigationBarState();
}

class _BotomNavigationBarState extends State<BotomNavigationBar> {
  int currentIndex = 4;

  final List<Widget> screens = [
   
    PrivacyPolicyScreen(),
    PrivacyPolicyScreen(),
    PrivacyPolicyScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.chatRecieve,
        showUnselectedLabels: true,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(AppIcons.home, height: 24, width: 24),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(AppIcons.booking, height: 24, width: 24),
            label: 'Booking',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(AppIcons.chat, height: 24, width: 24),
            label: 'Chat',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
