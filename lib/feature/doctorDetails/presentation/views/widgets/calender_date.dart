import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:svg_image/svg_image.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_images.dart';
import '../../../../../core/utils/app_styles.dart';
import 'dart:math' as math;

class CalenderDate extends StatefulWidget {
  const CalenderDate({super.key});

  @override
  State<CalenderDate> createState() => _CalenderDateState();
}

class _CalenderDateState extends State<CalenderDate> {
  DateTime selectedDate = DateTime(2025, 7, 21);
  final DateFormat formatter = DateFormat('EEEE, MMMM d');
  bool _isCalendarOpen = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:CrossAxisAlignment.start,
      children:[
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
                border:BoxBorder.all(color:Colors.grey.shade100)
            ),
            child: SfDateRangePicker(
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
                  setState(() {
                    selectedDate = args.value;
                    _isCalendarOpen = false;
                  });
                }
              },
              monthViewSettings: const DateRangePickerMonthViewSettings(
                firstDayOfWeek: 7,
              ),
            ),
          )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
