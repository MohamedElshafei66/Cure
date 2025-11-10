import 'package:flutter/material.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_colors.dart';

class BirthdayPicker extends StatelessWidget {
  final int selectedDay;
  final String selectedMonth;
  final int selectedYear;

  final List<int> days;
  final List<String> months;
  final List<int> years;

  final ValueChanged<int?> onDayChanged;
  final ValueChanged<String?> onMonthChanged;
  final ValueChanged<int?> onYearChanged;

  BirthdayPicker({
    required this.selectedDay,
    required this.selectedMonth,
    required this.selectedYear,
    required this.days,
    required this.months,
    required this.years,
    required this.onDayChanged,
    required this.onMonthChanged,
    required this.onYearChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: DropdownButtonFormField<int>(
            value: selectedDay,
            isDense: true,
            items: days
                .map(
                  (day) =>
                      DropdownMenuItem(value: day, child: Text(day.toString())),
                )
                .toList(),
            onChanged: onDayChanged,
            decoration: decoration(),
          ),
        ),
        const SizedBox(width: 8),

        Expanded(
          child: DropdownButtonFormField<String>(
            value: selectedMonth,
            isDense: true,
            items: months
                .map(
                  (month) => DropdownMenuItem(
                    value: month,
                    child: Container(
                      width: 50,
                      child: Text(
                        month,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 13),
                      ),
                    ),
                  ),
                )
                .toList(),
            onChanged: onMonthChanged,
            decoration: decoration(),
          ),
        ),
        const SizedBox(width: 8),

        Expanded(
          child: DropdownButtonFormField<int>(
            value: selectedYear,
            isDense: true,
            items: years
                .map(
                  (year) => DropdownMenuItem(
                    value: year,
                    child: Text(year.toString()),
                  ),
                )
                .toList(),
            onChanged: onYearChanged,
            decoration: decoration(),
          ),
        ),
      ],
    );
  }

  InputDecoration decoration() {
    return InputDecoration(
      filled: true,
      fillColor: AppColors.lightGrey,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    );
  }
}
