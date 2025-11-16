import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_colors.dart';

class BirthdayPicker extends StatelessWidget {
  final int selectedDay;
  final String selectedMonth;
  final int selectedYear;

  final List<int> days;
  final List<String> months;
  final List<int> years;

  final Function(int?) onDayChanged;
  final Function(String?) onMonthChanged;
  final Function(int?) onYearChanged;

  const BirthdayPicker({
    super.key,
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
        Expanded(child: _buildDropdown<int>(
          value: selectedDay,
          items: days.map((d) => DropdownMenuItem(value: d, child: FittedBox(child: Text("$d")))).toList(),
          onChanged: onDayChanged,
        )),

        const Gap(8),

        Expanded(child: _buildDropdown<String>(
          value: selectedMonth,
          items: months.map((m) => DropdownMenuItem(value: m, child: FittedBox(child: Text(m)))).toList(),
          onChanged: onMonthChanged,
        )),

        const Gap(8),

        Expanded(child: _buildDropdown<int>(
          value: selectedYear,
          items: years.map((y) => DropdownMenuItem(value: y, child: FittedBox(child: Text("$y")))).toList(),
          onChanged: onYearChanged,
        )),
      ],
    );
  }

  Widget _buildDropdown<T>({
    required T value,
    required List<DropdownMenuItem<T>> items,
    required Function(T?) onChanged,
  }) {
    return SizedBox(
      height: 48,
      child: DropdownButtonFormField<T>(
        isExpanded: true,  
        value: value,
        items: items,
        onChanged: onChanged,
        decoration: const InputDecoration(
          filled: true,
          fillColor: AppColors.lightGrey,
          contentPadding: EdgeInsets.symmetric(horizontal: 8),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(6)),
            borderSide: BorderSide(color: Colors.grey),
          ),
        ),
        icon: const Icon(Icons.arrow_drop_down),
      ),
    );
  }
}
