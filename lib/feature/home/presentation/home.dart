import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:round_7_mobile_cure_team3/core/network/api_services.dart';
import 'package:round_7_mobile_cure_team3/core/routes/app_routes.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_styles.dart';
import 'package:round_7_mobile_cure_team3/feature/doctors/presentation/cubits/doctor_cubit.dart';
import 'package:round_7_mobile_cure_team3/feature/favourites/presentation/cubits/favourties_cubit.dart';

/// Specialist cubit & repo imports (adjust the import paths to match your project)
import 'package:round_7_mobile_cure_team3/feature/home/data/repositories/specialist_repo_impl.dart';
import 'package:round_7_mobile_cure_team3/feature/home/presentation/cubits/specialists_cubit.dart';
import 'package:round_7_mobile_cure_team3/feature/home/presentation/widgets/banner_section.dart';
import 'package:round_7_mobile_cure_team3/feature/home/presentation/widgets/doctors_nearby.dart';
import 'package:round_7_mobile_cure_team3/feature/home/presentation/widgets/header_section.dart';
import 'package:round_7_mobile_cure_team3/feature/home/presentation/widgets/search_section.dart';
import 'package:round_7_mobile_cure_team3/feature/home/presentation/widgets/specialists_section.dart';

import '../../../core/constants/auth_provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Read your auth provider (used by other cubits)
    final authProvider = context.read<AuthProvider>();

    return MultiBlocProvider(
      providers: [
        BlocProvider<DoctorCubit>(
          create: (context) {
            final cubit = DoctorCubit(authProvider: authProvider);
            cubit.fetchAllDoctors();
            return cubit;
          },
        ),

        // Favourites cubit
        BlocProvider<FavouritesCubit>(
          create: (context) =>
              FavouritesCubit(authProvider: authProvider)..fetchFavourites(),
        ),

        // Specialist cubit
        BlocProvider(
          create: (context) => SpecialistCubit(
            SpecialistRepoImpl(ApiServices(authProvider: authProvider)),
          )..loadSpecialists(),
        ),
      ],
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: LayoutBuilder(
            builder: (context, constraints) {
              // Use SingleChildScrollView to allow small screens to scroll
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 12),

                      HeaderSection(
                        onNotificationTap: () =>
                            context.push(AppRoutes.notification_screen),
                        onFavoritesTap: () =>
                            context.push(AppRoutes.favourites),
                      ),

                      const SizedBox(height: 16),

                      SearchSection(controller: searchController),

                      const SizedBox(height: 24),

                      // Specialties section now reads from SpecialistCubit internally
                      SpecialtiesSection(
                        onTap: (specialtyId) {
                          // Navigate to search with the specialty ID
                          context.push(AppRoutes.search, extra: specialtyId);
                        },
                      ),

                      const SizedBox(height: 24),

                      const BannerSection(),

                      const SizedBox(height: 24),

                      Row(
                        children: [
                          Text(
                            'Doctors near you',
                            style: AppStyle.styleRegular20(context),
                          ),
                          const Spacer(),
                          TextButton(
                            onPressed: () =>
                                context.push(AppRoutes.allDoctorsScreen),
                            child: Text(
                              'View All',
                              style: AppStyle.styleMedium14(context),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 4),

                      // DoctorsNearby remains unchanged and reads its own cubit inside
                      const DoctorsNearby(),

                      // Give extra padding at bottom so floating UI or bottom bars don't overlap
                      SizedBox(height: 24),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
