import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:round_7_mobile_cure_team3/core/constants/auth_provider.dart';
import 'package:round_7_mobile_cure_team3/core/network/api_services.dart';
import 'package:round_7_mobile_cure_team3/core/routes/app_routes.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_icons.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_styles.dart';
import 'package:round_7_mobile_cure_team3/core/widgets/custom_search_bar.dart';
import 'package:round_7_mobile_cure_team3/feature/favourites/presentation/cubits/favourties_cubit.dart';
import 'package:round_7_mobile_cure_team3/feature/home/data/repositories/specialist_repo_impl.dart';
import 'package:round_7_mobile_cure_team3/feature/home/presentation/cubits/specialists_cubit.dart';
import 'package:round_7_mobile_cure_team3/feature/home/presentation/cubits/specialists_state.dart';
import 'package:round_7_mobile_cure_team3/feature/search/data/models/search_model.dart';
import 'package:round_7_mobile_cure_team3/feature/search/data/repositries/search_repo_impl.dart';
import 'package:round_7_mobile_cure_team3/feature/search/presentation/cubits/search_cubit/search_cubit.dart';
import 'package:round_7_mobile_cure_team3/feature/search/presentation/cubits/search_cubit/search_state.dart';
import 'package:round_7_mobile_cure_team3/feature/search/presentation/widgets/history_section.dart';
import 'package:round_7_mobile_cure_team3/feature/search/presentation/widgets/location_row.dart';
import 'package:round_7_mobile_cure_team3/feature/search/presentation/widgets/search_results_list.dart';
import 'package:round_7_mobile_cure_team3/feature/search/presentation/widgets/specialties_section.dart';

class SearchScreen extends StatefulWidget {
  final int? preselectedSpecialtyId;

  const SearchScreen({super.key, this.preselectedSpecialtyId});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();
  int? selectedIndexSpecialist;
  int? selectedIndexHistory;
  bool _hasAppliedPreselection = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => SearchCubit(
            SearchRepoImpl(
              ApiServices(authProvider: context.read<AuthProvider>()),
            ),
          )..fetchHistory(),
        ),
        BlocProvider(
          create: (context) => SpecialistCubit(
            SpecialistRepoImpl(
              ApiServices(authProvider: context.read<AuthProvider>()),
            ),
          )..loadSpecialists(),
        ),
        BlocProvider(
          create: (context) =>
              FavouritesCubit(authProvider: context.read<AuthProvider>())
                ..fetchFavourites(),
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
        BlocBuilder<SpecialistCubit, SpecialistState>(
          builder: (context, specialistState) {
            if (specialistState is SpecialistLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (specialistState is SpecialistError) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Text(
                  specialistState.message,
                  style: AppStyle.styleMedium16(context),
                ),
              );
            }
            if (specialistState is SpecialistLoaded) {
              final specialists = specialistState.specialists;

              // Apply preselection once when specialists are loaded
              if (widget.preselectedSpecialtyId != null &&
                  !_hasAppliedPreselection) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (!mounted) return;

                  final index = specialists.indexWhere(
                    (s) => s.id == widget.preselectedSpecialtyId,
                  );

                  if (index != -1) {
                    setState(() {
                      selectedIndexSpecialist = index;
                      _hasAppliedPreselection = true;
                    });

                    final specialist = specialists[index];
                    context.read<SearchCubit>().searchDoctors(
                      SearchModel(keyword: '', specialityId: specialist.id),
                    );
                  }
                });
              }

              return SpecialtiesSection(
                specialists: specialists,
                selectedIndex: selectedIndexSpecialist,
                onSelect: (index) {
                  setState(() {
                    selectedIndexSpecialist = selectedIndexSpecialist == index
                        ? null
                        : index;
                  });
                  if (selectedIndexSpecialist != null) {
                    final specialist = specialists[selectedIndexSpecialist!];
                    context.read<SearchCubit>().searchDoctors(
                      SearchModel(keyword: '', specialityId: specialist.id),
                    );
                  } else {
                    context.read<SearchCubit>().reset();
                    context.read<SearchCubit>().fetchHistory();
                  }
                },
              );
            }
            return const SizedBox();
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
