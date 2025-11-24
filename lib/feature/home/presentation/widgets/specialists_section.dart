import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_styles.dart';
import 'package:round_7_mobile_cure_team3/feature/home/presentation/cubits/specialists_cubit.dart';
import 'package:round_7_mobile_cure_team3/feature/home/presentation/cubits/specialists_state.dart';
import 'package:round_7_mobile_cure_team3/feature/home/presentation/widgets/specialist_card.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SpecialtiesSection extends StatelessWidget {
  final Function(int specialtyId) onTap;

  const SpecialtiesSection({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text('Specialties', style: AppStyle.styleRegular20(context)),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 60,
          child: BlocBuilder<SpecialistCubit, SpecialistState>(
            builder: (context, state) {
              final bool loading =
                  state is SpecialistLoading || state is SpecialistInitial;
              if (loading) {
                return Skeletonizer(
                  enableSwitchAnimation: true,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 8,
                    itemBuilder: (_, __) {
                      return Container(
                        width: 90,
                        margin: const EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(12),
                        ),
                      );
                    },
                  ),
                );
              }

              if (state is SpecialistError) {
                return Center(child: Text(state.message));
              }

              if (state is SpecialistLoaded) {
                final specialists = state.specialists;

                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: specialists.length,
                  itemBuilder: (_, index) {
                    final s = specialists[index]; // NOW VALID
                    return SpecialistCard(
                      text: s.title,
                      emoji: s.emoji,
                      selected: false,
                      onTap: () => onTap(s.id),
                    );
                  },
                );
              }

              return const SizedBox();
            },
          ),
        ),
      ],
    );
  }
}
