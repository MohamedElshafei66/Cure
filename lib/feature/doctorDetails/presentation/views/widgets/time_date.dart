import 'package:flutter/material.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_styles.dart';
class TimeDate extends StatefulWidget {
  const TimeDate({super.key});
  @override
  State<TimeDate> createState() => _TimeDateState();
}

class _TimeDateState extends State<TimeDate> {
  final List<String> times = [
    "9:00 AM",
    "10:00 AM",
    "11:00 AM",
    "12:30 AM",
    "4:00 PM",
    "5:30 PM",
    "7:00 PM",
    "9:00 PM",
    "10:00 PM",
  ];
  String? selectedTime;
  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Wrap(
          spacing: 24,
          runSpacing: 12,
          children: times.map((time) {
        final bool isSelected = time == selectedTime;
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedTime = time;
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.primary
                  : AppColors.lightGrey,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              time,
              style: AppStyle.styleMedium14(context).copyWith(
                color: isSelected ? Colors.white : Colors.black54,
              ),
            ),
          ),
        );
      }).toList()
      ),
    );
  }
}

