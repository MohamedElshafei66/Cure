import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:round_7_mobile_cure_team3/core/constants/secure_storage_data.dart';
import 'package:round_7_mobile_cure_team3/core/network/api_services.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_icons.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_styles.dart';
import 'package:round_7_mobile_cure_team3/core/widgets/custom_search_bar.dart';
import 'package:round_7_mobile_cure_team3/feature/doctors/presentation/cubits/doctor_cubit.dart';
import 'package:round_7_mobile_cure_team3/feature/doctors/presentation/cubits/doctor_state.dart';
import 'package:round_7_mobile_cure_team3/feature/favourites/presentation/cubits/favourties_cubit.dart';
import 'package:round_7_mobile_cure_team3/feature/home/presentation/widgets/doctor_card.dart';
import 'package:round_7_mobile_cure_team3/feature/home/presentation/widgets/specialist_card.dart';
import 'package:round_7_mobile_cure_team3/feature/search/data/models/search_model.dart';
import 'package:round_7_mobile_cure_team3/feature/search/data/repositries/search_repo_impl.dart';
import 'package:round_7_mobile_cure_team3/feature/search/presentation/cubits/search_cubit/search_cubit.dart';
import 'package:round_7_mobile_cure_team3/feature/search/presentation/cubits/search_cubit/search_state.dart';

class AllDoctorsScreen extends StatefulWidget {
  const AllDoctorsScreen({super.key});

  @override
  State<AllDoctorsScreen> createState() => _AllDoctorsScreenState();
}

class _AllDoctorsScreenState extends State<AllDoctorsScreen> {
  final TextEditingController searchController = TextEditingController();
  int? selectedSpecialtyIndex = 0;

  final List<Map<String, dynamic>> specialties = [
    {'image': null, 'text': 'All', 'id': null},
    {'image': AppIcons.generalPractitioner, 'text': 'Dermatology', 'id': 2},
    {'image': AppIcons.dentist, 'text': 'Dentist', 'id': 11},
    {'image': AppIcons.cardiologist, 'text': 'Cardiologist', 'id': 1},
    {'image': AppIcons.psychiatrist, 'text': 'Psychiatrist', 'id': 6},
    {'image': AppIcons.ent, 'text': 'ENT', 'id': 3},
    {'image': AppIcons.ophthalmologist, 'text': 'Ophthalmologist', 'id': 4},
    {'image': AppIcons.neurologist, 'text': 'Neurologist', 'id': 5},
    {'image': AppIcons.endocrinologist, 'text': 'Endocrinologist', 'id': 9},
    {'image': AppIcons.oncologist, 'text': 'Oncologist', 'id': 7},
    {'image': AppIcons.pulmonologist, 'text': 'Pulmonologist', 'id': 8},

    {'image': AppIcons.orthopedic, 'text': 'Orthopedic', 'id': 10},
    {
      'image': AppIcons.gastroenterologist,
      'text': 'Gastroenterologist',
      'id': 11,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => DoctorCubit(
            secureStorage: Provider.of<SecureStorageService>(
              context,
              listen: false,
            ),
          )..fetchAllDoctors(),
        ),
        BlocProvider(
          create: (context) => SearchCubit(
            SearchRepoImpl(
              ApiServices(
                secureStorage: Provider.of<SecureStorageService>(
                  context,
                  listen: false,
                ),
              ),
            ),
          )..searchDoctors(SearchModel(keyword: '', specialityId: null)),
        ),
        BlocProvider(
          create: (context) => FavouritesCubit(
            secureStorage: Provider.of<SecureStorageService>(
              context,
              listen: false,
            ),
          ),
        ),
      ],
      child: Builder(
        builder: (context) => Scaffold(
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
                          specialityId: _getSelectedSpecialtyId(),
                        );
                        context.read<SearchCubit>().searchDoctors(searchModel);
                      },
                      onReset: () {
                        searchController.clear();
                        setState(() => selectedSpecialtyIndex = 0);
                        context.read<SearchCubit>().reset();
                      },
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 40,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: specialties.length,
                        itemBuilder: (context, index) {
                          final item = specialties[index];
                          return SpecialistCard(
                            image: item['image'],
                            text: item['text'],
                            selected: selectedSpecialtyIndex == index,
                            onTap: () {
                              setState(() {
                                selectedSpecialtyIndex =
                                    selectedSpecialtyIndex == index ? 0 : index;
                              });

                              final selected =
                                  specialties[selectedSpecialtyIndex ?? 0];
                              context.read<SearchCubit>().searchDoctors(
                                SearchModel(
                                  keyword: searchController.text.trim(),
                                  specialityId: selected['id'] as int?,
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildDoctorsSection(context, state),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  int? _getSelectedSpecialtyId() {
    final specialty = specialties[selectedSpecialtyIndex ?? 0];
    return specialty['id'] as int?;
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
