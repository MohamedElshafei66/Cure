import 'package:flutter/material.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_styles.dart';

class BookingDays extends StatefulWidget {
  final Function(int index, String day, String date) onDaySelected;
  final int initialIndex;

  const BookingDays({
    super.key,
    required this.onDaySelected,
    this.initialIndex = 0,
  });

  @override
  State<BookingDays> createState() => _BookingDaysState();
}

class _BookingDaysState extends State<BookingDays> {
  late int selectedDayIndex;
  late List<String> days;
  late List<String> dates;
  late List<DateTime> dateObjects;

  @override
  void initState() {
    super.initState();
    selectedDayIndex = widget.initialIndex;
    _generateDates();
  }

  void _generateDates() {
    final now = DateTime.now();
    days = [];
    dates = [];
    dateObjects = [];
    
    // Generate 7 days starting from today
    for (int i = 0; i < 7; i++) {
      final date = now.add(Duration(days: i));
      dateObjects.add(date);
      days.add(_getDayAbbreviation(date.weekday));
      dates.add(date.day.toString());
    }
  }

  String _getDayAbbreviation(int weekday) {
    switch (weekday) {
      case 1: return 'Mon';
      case 2: return 'Tue';
      case 3: return 'Wed';
      case 4: return 'Thu';
      case 5: return 'Fri';
      case 6: return 'Sat';
      case 7: return 'Sun';
      default: return 'Mon';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: days.length,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        itemBuilder: (context, index) {
          final bool isSelected = index == selectedDayIndex;
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedDayIndex = index;
              });

              // Format date as YYYY-M-D (e.g., 2024-1-15) - without leading zeros
              final selectedDate = dateObjects[index];
              final formattedDate = '${selectedDate.year}-${selectedDate.month}-${selectedDate.day}';
              
              // 🔥 نبعث اليوم والتاريخ للأب
              widget.onDaySelected(index, days[index], formattedDate);
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : AppColors.lightGrey,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    days[index],
                    style: AppStyle.styleMedium14(context).copyWith(
                      color: isSelected
                          ? AppColors.whiteColor
                          : AppColors.whiteColor79,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    dates[index],
                    style: AppStyle.styleMedium14(context).copyWith(
                      color: isSelected
                          ? AppColors.whiteColor
                          : AppColors.whiteColor79,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
