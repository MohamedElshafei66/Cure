import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../cubit/appointment_cubit.dart';

class TimeDate extends StatelessWidget {
  const TimeDate({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppointmentCubit, AppointmentState>(
      builder: (context, state) {
        // Get available times for selected date
        final availableTimes = state.selectedDate != null
            ? context.read<AppointmentCubit>().getAvailableTimesForDate(state.selectedDate!)
            : <String>[];
        
        if (availableTimes.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                state.selectedDate == null
                    ? 'Please select a date first'
                    : 'No available times for this date',
                style: AppStyle.styleMedium14(context).copyWith(
                  color: Colors.grey,
                ),
              ),
            ),
          );
        }
        
        return Center(
          child: Wrap(
            spacing: 24,
            runSpacing: 12,
            children: availableTimes.map((time) {
              final bool isSelected = time == state.selectedTime;
              return GestureDetector(
                onTap: () {
                  context.read<AppointmentCubit>().selectTime(time);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
            }).toList(),
          ),
        );
      },
    );
  }
}

