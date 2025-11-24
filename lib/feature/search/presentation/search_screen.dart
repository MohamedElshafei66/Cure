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
import 'package:skeletonizer/skeletonizer.dart';

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
                  final loading = state is SearchLoading;

                  return Skeletonizer(
                    enableSwitchAnimation: true,
                    enabled: loading,
                    child: Builder(
                      builder: (context) {
                        if (state is SearchInitial ||
                            state is SearchHistoryLoaded) {
                          return _buildDefaultView(context, state);
                        }

                        if (loading) {
                          return Column(
                            children: List.generate(
                              3,
                              (index) => Container(
                                margin: const EdgeInsets.only(top: 16),
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(
                                    color: Colors.grey.shade300,
                                    width: 1.4,
                                  ),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Skeleton Image
                                    Container(
                                      width: 82,
                                      height: 82,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade300,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    const SizedBox(width: 10),

                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: double.infinity,
                                            height: 16,
                                            decoration: BoxDecoration(
                                              color: Colors.grey.shade300,
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Container(
                                            width: 120,
                                            height: 14,
                                            decoration: BoxDecoration(
                                              color: Colors.grey.shade300,
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Container(
                                            width: 100,
                                            height: 12,
                                            decoration: BoxDecoration(
                                              color: Colors.grey.shade300,
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Row(
                                            children: [
                                              Container(
                                                width: 60,
                                                height: 12,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey.shade300,
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                ),
                                              ),
                                              const Spacer(),
                                              Container(
                                                width: 50,
                                                height: 14,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey.shade300,
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 10),

                                    // Skeleton Heart Icon
                                    Container(
                                      width: 24,
                                      height: 24,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade300,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
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
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.search_off_rounded,
                                    size: 64,
                                    color: Colors.grey.shade400,
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    'No doctors found',
                                    style: AppStyle.styleMedium20(context),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Try adjusting your search criteria or browse by specialty.',
                                    style: AppStyle.styleRegular14(
                                      context,
                                    ).copyWith(color: Colors.grey),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          );
                        }

                        if (state is SearchFailed) {
                          final errorMessage = state.message.toLowerCase();
                          final is404Error =
                              errorMessage.contains('404') ||
                              errorMessage.contains('not found') ||
                              errorMessage.contains('no doctors');

                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.all(32.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    is404Error
                                        ? Icons.search_off
                                        : Icons.error_outline,
                                    size: 64,
                                    color: Colors.grey.shade400,
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    is404Error
                                        ? 'No doctors found'
                                        : 'Something went wrong',
                                    style: AppStyle.styleMedium20(context),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    is404Error
                                        ? 'Try adjusting your search criteria or search by a different specialty.'
                                        : 'Please try again later.',
                                    style: AppStyle.styleRegular14(
                                      context,
                                    ).copyWith(color: Colors.grey),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          );
                        }

                        return const SizedBox.shrink();
                      },
                    ),
                  );
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
