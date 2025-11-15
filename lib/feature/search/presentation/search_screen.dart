import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:round_7_mobile_cure_team3/core/constants/secure_storage_data.dart';
import 'package:round_7_mobile_cure_team3/core/network/api_services.dart';
import 'package:round_7_mobile_cure_team3/core/routes/app_routes.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_icons.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_styles.dart';
import 'package:round_7_mobile_cure_team3/core/widgets/custom_search_bar.dart';
import 'package:round_7_mobile_cure_team3/feature/favourites/presentation/cubits/favourties_cubit.dart';
import 'package:round_7_mobile_cure_team3/feature/search/data/models/search_model.dart';
import 'package:round_7_mobile_cure_team3/feature/search/data/repositries/search_repo_impl.dart';
import 'package:round_7_mobile_cure_team3/feature/search/presentation/cubits/search_cubit/search_cubit.dart';
import 'package:round_7_mobile_cure_team3/feature/search/presentation/cubits/search_cubit/search_state.dart';
import 'package:round_7_mobile_cure_team3/feature/search/presentation/widgets/history_section.dart';
import 'package:round_7_mobile_cure_team3/feature/search/presentation/widgets/location_row.dart';
import 'package:round_7_mobile_cure_team3/feature/search/presentation/widgets/search_results_list.dart';
import 'package:round_7_mobile_cure_team3/feature/search/presentation/widgets/specialties_section.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();
  int? selectedIndexSpecialist;
  int? selectedIndexHistory;

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  final List<Map<String, dynamic>> specialties = [
    {'image': AppIcons.cardiologist, 'text': 'Cardiologist', 'id': 1},
    {'image': AppIcons.generalPractitioner, 'text': 'Dermatology', 'id': 2},
    {'image': AppIcons.dentist, 'text': 'Dentist', 'id': null},
    {'image': AppIcons.ent, 'text': 'ENT', 'id': null},
    {'image': AppIcons.neurologist, 'text': 'Neurologist', 'id': null},
    {
      'image': AppIcons.generalPractitioner,
      'text': 'General Practitioner',
      'id': null,
    },
    {'image': AppIcons.ophthalmologist, 'text': 'Ophthalmologist', 'id': null},
    {'image': AppIcons.pulmonologist, 'text': 'Pulmonologist', 'id': null},
    {'image': AppIcons.orthopedic, 'text': 'Orthopedic', 'id': null},
    {
      'image': AppIcons.gastroenterologist,
      'text': 'Gastroenterologist',
      'id': null,
    },
    {'image': AppIcons.oncologist, 'text': 'Oncologist', 'id': null},
    {'image': AppIcons.endocrinologist, 'text': 'Endocrinologist', 'id': null},
    {'image': AppIcons.psychiatrist, 'text': 'Psychiatrist', 'id': null},
  ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
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
          )..fetchHistory(),
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
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text('Search', style: AppStyle.styleRegular20(context)),
          centerTitle: true,
          leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: Image.asset(AppIcons.arrowBackPng),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<SearchCubit, SearchState>(
                builder: (context, state) {
                  return CustomSearchBar(
                    controller: searchController,
                    showIcons: state is! SearchInitial,
                    onSubmitted: (value) {
                      if (value.trim().isNotEmpty) {
                        final searchModel = SearchModel(keyword: value.trim());
                        context.read<SearchCubit>().searchDoctors(searchModel);
                      }
                    },
                    onReset: () {
                      setState(() {
                        selectedIndexSpecialist = null;
                        selectedIndexHistory = null;
                      });
                      searchController.clear();
                      context.read<SearchCubit>().reset();
                      context.read<SearchCubit>().fetchHistory();
                    },
                  );
                },
              ),
              const SizedBox(height: 16),
              Builder(
                builder: (builderContext) {
                  return LocationRow(
                    onLocationPressed: () async {
                      // Get cubit reference before navigation to avoid context issues
                      final searchCubit = builderContext.read<SearchCubit>();
                      final result = await builderContext.push(AppRoutes.map);
                      if (mounted && result is Position) {
                        searchCubit.searchWithLocation(result);
                      }
                    },
                  );
                },
              ),
              const SizedBox(height: 16),
              BlocBuilder<SearchCubit, SearchState>(
                builder: (context, state) {
                  if (state is SearchInitial || state is SearchHistoryLoaded) {
                    return _buildDefaultSection(context, state);
                  } else if (state is SearchLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is SearchLoaded) {
                    return SearchResultsList(results: state.doctors);
                  } else if (state is SearchEmpty) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Text(
                          'No results found.',
                          style: AppStyle.styleMedium16(context),
                        ),
                      ),
                    );
                  } else if (state is SearchFailed) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Text(
                          state.message,
                          style: AppStyle.styleMedium16(context),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDefaultSection(BuildContext context, SearchState state) {
    List<Map<String, dynamic>> historyList = [];

    if (state is SearchHistoryLoaded) {
      historyList = state.history
          .map((item) => {'text': item.keyword})
          .toList();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SpecialtiesSection(
          specialties: specialties,
          selectedIndex: selectedIndexSpecialist,
          onSelect: (index) {
            setState(() {
              selectedIndexSpecialist = selectedIndexSpecialist == index
                  ? null
                  : index;
            });
            if (selectedIndexSpecialist != null) {
              final specialty = specialties[selectedIndexSpecialist!];
              final searchModel = SearchModel(
                keyword: specialty['id'] != null
                    ? ''
                    : specialty['text'] as String,
                specialityId: specialty['id'] as int?,
              );
              context.read<SearchCubit>().searchDoctors(searchModel);
            }
          },
        ),
        const SizedBox(height: 16),
        HistorySection(
          history: historyList,
          selectedIndex: selectedIndexHistory,
          onSelect: (index) {
            setState(() {
              selectedIndexHistory = selectedIndexHistory == index
                  ? null
                  : index;
            });
            if (selectedIndexHistory != null) {
              final historyText = historyList[selectedIndexHistory!]['text'];
              searchController.text = historyText;
              context.read<SearchCubit>().searchDoctors(
                SearchModel(keyword: historyText),
              );
            }
          },
        ),
      ],
    );
  }
}
