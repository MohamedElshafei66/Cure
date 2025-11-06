import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:round_7_mobile_cure_team3/core/routes/app_routes.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_colors.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_icons.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_images.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_styles.dart';
import 'package:round_7_mobile_cure_team3/core/widgets/custom_search_bar.dart';
import 'package:round_7_mobile_cure_team3/feature/home/presentation/widgets/doctor_card.dart';
import 'package:round_7_mobile_cure_team3/feature/home/presentation/widgets/specialist_card.dart';

class Home extends StatefulWidget {
  Home({super.key});

  int selectedIndex = 0;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    final List<Map<String, dynamic>> specialties = [
      {'image': AppIcons.dentist, 'text': 'Dentist'},
      {'image': AppIcons.cardiologist, 'text': 'Cardiologist'},
      {'image': AppIcons.ent, 'text': 'ENT'},
      {'image': AppIcons.ophthalmologist, 'text': 'Ophthalmologist'},
      {'image': AppIcons.neurologist, 'text': 'Neurologist'},
      {'image': AppIcons.endocrinologist, 'text': 'Endocrinologist'},
      {'image': AppIcons.oncologist, 'text': 'Oncologist'},
      {'image': AppIcons.pulmonologist, 'text': 'Pulmonologist'},
      {'image': AppIcons.psychiatrist, 'text': 'Psychiatrist'},
      {'image': AppIcons.orthopedic, 'text': 'Orthopedic'},
      {'image': AppIcons.gastroenterologist, 'text': 'Gastroenterologist'},
    ];

    // final List<BottomNavigationBarItem> bottomNavBarItems = [
    //   BottomNavigationBarItem(icon: Image.asset(AppIcons.home), label: 'Home'),
    //   BottomNavigationBarItem(
    //     icon: Image.asset(AppIcons.booking),
    //     label: 'Booking',
    //   ),
    //   BottomNavigationBarItem(icon: Image.asset(AppIcons.chat), label: 'Chat'),
    //   BottomNavigationBarItem(
    //     icon: Image.asset(AppIcons.profile),
    //     label: 'profile',
    //   ),
    // ];
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 24),
                  child: Row(
                    children: [
                      Flexible(child: Image.asset(AppImages.profileImage)),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome back , Seif',
                            style: AppStyle.styleRegular16(context),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Image.asset(AppIcons.location),
                              const SizedBox(width: 4),

                              Text(
                                '129,El-Nasr Street, Cairo',
                                style: AppStyle.styleMedium12(context),
                              ),

                              const SizedBox(width: 4),
                              InkWell(
                                onTap: () => context.push(AppRoutes.map),
                                child: Icon(
                                  Icons.arrow_drop_down,
                                  color: AppColors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          context.push(AppRoutes.favourites);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border(
                              left: BorderSide(color: AppColors.grey, width: 1),
                            ),
                          ),
                          child: Image.asset(AppIcons.heartPng),
                        ),
                      ),
                      const SizedBox(width: 8),
                      InkWell(
                        onTap: () {
                          context.push(AppRoutes.notification_screen);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border(
                              left: BorderSide(color: AppColors.grey, width: 1),
                            ),
                          ),
                          child: Image.asset(AppIcons.notification),
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    context.push(AppRoutes.search);
                  },
                  child: AbsorbPointer(
                    child: CustomSearchBar(controller: searchController),
                  ),
                ),
                SizedBox(height: 24),
                Row(
                  children: [
                    Text(
                      'Specialties',
                      style: AppStyle.styleRegular20(context),
                    ),
                    Spacer(),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'View All',
                        style: AppStyle.styleMedium14(context),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                SizedBox(
                  height: 60,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: specialties.length,
                    itemBuilder: (context, index) {
                      final item = specialties[index];
                      return SpecialistCard(
                        image: item['image'],
                        text: item['text'],
                        selected: widget.selectedIndex == index,
                        onTap: () {
                          setState(() => widget.selectedIndex = index);
                        },
                      );
                    },
                  ),
                ),
                SizedBox(height: 24),
                Image.asset(
                  AppImages.homeImage,
                  fit: BoxFit.fill,
                  width: double.infinity,
                ),
                SizedBox(height: 24),
                Row(
                  children: [
                    Text(
                      'Doctors near you',
                      style: AppStyle.styleRegular20(context),
                    ),
                    Spacer(),
                    TextButton(
                      onPressed: () {
                        context.push(AppRoutes.doctorsNearby);
                      },
                      child: Text(
                        'View All',
                        style: AppStyle.styleMedium14(context),
                      ),
                    ),
                  ],
                ),
                DoctorCard(isFavourite: false),
                DoctorCard(isFavourite: true),
                DoctorCard(isFavourite: true),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
