import 'package:flutter/material.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_styles.dart';

class BookingDays extends StatefulWidget {
  final Function(int index, String day) onDaySelected;
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
  final List<String> days = ['Thu', 'Fri', 'Sat', 'Sun', 'Mon', 'Tue', 'Wed'];
  final List<String> dates = ['11', '12', '13', '14', '15', '16', '17'];

  @override
  void initState() {
    super.initState();
    selectedDayIndex = widget.initialIndex;
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

              // 🔥 نبعث اليوم للأب
              widget.onDaySelected(index, days[index]);
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
