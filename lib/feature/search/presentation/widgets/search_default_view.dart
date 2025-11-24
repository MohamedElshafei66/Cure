import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_styles.dart';
import 'package:round_7_mobile_cure_team3/feature/home/presentation/cubits/specialists_cubit.dart';
import 'package:round_7_mobile_cure_team3/feature/home/presentation/cubits/specialists_state.dart';
import 'package:round_7_mobile_cure_team3/feature/search/data/models/search_model.dart';
import 'package:round_7_mobile_cure_team3/feature/search/presentation/cubits/search_cubit/search_cubit.dart';
import 'package:round_7_mobile_cure_team3/feature/search/presentation/widgets/history_section.dart';
import 'package:round_7_mobile_cure_team3/feature/search/presentation/widgets/specialties_section.dart';

class SearchDefaultView extends StatelessWidget {
  final List<Map<String, dynamic>> historyList;
  final int? selectedIndexSpecialist;
  final int? selectedIndexHistory;
  final int? preselectedSpecialtyId;
  final bool hasAppliedPreselection;
  final TextEditingController searchController;
  final Function(int?) onSpecialtySelected;
  final Function(int?) onHistorySelected;
  final Function() onPreselectionApplied;

  const SearchDefaultView({
    super.key,
    required this.historyList,
    required this.selectedIndexSpecialist,
    required this.selectedIndexHistory,
    required this.preselectedSpecialtyId,
    required this.hasAppliedPreselection,
    required this.searchController,
    required this.onSpecialtySelected,
    required this.onHistorySelected,
    required this.onPreselectionApplied,
  });

  @override
  Widget build(BuildContext context) {
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

              // Apply preselection once when specialists load and navigate from home
              if (preselectedSpecialtyId != null && !hasAppliedPreselection) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (!context.mounted) return;

                  final index = specialists.indexWhere(
                    (s) => s.id == preselectedSpecialtyId,
                  );

                  if (index != -1) {
                    onPreselectionApplied();
                    onSpecialtySelected(index);

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
                  final newIndex =
                      selectedIndexSpecialist == index ? null : index;
                  onSpecialtySelected(newIndex);

                  if (newIndex != null) {
                    final specialist = specialists[newIndex];
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
            final newIndex = selectedIndexHistory == index ? null : index;
            onHistorySelected(newIndex);

            if (newIndex != null) {
              final historyText = historyList[newIndex]['text'];
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

