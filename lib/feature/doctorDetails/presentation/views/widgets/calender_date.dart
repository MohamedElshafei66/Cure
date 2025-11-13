import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:svg_image/svg_image.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_images.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../cubit/appointment_cubit.dart';
import 'dart:math' as math;

class CalenderDate extends StatefulWidget {
  const CalenderDate({super.key});

  @override
  State<CalenderDate> createState() => _CalenderDateState();
}

class _CalenderDateState extends State<CalenderDate> {
  final DateFormat formatter = DateFormat('EEEE, MMMM d');
  bool _isCalendarOpen = true;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppointmentCubit, AppointmentState>(
      builder: (context, state) {
        DateTime selectedDate = state.selectedDate ?? DateTime.now();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _isCalendarOpen = !_isCalendarOpen;
            });
          },
          child:Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.primary),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                SvgImage(
                    AppImages.calendarImage,
                    type: PathType.assets
                ),
                const SizedBox(
                    width: 8
                ),
                Text(
                  formatter.format(selectedDate),
                  style: AppStyle.styleMedium14(context)
                      .copyWith(color: AppColors.textPrimary),
                ),
                const Spacer(),
                Transform.rotate(
                  angle: _isCalendarOpen ? math.pi / 2 : -math.pi / 2,
                  child: Icon(
                    Icons.arrow_back_ios_rounded,
                    size: 20,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height:16,
        ),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (Widget child, Animation<double> animation) {
            final offsetAnimation = Tween<Offset>(
              begin: const Offset(0, 0.3),
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: Curves.easeOut,
            ));

            return ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: SlideTransition(
                position: offsetAnimation,
                child: FadeTransition(opacity: animation, child: child),
              ),
            );
          },
          child: _isCalendarOpen
              ? Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade100),
            ),
            child: Builder(
              builder: (context) {
                final cubit = context.read<AppointmentCubit>();
                final availableDates = cubit.getAvailableDates();
                
                return SfDateRangePicker(
                  endRangeSelectionColor: AppColors.primary,
                  rangeSelectionColor: AppColors.primary,
                  todayHighlightColor: AppColors.primary,
                  startRangeSelectionColor: AppColors.primary,
                  headerStyle: DateRangePickerHeaderStyle(
                    backgroundColor: AppColors.whiteColor,
                  ),
                  selectionColor: AppColors.primary,
                  selectionShape: DateRangePickerSelectionShape.rectangle,
                  backgroundColor: AppColors.whiteColor,
                  headerHeight: 60,
                  initialSelectedDate: selectedDate,
                  selectionMode: DateRangePickerSelectionMode.single,
                  showNavigationArrow: true,
                  allowViewNavigation: true,
                  onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                    if (args.value is DateTime) {
                      final selected = args.value as DateTime;
                      // Check if selected date is available
                      final dateOnly = DateTime(selected.year, selected.month, selected.day);
                      final isAvailable = availableDates.any((date) {
                        final availableDateOnly = DateTime(date.year, date.month, date.day);
                        return availableDateOnly.isAtSameMomentAs(dateOnly);
                      });
                      
                      if (isAvailable) {
                        context.read<AppointmentCubit>().selectDate(selected);
                        setState(() {
                          _isCalendarOpen = false;
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('This date is not available'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                    }
                  },
                  monthViewSettings: DateRangePickerMonthViewSettings(
                    firstDayOfWeek: 7,
                    // Disable dates that are not available
                    blackoutDates: availableDates.isEmpty
                        ? []
                        : _getBlackoutDates(availableDates),
                  ),
                );
              },
            ),
          )
              : const SizedBox.shrink(),
          ),
        ],
        );
      },
    );
  }
  
  // Get blackout dates (dates that are NOT available)
  List<DateTime> _getBlackoutDates(List<DateTime> availableDates) {
    if (availableDates.isEmpty) return [];
    
    final blackoutDates = <DateTime>[];
    final now = DateTime.now();
    final endDate = now.add(const Duration(days: 365)); // Check next year
    
    // Get all available dates as a set for quick lookup
    final availableSet = availableDates.map((date) {
      return DateTime(date.year, date.month, date.day);
    }).toSet();
    
    // Iterate through all dates and add non-available ones to blackout
    var current = DateTime(now.year, now.month, now.day);
    while (current.isBefore(endDate)) {
      if (!availableSet.contains(current)) {
        blackoutDates.add(current);
      }
      current = current.add(const Duration(days: 1));
    }
    
    return blackoutDates;
  }
}
