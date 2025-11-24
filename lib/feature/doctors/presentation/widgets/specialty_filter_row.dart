import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_styles.dart';
import 'package:round_7_mobile_cure_team3/feature/home/data/models/specialist_model.dart';
import 'package:round_7_mobile_cure_team3/feature/home/presentation/cubits/specialists_cubit.dart';
import 'package:round_7_mobile_cure_team3/feature/home/presentation/cubits/specialists_state.dart';
import 'package:round_7_mobile_cure_team3/feature/home/presentation/widgets/specialist_card.dart';
import 'package:round_7_mobile_cure_team3/feature/search/data/models/search_model.dart';
import 'package:round_7_mobile_cure_team3/feature/search/presentation/cubits/search_cubit/search_cubit.dart';

class SpecialtyFilterRow extends StatelessWidget {
  final int selectedSpecialtyIndex;
  final int? selectedSpecialityId;
  final Function(int index, int? specialtyId) onSpecialtySelected;

  const SpecialtyFilterRow({
    super.key,
    required this.selectedSpecialtyIndex,
    required this.selectedSpecialityId,
    required this.onSpecialtySelected,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SpecialistCubit, SpecialistState>(
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
              separatorBuilder: (_, __) => const SizedBox(width: 4),
              itemBuilder: (context, index) {
                if (index == 0) {
                  return SpecialistCard(
                    text: 'All',
                    emoji: '✨',
                    selected: selectedSpecialtyIndex == 0,
                    onTap: () {
                      onSpecialtySelected(0, null);
                      context.read<SearchCubit>().reset();
                    },
                  );
                }

                final specialist = specialists[index - 1];
                return SpecialistCard(
                  text: specialist.title,
                  emoji: specialist.emoji,
                  selected: selectedSpecialtyIndex == index,
                  onTap: () => _handleSpecialtyTap(
                    context,
                    specialist,
                    index,
                  ),
                );
              },
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  void _handleSpecialtyTap(
    BuildContext context,
    SpecialistModel specialist,
    int index,
  ) {
    final bool isSameSelection = selectedSpecialtyIndex == index;
    final int nextIndex = isSameSelection ? 0 : index;
    final int? nextSpecialityId = isSameSelection ? null : specialist.id;

    onSpecialtySelected(nextIndex, nextSpecialityId);

    if (nextIndex == 0) {
      context.read<SearchCubit>().reset();
      return;
    }

    context.read<SearchCubit>().searchDoctors(
          SearchModel(
            keyword: '',
            specialityId: nextSpecialityId,
          ),
        );
  }
}

