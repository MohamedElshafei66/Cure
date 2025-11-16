import 'package:get_it/get_it.dart';
import 'package:round_7_mobile_cure_team3/core/network/api_services.dart';

// Doctor Details
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/data/data_sources/doctor_details_remote_data_source.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/data/data_sources/booking_remote_data_source.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/data/data_sources/add_review_remote_data_source.dart';

import 'package:round_7_mobile_cure_team3/feature/doctorDetails/data/repositories/doctor_details_repo_impl.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/data/repositories/booking_repo_impl.dart'
as DoctorDetailsBookingRepoImpl;
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/data/repositories/add_review_repo_impl.dart';

import 'package:round_7_mobile_cure_team3/feature/doctorDetails/domain/repositories/doctor_details_repo.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/domain/repositories/booking_repo.dart'
as DoctorDetailsBookingRepo;
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/domain/repositories/add_review_repo.dart';

import 'package:round_7_mobile_cure_team3/feature/doctorDetails/domain/use_cases/get_doctor_details_use_case.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/domain/use_cases/create_booking_use_case.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/domain/use_cases/add_review_use_case.dart';

import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/cubit/doctor_details_cubit.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/cubit/appointment_cubit.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/cubit/booking_cubit.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/cubit/add_review_cubit.dart';

// Booking Search
import 'package:round_7_mobile_cure_team3/feature/booking/data/data_sources/booking_search_remote_data_source.dart';
import 'package:round_7_mobile_cure_team3/feature/booking/data/repositories/booking_repo_impl.dart';
import 'package:round_7_mobile_cure_team3/feature/booking/domain/repositories/booking_repo.dart';

import 'package:round_7_mobile_cure_team3/feature/booking/domain/use_cases/get_booking_use_case.dart';
import 'package:round_7_mobile_cure_team3/feature/booking/domain/use_cases/cancel_booking_use_case.dart';
import 'package:round_7_mobile_cure_team3/feature/booking/domain/use_cases/reschedule_booking_use_case.dart';
import 'package:round_7_mobile_cure_team3/feature/booking/presentation/cubit/booking_search_cubit.dart';

import 'auth_provider.dart';

final getIt = GetIt.instance;

class DependincyInjection {
  static Future<void> init() async {
    //========================
    // Network
    //========================
    getIt.registerLazySingleton<ApiServices>(
          () => ApiServices(authProvider: getIt<AuthProvider>()),
    );

    //========================
    // Data Sources
    //========================
    // Doctor Details
    getIt.registerLazySingleton<DoctorDetailsRemoteDataSource>(
          () => DoctorDetailsRemoteDataSourceImpl(apiServices: getIt()),
    );

    getIt.registerLazySingleton<BookingRemoteDataSource>(
          () => BookingRemoteDataSourceImpl(apiServices: getIt()),
    );

    getIt.registerLazySingleton<AddReviewRemoteDataSource>(
          () => AddReviewRemoteDataSourceImpl(apiServices: getIt()),
    );

    // Booking Search
    getIt.registerLazySingleton<BookingSearchRemoteDataSource>(
          () => BookingSearchRemoteDataSourceImpl(apiServices: getIt()),
    );

    //========================
    // Repositories
    //========================
    // Doctor Details
    getIt.registerLazySingleton<DoctorDetailsRepo>(
          () => DoctorDetailsRepoImpl(remoteDataSource: getIt()),
    );

    getIt.registerLazySingleton<DoctorDetailsBookingRepo.BookingRepo>(
          () => DoctorDetailsBookingRepoImpl.BookingRepoImpl(remoteDataSource: getIt()),
    );

    getIt.registerLazySingleton<AddReviewRepo>(
          () => AddReviewRepoImpl(remoteDataSource: getIt()),
    );

    // Booking Search Repo
    getIt.registerLazySingleton<BookingRepo>(
          () => BookingRepoImpl(remoteDataSource: getIt()),
    );

    //========================
    // Use Cases
    //========================
    getIt.registerLazySingleton<GetDoctorDetailsUseCase>(
          () => GetDoctorDetailsUseCase(getIt()),
    );

    getIt.registerLazySingleton<CreateBookingUseCase>(
          () => CreateBookingUseCase(getIt()),
    );

    getIt.registerLazySingleton<AddReviewUseCase>(
          () => AddReviewUseCase(getIt()),
    );

    getIt.registerLazySingleton<GetBookingUseCase>(
          () => GetBookingUseCase(getIt()),
    );

    getIt.registerLazySingleton<CancelBookingUseCase>(
          () => CancelBookingUseCase(getIt()),
    );

    getIt.registerLazySingleton<RescheduleBookingUseCase>(
          () => RescheduleBookingUseCase(getIt()),
    );

    //========================
    // Cubits
    //========================
    getIt.registerFactory<DoctorDetailsCubit>(
          () => DoctorDetailsCubit(getDoctorDetailsUseCase: getIt()),
    );

    getIt.registerFactory<AppointmentCubit>(() => AppointmentCubit());

    getIt.registerFactory<BookingCubit>(
          () => BookingCubit(createBookingUseCase: getIt()),
    );

    getIt.registerFactory<AddReviewCubit>(
          () => AddReviewCubit(addReviewUseCase: getIt()),
    );

    getIt.registerFactory<BookingSearchCubit>(
          () => BookingSearchCubit(
        getBookingUseCase: getIt(),
        cancelBookingUseCase: getIt(),
        rescheduleBookingUseCase: getIt(),
      ),
    );
  }
}
