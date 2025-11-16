import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_colors.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_images.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_strings.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_styles.dart';
import 'package:round_7_mobile_cure_team3/feature/booking/presentation/views/widgets/booking_days.dart';
import 'package:round_7_mobile_cure_team3/feature/booking/presentation/cubit/booking_search_cubit.dart';
import 'package:svg_image/svg_image.dart';

import 'booking_buttons.dart';

class BookingViewBody extends StatefulWidget {
  const BookingViewBody({super.key});
  @override
  State<BookingViewBody> createState() => _BookingViewBodyState();
}

class _BookingViewBodyState extends State<BookingViewBody> {
  int selectedDayIndex = 0;
  String selectedDay = '';
  String selectedDate = '';

  @override
  void initState() {
    super.initState();
    // Fetch bookings for today when widget initializes
    final now = DateTime.now();
    selectedDate = '${now.year}-${now.month}-${now.day}';
    _fetchBookingsForDate(selectedDate);
  }

  void _fetchBookingsForDate(String date) {
    context.read<BookingSearchCubit>().fetchBookings(fromDate: date);
  }

  String _formatDateTime(DateTime dateTime) {
    final dateFormat = DateFormat('EEEE, MMMM d - h:mm a');
    return dateFormat.format(dateTime);
  }

  String _getImageUrl(String imagePath) {
    if (imagePath.isEmpty) {
      return 'https://images.unsplash.com/photo-1550831107-1553da8c8464';
    }
    if (imagePath.startsWith('http')) {
      return imagePath;
    }
    if (imagePath.startsWith('/')) {
      return 'https://cure-doctor-booking.runasp.net$imagePath';
    }
    return 'https://cure-doctor-booking.runasp.net/$imagePath';
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return Column(
      children: [
        BookingDays(
          onDaySelected: (index, day, date) {
            setState(() {
              selectedDayIndex = index;
              selectedDay = day;
              selectedDate = date;
            });
            _fetchBookingsForDate(date);
          },
        ),
        const SizedBox(height: 8),
        Expanded(
          child: BlocBuilder<BookingSearchCubit, BookingSearchState>(
            builder: (context, state) {
              if (state is BookingSearchLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state is BookingSearchError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        state.message,
                        style: AppStyle.styleMedium16(context).copyWith(
                          color: AppColors.red,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => _fetchBookingsForDate(selectedDate),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                );
              }

              if (state is BookingSearchSuccess) {
                final bookings = state.bookings;
                
                // Filter bookings for the selected day
                final dateParts = selectedDate.split('-');
                final selectedDateObj = DateTime(
                  int.parse(dateParts[0]),
                  int.parse(dateParts[1]),
                  int.parse(dateParts[2]),
                );
                
                final dayBookings = bookings.where((booking) {
                  final bookingDate = DateTime(
                    booking.dateTimeBooking.year,
                    booking.dateTimeBooking.month,
                    booking.dateTimeBooking.day,
                  );
                  return bookingDate.year == selectedDateObj.year &&
                      bookingDate.month == selectedDateObj.month &&
                      bookingDate.day == selectedDateObj.day;
                }).toList();

                if (dayBookings.isEmpty) {
                  return Center(
                    child: Text(
                      AppStrings.noBooking,
                      style: AppStyle.styleMedium16(context).copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                  );
                }

                return AnimatedSwitcher(
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
                  child: ListView.builder(
                    key: ValueKey(selectedDayIndex),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    itemCount: dayBookings.length,
                    itemBuilder: (context, index) {
                      final booking = dayBookings[index];
                      final status = booking.bookingStatus;

                      return Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12.withValues(alpha: 0.05),
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
                                  type: PathType.assets,
                                ),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    _formatDateTime(booking.dateTimeBooking),
                                    style: AppStyle.styleRegular12(context).copyWith(
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                ),
                                Text(
                                  status,
                                  style: AppStyle.styleRegular14(context).copyWith(
                                    color: status == 'Upcoming'
                                        ? AppColors.primary
                                        : status == 'Completed'
                                            ? AppColors.green
                                            : status == 'Canceled' || status == 'Cancelled'
                                                ? AppColors.red
                                                : Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: size.width * 0.06,
                                  backgroundImage: CachedNetworkImageProvider(
                                    _getImageUrl(booking.doctorInfo.doctorImage),
                                  ),
                                  onBackgroundImageError: (exception, stackTrace) {
                                    // Handle image error
                                  },
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        booking.doctorInfo.doctorName,
                                        style: AppStyle.styleRegular16(context).copyWith(
                                          color: AppColors.blackColor48,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        booking.doctorInfo.doctorSpecialty,
                                        style: AppStyle.styleMedium14(context).copyWith(
                                          color: AppColors.textSecondary,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            if (booking.doctorInfo.doctorLocation.isNotEmpty) ...[
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  SvgImage(
                                    AppImages.locationImage,
                                    type: PathType.assets,
                                  ),
                                  const SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      booking.doctorInfo.doctorLocation,
                                      style: AppStyle.styleMedium14(context).copyWith(
                                        color: AppColors.textSecondary,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                            const SizedBox(height: 16),
                            bookingButtons(status, context, booking.bookingId),
                          ],
                        ),
                      );
                    },
                  ),
                );
              }

              return Center(
                child: Text(
                  AppStrings.noBooking,
                  style: AppStyle.styleMedium16(context).copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
