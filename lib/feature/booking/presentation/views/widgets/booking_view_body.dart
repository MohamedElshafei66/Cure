import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_colors.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_images.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_strings.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_styles.dart';
import 'package:round_7_mobile_cure_team3/feature/booking/presentation/views/widgets/booking_days.dart';
import 'package:svg_image/svg_image.dart';

import 'booking_buttons.dart';
class BookingViewBody extends StatefulWidget {
  const BookingViewBody({super.key});
  @override
  State<BookingViewBody> createState() => _BookingViewBodyState();
}

class _BookingViewBodyState extends State<BookingViewBody> {
  int selectedDayIndex = 0;
  String selectedDay = 'Thu';
  final Map<String, List<Map<String, String>>> bookingsByDay = {
    'Thu': [],
    'Fri': [],
    'Sat': [],
    'Sun': [
      {
        'name': 'Jennifer Miller',
        'speciality': 'Psychiatrist',
        'status': 'Upcoming',
        'address': '129, El-Nasr Street, Cairo, Egypt',
      },
    ],
    'Mon': [
      {
        'name': 'Jennifer Miller',
        'speciality': 'Psychiatrist',
        'status': 'Upcoming',
        'address': '129, El-Nasr Street, Cairo, Egypt',
      },
      {
        'name': 'Jennifer Miller',
        'speciality': 'Psychiatrist',
        'status': 'Completed',
        'address': '129, El-Nasr Street, Cairo, Egypt',
      },
      {
        'name': 'Jennifer Miller',
        'speciality': 'Psychiatrist',
        'status': 'Canceled',
        'address': '129, El-Nasr Street, Cairo, Egypt',
      },
    ],
    'Tue': [],
    'Wed': [],
  };
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final dayBookings = bookingsByDay[selectedDay] ?? [];
    return Column(
      children: [
        BookingDays(
          onDaySelected:(index, day) {
            setState(() {
              selectedDayIndex = index;
              selectedDay = day;
            });
          },
        ),
        const SizedBox(
            height:8
        ),
        Expanded(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            switchInCurve: Curves.easeInOut,
            switchOutCurve: Curves.easeInOut,
            transitionBuilder: (Widget child, Animation<double> animation) {
              final fade = Tween(begin: 0.0, end: 1.0).animate(animation);
              final slide = Tween<Offset>(
                begin: const Offset(0.1, 0), 
                end: Offset.zero,
              ).animate(animation);

              return FadeTransition(
                opacity: fade,
                child: SlideTransition(position: slide, child: child),
              );
            },
            child: dayBookings.isEmpty
                ?  Center(
                 child: Text(
                AppStrings.noBooking,
                style:AppStyle.styleMedium16(context).copyWith(
                  color:AppColors.textPrimary
                )
              ),
            )
                : ListView.builder(
                 key: ValueKey(selectedDayIndex),
                 padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  itemCount: dayBookings.length,
                 itemBuilder: (context, index) {
                 final booking = dayBookings[index];
                 final status = booking['status']!;
                  Color statusColor;

                switch (status) {
                  case 'Upcoming':
                    statusColor =AppColors.primary;
                    break;
                  case 'Completed':
                    statusColor =AppColors.green;
                    break;
                  case 'Canceled':
                    statusColor =AppColors.red;
                    break;
                  default:
                    statusColor = Colors.grey;
                }

                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color:AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12.withOpacity(0.05),
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SvgImage(
                              AppImages.calendarImage,
                              type:PathType.assets
                          ),
                          SizedBox(
                            width:4,
                          ),
                          Text(
                            "Monday, July 21 - 11:00 AM",
                            style:AppStyle.styleRegular12(context).copyWith(
                              color:AppColors.textPrimary
                            )
                          ),
                          Spacer(),
                          Text(
                            status,
                            style: AppStyle.styleRegular14(context).copyWith(
                              color: status == 'Upcoming'
                                  ? AppColors.primary
                                  : status == 'Completed'
                                  ? AppColors.green
                                  : status == 'Canceled'
                                  ? AppColors.red
                                  : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                          height: 12
                      ),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: size.width * 0.06,
                            backgroundImage:CachedNetworkImageProvider('https://images.unsplash.com/photo-1550831107-1553da8c8464'),
                          ),
                          const SizedBox(
                              width:8
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                booking['name']!,
                                style:AppStyle.styleRegular16(context).copyWith(
                                  color:AppColors.blackColor48
                                )
                              ),
                              SizedBox(
                                height:4,
                              ),
                              Text(
                                booking['speciality']!,
                                style:AppStyle.styleMedium14(context).copyWith(
                                  color:AppColors.textSecondary,
                                  fontWeight:FontWeight.w400
                                )
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                          height:8
                      ),
                      Row(
                        children: [
                          SvgImage(
                              AppImages.locationImage,
                              type:PathType.assets
                          ),
                          const SizedBox(
                              width: 4
                          ),
                          Expanded(
                            child: Text(
                              booking['address']!,
                                style:AppStyle.styleMedium14(context).copyWith(
                                    color:AppColors.textSecondary,
                                    fontWeight:FontWeight.w400
                                )
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                          height:16
                      ),
                      bookingButtons(status,context),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
