import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:round_7_mobile_cure_team3/core/constants/dependincy_injection.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_colors.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_strings.dart';
import 'package:round_7_mobile_cure_team3/feature/booking/presentation/cubit/booking_search_cubit.dart';
import 'package:round_7_mobile_cure_team3/feature/booking/presentation/views/widgets/reschedule_view_body.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/views/widgets/doctor_details_app_bar.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/cubit/appointment_cubit.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/cubit/doctor_details_cubit.dart';

class RescheduleView extends StatefulWidget {
  final String? bookingId;
  const RescheduleView({super.key, this.bookingId});

  @override
  State<RescheduleView> createState() => _RescheduleViewState();
}

class _RescheduleViewState extends State<RescheduleView> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            final cubit = getIt<BookingSearchCubit>();
            // Fetch bookings when screen opens
            WidgetsBinding.instance.addPostFrameCallback((_) {
              final now = DateTime.now();
              final date = '${now.year}-${now.month}-${now.day}';
              cubit.fetchBookings(fromDate: date);
            });
            return cubit;
          },
        ),
        BlocProvider(
          create: (context) => getIt<AppointmentCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<DoctorDetailsCubit>(),
        ),
      ],
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: DoctorDetailsAppbar(
          text: AppStrings.yourAppointment,
        ),
        body: RescheduleViewBody(bookingId: widget.bookingId),
      ),
    );
  }
}
