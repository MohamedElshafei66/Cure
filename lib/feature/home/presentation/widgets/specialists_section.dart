import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_styles.dart';
import 'package:round_7_mobile_cure_team3/feature/home/presentation/cubits/specialists_cubit.dart';
import 'package:round_7_mobile_cure_team3/feature/home/presentation/cubits/specialists_state.dart';
import 'package:round_7_mobile_cure_team3/feature/home/presentation/widgets/specialist_card.dart';

class SpecialtiesSection extends StatelessWidget {
  final Function(int specialtyId) onTap;

  const SpecialtiesSection({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text('Specialties', style: AppStyle.styleRegular20(context)),
            const Spacer(),
            TextButton(
              onPressed: () {},
              child: Text('View All', style: AppStyle.styleMedium14(context)),
            ),
          ],
        ),

        const SizedBox(height: 16),

        SizedBox(
          height: 60,
          child: BlocBuilder<SpecialistCubit, SpecialistState>(
            builder: (context, state) {
              if (state is SpecialistLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is SpecialistError) {
                return Center(child: Text(state.message));
              }

              if (state is SpecialistLoaded) {
                final items = state.specialists;

                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final s = items[index];
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
