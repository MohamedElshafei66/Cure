import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:round_7_mobile_cure_team3/core/constants/secure_storage_data.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_colors.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_icons.dart';
import 'package:round_7_mobile_cure_team3/feature/booking/presentation/views/booking_view.dart';
import 'package:round_7_mobile_cure_team3/feature/chat/presentation/view/chats_list_screen.dart';
import 'package:round_7_mobile_cure_team3/feature/home/presentation/home.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/data/repo/profile_repository.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/logic/Cubit/profile_cubit.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/ui/profile_screen.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<BottomNavigationBarItem> bottomNavBarItems = [
      BottomNavigationBarItem(
        icon: selectedIndex == 0
            ? Image.asset(AppIcons.selectedHome)
            : Image.asset(AppIcons.home),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: selectedIndex == 1
            ? Image.asset(AppIcons.selectedBooking)
            : Image.asset(AppIcons.booking),
        label: 'Booking',
      ),
      BottomNavigationBarItem(
        icon: selectedIndex == 2
            ? Image.asset(AppIcons.selectedChat)
            : Image.asset(AppIcons.chat),
        label: 'Chat',
      ),
      BottomNavigationBarItem(
        icon: selectedIndex == 3
            ? Image.asset(AppIcons.selectedProfile)
            : Image.asset(AppIcons.profile),
        label: 'profile',
      ),
    ];
    final List<Widget> screens = [
      Home(),
      BookingScreen(),
      ChatsListScreen(),
      BlocProvider(
        create: (context) {
          final secureStorage = Provider.of<SecureStorageService>(
            context,
            listen: false,
          );
          return ProfileCubit(
            ProfileRepository(secureStorage: secureStorage),
            secureStorage: secureStorage,
          );
        },
        child: ProfileScreen(),
      ),
    ];

    return Scaffold(
      body: IndexedStack(index: selectedIndex, children: screens),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        showUnselectedLabels: true,
        enableFeedback: true,
        items: bottomNavBarItems,
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.grey,
        selectedFontSize: 12,
        unselectedFontSize: 12,
      ),
    );
  }
}
