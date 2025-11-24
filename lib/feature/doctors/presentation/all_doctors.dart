import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:round_7_mobile_cure_team3/core/network/api_services.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_icons.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_styles.dart';
import 'package:round_7_mobile_cure_team3/core/widgets/custom_search_bar.dart';
import 'package:round_7_mobile_cure_team3/feature/doctors/presentation/cubits/doctor_cubit.dart';
import 'package:round_7_mobile_cure_team3/feature/doctors/presentation/cubits/doctor_state.dart';
import 'package:round_7_mobile_cure_team3/feature/favourites/presentation/cubits/favourties_cubit.dart';
import 'package:round_7_mobile_cure_team3/feature/home/data/repositories/specialist_repo_impl.dart';
import 'package:round_7_mobile_cure_team3/feature/home/presentation/cubits/specialists_cubit.dart';
import 'package:round_7_mobile_cure_team3/feature/home/presentation/cubits/specialists_state.dart';
import 'package:round_7_mobile_cure_team3/feature/home/presentation/widgets/doctor_card.dart';
import 'package:round_7_mobile_cure_team3/feature/home/presentation/widgets/specialist_card.dart';
import 'package:round_7_mobile_cure_team3/feature/search/data/models/search_model.dart';
import 'package:round_7_mobile_cure_team3/feature/search/data/repositries/search_repo_impl.dart';
import 'package:round_7_mobile_cure_team3/feature/search/presentation/cubits/search_cubit/search_cubit.dart';
import 'package:round_7_mobile_cure_team3/feature/search/presentation/cubits/search_cubit/search_state.dart';

import '../../../core/constants/auth_provider.dart';

class AllDoctorsScreen extends StatefulWidget {
  const AllDoctorsScreen({super.key});

  @override
  State<AllDoctorsScreen> createState() => _AllDoctorsScreenState();
}

class _AllDoctorsScreenState extends State<AllDoctorsScreen> {
  final TextEditingController searchController = TextEditingController();
  int selectedSpecialtyIndex = 0;
  int? selectedSpecialityId;

  @override
  Widget build(BuildContext context) {
    final authProvider = context.read<AuthProvider>();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            return DoctorCubit(authProvider: authProvider)..fetchAllDoctors();
          },
        ),
        BlocProvider(
          create: (context) {
            return SearchCubit(
              SearchRepoImpl(ApiServices(authProvider: authProvider)),
            );
          },
        ),
        BlocProvider(
          create: (context) {
            return FavouritesCubit(authProvider: authProvider)
              ..fetchFavourites();
          },
        ),
        BlocProvider(
          create: (_) => SpecialistCubit(
            SpecialistRepoImpl(ApiServices(authProvider: authProvider)),
          )..loadSpecialists(),
        ),
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text('Doctors', style: AppStyle.styleRegular20(context)),
          centerTitle: true,
          leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: Image.asset(AppIcons.arrowBackPng),
          ),
        ),
        body: BlocBuilder<SearchCubit, SearchState>(
          builder: (context, state) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomSearchBar(
                    controller: searchController,
                    showIcons: state is! SearchInitial,
                    onSubmitted: (value) {
                      final searchModel = SearchModel(
                        keyword: value.trim(),
                        specialityId: selectedSpecialityId,
                      );
                      context.read<SearchCubit>().searchDoctors(searchModel);
                    },
                    onReset: () {
                      searchController.clear();
                      setState(() {
                        selectedSpecialtyIndex = 0;
                        selectedSpecialityId = null;
                      });
                      context.read<SearchCubit>().reset();
                    },
                  ),
                  const SizedBox(height: 12),
                  BlocBuilder<SpecialistCubit, SpecialistState>(
                    builder: (context, specialistState) {
                      if (specialistState is SpecialistLoading) {
                        return const SizedBox(
                          height: 40,
                          child: Center(
                            child: SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          ),
                        );
                      }
                      if (specialistState is SpecialistError) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            specialistState.message,
                            style: AppStyle.styleMedium14(context),
                          ),
                        );
                      }
                      if (specialistState is SpecialistLoaded) {
                        final specialists = specialistState.specialists;
                        if (specialists.isEmpty) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              'No specialties found',
                              style: AppStyle.styleMedium14(context),
                            ),
                          );
                        }
                        return SizedBox(
                          height: 48,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: specialists.length + 1,
                            separatorBuilder: (_, __) =>
                                const SizedBox(width: 4),
                            itemBuilder: (context, index) {
                              if (index == 0) {
                                return SpecialistCard(
                                  text: 'All',
                                  emoji: '✨',
                                  selected: selectedSpecialtyIndex == 0,
                                  onTap: () {
                                    setState(() {
                                      selectedSpecialtyIndex = 0;
                                      selectedSpecialityId = null;
                                    });
                                    context.read<SearchCubit>().reset();
                                  },
                                );
                              }
                              final specialist = specialists[index - 1];
                              return SpecialistCard(
                                text: specialist.title,
                                emoji: specialist.emoji,
                                selected: selectedSpecialtyIndex == index,
                                onTap: () {
                                  final bool isSameSelection =
                                      selectedSpecialtyIndex == index;
                                  final int nextIndex = isSameSelection
                                      ? 0
                                      : index;
                                  final int? nextSpecialityId = isSameSelection
                                      ? null
                                      : specialist.id;

                                  setState(() {
                                    selectedSpecialtyIndex = nextIndex;
                                    selectedSpecialityId = nextSpecialityId;
                                  });

                                  if (nextIndex == 0) {
                                    context.read<SearchCubit>().reset();
                                    return;
                                  }

                                  final keyword = searchController.text.trim();
                                  context.read<SearchCubit>().searchDoctors(
                                    SearchModel(
                                      keyword: keyword,
                                      specialityId: nextSpecialityId,
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildDoctorsSection(context, state),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildDoctorsSection(BuildContext context, SearchState state) {
    if (state is SearchLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is SearchLoaded) {
      return Column(
        children: state.doctors.map((doc) => DoctorCard(doctor: doc)).toList(),
      );
    } else if (state is SearchEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Text(
            'No doctors found.',
            style: AppStyle.styleMedium16(context),
          ),
        ),
      );
    } else if (state is SearchFailed) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Text(state.message, style: AppStyle.styleMedium16(context)),
        ),
      );
    }

    return BlocBuilder<DoctorCubit, DoctorState>(
      builder: (context, doctorState) {
        if (doctorState is DoctorLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (doctorState is DoctorLoaded) {
          return Column(
            children: doctorState.doctors
                .map((doc) => DoctorCard(doctor: doc))
                .toList(),
          );
        } else if (doctorState is DoctorError) {
          return Center(child: Text(doctorState.message));
        }
        return const SizedBox();
      },
    );
  }
}
