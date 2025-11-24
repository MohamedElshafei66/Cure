import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:round_7_mobile_cure_team3/core/constants/auth_provider.dart';
import 'package:round_7_mobile_cure_team3/core/network/api_services.dart';
import 'package:round_7_mobile_cure_team3/core/routes/app_routes.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_styles.dart';
import 'package:round_7_mobile_cure_team3/core/widgets/custom_search_bar.dart';
import 'package:round_7_mobile_cure_team3/feature/home/data/repositories/specialist_repo_impl.dart';
import 'package:round_7_mobile_cure_team3/feature/home/presentation/cubits/specialists_cubit.dart';
import 'package:round_7_mobile_cure_team3/feature/search/data/models/search_model.dart';
import 'package:round_7_mobile_cure_team3/feature/search/data/repositries/search_repo_impl.dart';
import 'package:round_7_mobile_cure_team3/feature/search/presentation/cubits/search_cubit/search_cubit.dart';
import 'package:round_7_mobile_cure_team3/feature/search/presentation/cubits/search_cubit/search_state.dart';
import 'package:round_7_mobile_cure_team3/feature/search/presentation/widgets/location_row.dart';
import 'package:round_7_mobile_cure_team3/feature/search/presentation/widgets/search_app_bar.dart';
import 'package:round_7_mobile_cure_team3/feature/search/presentation/widgets/search_default_view.dart';
import 'package:round_7_mobile_cure_team3/feature/search/presentation/widgets/search_results_list.dart';

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
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const SearchAppBar(),
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
              LocationRow(
                onLocationPressed: () async {
                  final searchCubit = context.read<SearchCubit>();
                  final result = await context.push(AppRoutes.map);
                  if (mounted && result is Position) {
                    searchCubit.searchWithLocation(result);
                  }
                },
              ),
              const SizedBox(height: 16),
              BlocBuilder<SearchCubit, SearchState>(
                builder: (context, state) {
                  if (state is SearchInitial || state is SearchHistoryLoaded) {
                    return _buildDefaultView(context, state);
                  }

                  if (state is SearchLoading) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(32.0),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  if (state is SearchLoaded) {
                    return SearchResultsList(results: state.doctors);
                  }

                  if (state is SearchEmpty) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Text(
                          'No results found.',
                          style: AppStyle.styleMedium16(context),
                        ),
                      ),
                    );
                  }

                  if (state is SearchFailed) {
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

                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDefaultView(BuildContext context, SearchState state) {
    List<Map<String, dynamic>> historyList = [];

    if (state is SearchHistoryLoaded) {
      historyList = state.history
          .map((item) => {'text': item.keyword})
          .toList();
    }

    return SearchDefaultView(
      historyList: historyList,
      selectedIndexSpecialist: selectedIndexSpecialist,
      selectedIndexHistory: selectedIndexHistory,
      preselectedSpecialtyId: widget.preselectedSpecialtyId,
      hasAppliedPreselection: _hasAppliedPreselection,
      searchController: searchController,
      onSpecialtySelected: (index) {
        setState(() => selectedIndexSpecialist = index);
      },
      onHistorySelected: (index) {
        setState(() => selectedIndexHistory = index);
      },
      onPreselectionApplied: () {
        setState(() => _hasAppliedPreselection = true);
      },
    );
  }
}
