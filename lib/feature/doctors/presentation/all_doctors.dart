import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:round_7_mobile_cure_team3/core/constants/auth_provider.dart';
import 'package:round_7_mobile_cure_team3/core/network/api_services.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_icons.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_styles.dart';
import 'package:round_7_mobile_cure_team3/core/widgets/custom_search_bar.dart';
import 'package:round_7_mobile_cure_team3/feature/doctors/presentation/cubits/doctor_cubit.dart';
import 'package:round_7_mobile_cure_team3/feature/doctors/presentation/widgets/doctors_list_section.dart';
import 'package:round_7_mobile_cure_team3/feature/doctors/presentation/widgets/specialty_filter_row.dart';
import 'package:round_7_mobile_cure_team3/feature/home/data/repositories/specialist_repo_impl.dart';
import 'package:round_7_mobile_cure_team3/feature/home/presentation/cubits/specialists_cubit.dart';
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
  int selectedSpecialtyIndex = 0;
  int? selectedSpecialityId;

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.read<AuthProvider>();

    return MultiBlocProvider(
      providers: [
        BlocProvider<DoctorCubit>(
          create: (_) =>
              DoctorCubit(authProvider: authProvider)..fetchAllDoctors(),
        ),
        BlocProvider<SearchCubit>(
          create: (_) => SearchCubit(
            SearchRepoImpl(ApiServices(authProvider: authProvider)),
          ),
        ),
        BlocProvider<SpecialistCubit>(
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
                  SpecialtyFilterRow(
                    selectedSpecialtyIndex: selectedSpecialtyIndex,
                    selectedSpecialityId: selectedSpecialityId,
                    onSpecialtySelected: (index, specialtyId) {
                      setState(() {
                        selectedSpecialtyIndex = index;
                        selectedSpecialityId = specialtyId;
                      });

                      // If not "All", trigger search with specialty
                      if (index != 0 && specialtyId != null) {
                        final keyword = searchController.text.trim();
                        context.read<SearchCubit>().searchDoctors(
                          SearchModel(
                            keyword: keyword,
                            specialityId: specialtyId,
                          ),
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  DoctorsListSection(searchState: state),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
