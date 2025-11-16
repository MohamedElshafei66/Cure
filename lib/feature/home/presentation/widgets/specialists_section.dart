import 'package:flutter/material.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_styles.dart';
import 'package:round_7_mobile_cure_team3/feature/home/presentation/widgets/specialist_card.dart';

class SpecialtiesSection extends StatelessWidget {
  final List<Map<String, dynamic>> specialties;
  final int selectedIndex;
  final Function(int) onTap;

  const SpecialtiesSection({
    super.key,
    required this.specialties,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
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
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: specialties.length,
              itemBuilder: (context, index) {
                final item = specialties[index];
                return SpecialistCard(
                  image: item['image'],
                  text: item['text'],
                  selected: selectedIndex == index,
                  onTap: () => onTap(index),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
