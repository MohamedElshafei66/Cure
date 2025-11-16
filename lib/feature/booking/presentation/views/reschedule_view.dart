import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:round_7_mobile_cure_team3/core/constants/auth_provider.dart';
import 'package:round_7_mobile_cure_team3/core/network/api_services.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_colors.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_strings.dart';
import 'package:round_7_mobile_cure_team3/feature/booking/data/data_sources/booking_search_remote_data_source.dart';
import 'package:round_7_mobile_cure_team3/feature/booking/data/repositories/booking_repo_impl.dart';
import 'package:round_7_mobile_cure_team3/feature/booking/domain/use_cases/get_booking_use_case.dart';
import 'package:round_7_mobile_cure_team3/feature/booking/domain/use_cases/cancel_booking_use_case.dart';
import 'package:round_7_mobile_cure_team3/feature/booking/domain/use_cases/reschedule_booking_use_case.dart';
import 'package:round_7_mobile_cure_team3/feature/booking/presentation/cubit/booking_search_cubit.dart';
import 'package:round_7_mobile_cure_team3/feature/booking/presentation/views/widgets/reschedule_view_body.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/data/data_sources/doctor_details_remote_data_source.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/domain/use_cases/get_doctor_details_use_case.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/data/repositories/doctor_details_repo_impl.dart';
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
    final authProvider = context.read<AuthProvider>();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            final bookingCubit = BookingSearchCubit(
              getBookingUseCase: GetBookingUseCase(
                BookingRepoImpl(
                  remoteDataSource: BookingSearchRemoteDataSourceImpl(
                    apiServices: ApiServices(authProvider: authProvider),
                  ),
                ),
              ),
              cancelBookingUseCase: CancelBookingUseCase(
                BookingRepoImpl(
                  remoteDataSource: BookingSearchRemoteDataSourceImpl(
                    apiServices: ApiServices(authProvider: authProvider),
                  ),
                ),
              ),
              rescheduleBookingUseCase: RescheduleBookingUseCase(
                BookingRepoImpl(
                  remoteDataSource: BookingSearchRemoteDataSourceImpl(
                    apiServices: ApiServices(authProvider: authProvider),
                  ),
                ),
              ),
            );

            // تحميل الحجوزات عند فتح الصفحة
            WidgetsBinding.instance.addPostFrameCallback((_) {
              final now = DateTime.now();
              final date = '${now.year}-${now.month}-${now.day}';
              bookingCubit.fetchBookings(fromDate: date);
            });

            return bookingCubit;
          },
        ),
        BlocProvider(
          create: (context) => AppointmentCubit(),
        ),
        BlocProvider(
          create: (context) => DoctorDetailsCubit(
            getDoctorDetailsUseCase: GetDoctorDetailsUseCase(
              DoctorDetailsRepoImpl(
                remoteDataSource: DoctorDetailsRemoteDataSourceImpl(
                  apiServices: ApiServices(authProvider: authProvider),
                ),
              ),
            ),
          ),
        ),
      ],
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: const DoctorDetailsAppbar(
          text: AppStrings.yourAppointment,
        ),
        body: RescheduleViewBody(bookingId: widget.bookingId),
      ),
    );
  }
}
