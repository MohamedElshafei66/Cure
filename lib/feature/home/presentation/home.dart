import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:round_7_mobile_cure_team3/core/routes/app_routes.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_icons.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_styles.dart';
import 'package:round_7_mobile_cure_team3/feature/doctors/presentation/cubits/doctor_cubit.dart';
import 'package:round_7_mobile_cure_team3/feature/home/presentation/widgets/banner_section.dart';
import 'package:round_7_mobile_cure_team3/feature/home/presentation/widgets/doctors_nearby.dart';
import 'package:round_7_mobile_cure_team3/feature/home/presentation/widgets/header_section.dart';
import 'package:round_7_mobile_cure_team3/feature/home/presentation/widgets/search_section.dart';
import 'package:round_7_mobile_cure_team3/feature/home/presentation/widgets/specialists_section.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedIndex = 0;
  final TextEditingController searchController = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeaderSection(
                  onNotificationTap: () =>
                      context.push(AppRoutes.notification_screen),
                  onFavoritesTap: () => context.push(AppRoutes.favourites),
                ),
                const SizedBox(height: 16),
                SearchSection(controller: searchController),
                const SizedBox(height: 24),
                SpecialtiesSection(
                  specialties: specialties,
                  selectedIndex: selectedIndex,
                  onTap: (index) => setState(() => selectedIndex = index),
                ),
                const SizedBox(height: 24),
                BannerSection(),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Text(
                      'Doctors near you',
                      style: AppStyle.styleRegular20(context),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () => context.push(AppRoutes.allDoctorsScreen),
                      child: Text(
                        'View All',
                        style: AppStyle.styleMedium14(context),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                BlocProvider(
                  create: (context) => DoctorCubit()..fetchNearestDoctors(),
                  child: DoctorsNearby(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}