import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_colors.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_strings.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_styles.dart';
import 'package:round_7_mobile_cure_team3/core/widgets/custom_button.dart';
import 'package:round_7_mobile_cure_team3/feature/booking/domain/entities/booking_entity.dart';
import 'package:round_7_mobile_cure_team3/feature/booking/domain/entities/doctor_info_entity.dart';
import 'package:round_7_mobile_cure_team3/feature/booking/domain/entities/reschedule_entity.dart';
import 'package:round_7_mobile_cure_team3/feature/booking/presentation/cubit/booking_search_cubit.dart';
import 'package:round_7_mobile_cure_team3/feature/booking/presentation/views/widgets/cancellation_message.dart';
import 'package:round_7_mobile_cure_team3/feature/booking/presentation/views/widgets/doctor_details.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/views/widgets/calender_date.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/views/widgets/time_date.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/cubit/appointment_cubit.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/cubit/doctor_details_cubit.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/data/models/doctor_detail_model.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_images.dart';
import 'package:svg_image/svg_image.dart';
import 'package:cached_network_image/cached_network_image.dart';

class RescheduleViewBody extends StatefulWidget {
  final String? bookingId;
  const RescheduleViewBody({super.key, this.bookingId});

  @override
  State<RescheduleViewBody> createState() => _RescheduleViewBodyState();
}

class _RescheduleViewBodyState extends State<RescheduleViewBody> {
  bool isLoading = false;
  bool hasLoadedSlots = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingSearchCubit, BookingSearchState>(
      builder: (context, state) {
        // Find the booking from the current state
        BookingEntity? booking;
        if (state is BookingSearchSuccess && widget.bookingId != null) {
          try {
            booking = state.bookings.firstWhere(
              (b) => b.bookingId == widget.bookingId,
            );
          } catch (e) {
            // Booking not found in current state
          }
        }

        if (booking == null && widget.bookingId != null) {
          // If booking not found, show error or loading
          if (state is BookingSearchLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Booking not found',
                    style: AppStyle.styleMedium16(context).copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  CustomButton(
                    text: 'Go Back',
                    onPressed: () => context.pop(),
                  ),
                ],
              ),
            ),
          );
        }

        final doctorInfo = booking?.doctorInfo ?? DoctorInfoEntity(
          '',
          'Doctor Name',
          '',
          'Specialty',
          '',
        );

        // Fetch available slots from API if not already loaded
        final appointmentCubit = context.read<AppointmentCubit>();
        final doctorDetailsCubit = context.read<DoctorDetailsCubit>();
        
        // Fetch doctor details with available slots if not already loaded
        if (booking != null && !hasLoadedSlots) {
          final doctorId = int.tryParse(doctorInfo.doctorId) ?? 0;
          if (doctorId > 0) {
            hasLoadedSlots = true;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              doctorDetailsCubit.fetchDoctorDetails(doctorId);
            });
          }
        }

        // Listen to DoctorDetailsCubit to set available slots to AppointmentCubit
        return BlocListener<DoctorDetailsCubit, DoctorDetailsState>(
          listener: (context, doctorState) {
            if (doctorState is DoctorDetailsLoaded) {
              print('RescheduleViewBody: Setting doctor details to AppointmentCubit');
              print('DoctorDetails type: ${doctorState.doctorDetails.runtimeType}');
              appointmentCubit.setDoctorDetails(doctorState.doctorDetails);
              
              // Set initial date if not already set
              if (appointmentCubit.state.selectedDate == null) {
                final tomorrow = DateTime.now().add(const Duration(days: 1));
                appointmentCubit.selectDate(tomorrow);
              }
            }
          },
          child: _buildContent(context, booking, doctorInfo, appointmentCubit),
        );
      },
    );
  }

  Widget _buildContent(
    BuildContext context,
    BookingEntity? booking,
    DoctorInfoEntity doctorInfo,
    AppointmentCubit appointmentCubit,
  ) {

    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 15),
                      const CancellationMessage(),
                      const SizedBox(height: 24),
                      // Use the original DoctorDetails widget but pass booking data
                      _DoctorDetailsWidget(
                        booking: booking,
                        doctorInfo: doctorInfo,
                      ),
                      const SizedBox(height: 24),
                      const CalenderDate(),
                      const SizedBox(height: 24),
                      const TimeDate(),
                    ],
                  ),
                ),
              ),
              CustomButton(
                text: AppStrings.reschedule,
                onPressed: isLoading
                    ? null
                    : () => _handleReschedule(
                          context,
                          context.read<BookingSearchCubit>(),
                          appointmentCubit,
                          doctorInfo,
                        ),
              ),
              const SizedBox(height: 16),
              CustomButton(
                text: AppStrings.cancel,
                onPressed: isLoading ? null : () => context.pop(),
                color: AppColors.whiteColor,
                borderColor: AppColors.textHint,
                textColor: AppColors.textHint,
              ),
              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );
  }


  Future<void> _handleReschedule(
    BuildContext context,
    BookingSearchCubit bookingCubit,
    AppointmentCubit appointmentCubit,
    DoctorInfoEntity doctorInfo,
  ) async {
    final state = appointmentCubit.state;
    
    if (state.selectedDate == null || state.selectedTime == null || widget.bookingId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select both date and time'),
          backgroundColor: AppColors.red,
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    // Parse time string (format: "HH:MM" or "H:MM AM/PM")
    String timeString = state.selectedTime!;
    
    // Convert to 24-hour format if needed
    if (timeString.contains('AM') || timeString.contains('PM')) {
      final parts = timeString.split(' ');
      final timeParts = parts[0].split(':');
      int hour = int.parse(timeParts[0]);
      final minute = int.parse(timeParts[1]);
      
      if (parts[1].toUpperCase() == 'PM' && hour != 12) {
        hour += 12;
      } else if (parts[1].toUpperCase() == 'AM' && hour == 12) {
        hour = 0;
      }
      
      timeString = '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
    }

    final rescheduleEntity = RescheduleEntity(
      doctorInfo,
      state.selectedDate!,
      timeString,
      'Available',
      widget.bookingId!,
    );

    await bookingCubit.rescheduleBooking(rescheduleEntity);
    
    if (!mounted) return;
    
    setState(() {
      isLoading = false;
    });
    
    // Check if there's an error
    if (bookingCubit.state is BookingSearchError) {
      final errorState = bookingCubit.state as BookingSearchError;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorState.message),
          backgroundColor: AppColors.red,
        ),
      );
    } else {
      // Success - show message and navigate back
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Booking rescheduled successfully'),
          backgroundColor: AppColors.green,
        ),
      );
      context.pop();
    }
  }
}

// Custom DoctorDetails widget that shows booking data
class _DoctorDetailsWidget extends StatelessWidget {
  final BookingEntity? booking;
  final DoctorInfoEntity doctorInfo;

  const _DoctorDetailsWidget({
    required this.booking,
    required this.doctorInfo,
  });

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

  String _formatDateTime(DateTime dateTime) {
    final dateFormat = DateFormat('EEEE, MMMM d - h:mm a');
    return dateFormat.format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return Column(
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
                booking != null
                    ? _formatDateTime(booking!.dateTimeBooking)
                    : 'Select new date and time',
                style: AppStyle.styleRegular14(context).copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            Text(
              booking?.bookingStatus ?? 'Upcoming',
              style: AppStyle.styleRegular14(context).copyWith(
                color: AppColors.primary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            CircleAvatar(
              radius: size.width * 0.06,
              backgroundImage: CachedNetworkImageProvider(
                _getImageUrl(doctorInfo.doctorImage),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doctorInfo.doctorName,
                    style: AppStyle.styleRegular16(context).copyWith(
                      color: AppColors.blackColor48,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    doctorInfo.doctorSpecialty,
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
        if (doctorInfo.doctorLocation.isNotEmpty) ...[
          const SizedBox(height: 10),
          Row(
            children: [
              SvgImage(
                AppImages.locationImage,
                type: PathType.assets,
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  doctorInfo.doctorLocation,
                  style: AppStyle.styleMedium16(context).copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}
