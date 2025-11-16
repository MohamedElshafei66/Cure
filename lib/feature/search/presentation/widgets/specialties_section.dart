import 'package:flutter/material.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_styles.dart';
import 'package:round_7_mobile_cure_team3/feature/home/presentation/widgets/specialist_card.dart';

class SpecialtiesSection extends StatelessWidget {
  final List<Map<String, dynamic>> specialties;
  final int? selectedIndex;
  final Function(int) onSelect;

  const SpecialtiesSection({
    super.key,
    required this.specialties,
    required this.selectedIndex,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('All Specialties', style: AppStyle.styleRegular20(context)),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 12,
          children: specialties.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;

            return SpecialistCard(
              image: item['image'],
              text: item['text'],
              selected: selectedIndex == index,
              onTap: () => onSelect(index),
            );
          }).toList(),
        ),
      ],
    );
  }
}
