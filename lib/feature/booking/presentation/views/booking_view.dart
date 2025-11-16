import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:round_7_mobile_cure_team3/core/constants/auth_provider.dart';
import 'package:round_7_mobile_cure_team3/core/network/api_services.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_colors.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_strings.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_styles.dart';
import 'package:round_7_mobile_cure_team3/feature/booking/data/data_sources/booking_search_remote_data_source.dart';
import 'package:round_7_mobile_cure_team3/feature/booking/data/repositories/booking_repo_impl.dart';
import 'package:round_7_mobile_cure_team3/feature/booking/domain/use_cases/get_booking_use_case.dart';
import 'package:round_7_mobile_cure_team3/feature/booking/domain/use_cases/cancel_booking_use_case.dart';
import 'package:round_7_mobile_cure_team3/feature/booking/domain/use_cases/reschedule_booking_use_case.dart';
import 'package:round_7_mobile_cure_team3/feature/booking/presentation/cubit/booking_search_cubit.dart';
import 'package:round_7_mobile_cure_team3/feature/booking/presentation/views/widgets/booking_view_body.dart';
import 'package:provider/provider.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  @override
  Widget build(BuildContext context) {
    final authProvider = context.read<AuthProvider>();

    return BlocProvider(
      create: (_) => BookingSearchCubit(
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
      ),
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            AppStrings.booking,
            style: AppStyle.styleRegular20(context).copyWith(
              color: AppColors.textPrimary,
            ),
          ),
        ),
        body: const BookingViewBody(),
      ),
    );
  }
}

