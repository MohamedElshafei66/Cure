import 'package:get_it/get_it.dart';
import 'package:round_7_mobile_cure_team3/core/constants/shared_data.dart';
import 'package:round_7_mobile_cure_team3/core/network/api_services.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/data/data_sources/doctor_details_remote_data_source.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/data/data_sources/booking_remote_data_source.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/data/data_sources/add_review_remote_data_source.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/data/repositories/doctor_details_repo_impl.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/data/repositories/booking_repo_impl.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/data/repositories/add_review_repo_impl.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/domain/repositories/doctor_details_repo.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/domain/repositories/booking_repo.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/domain/repositories/add_review_repo.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/domain/use_cases/get_doctor_details_use_case.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/domain/use_cases/create_booking_use_case.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/domain/use_cases/add_review_use_case.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/cubit/doctor_details_cubit.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/cubit/appointment_cubit.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/cubit/booking_cubit.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/cubit/add_review_cubit.dart';

final getIt = GetIt.instance;

class DependincyInjection {
  static Future<void> init() async {
    // Network
    getIt.registerLazySingleton<ApiServices>(
      () => ApiServices(),
    );

    // Data Sources
    getIt.registerLazySingleton<DoctorDetailsRemoteDataSource>(
      () => DoctorDetailsRemoteDataSourceImpl(apiServices: getIt()),
    );

    getIt.registerLazySingleton<BookingRemoteDataSource>(
      () => BookingRemoteDataSourceImpl(apiServices: getIt()),
    );

    getIt.registerLazySingleton<AddReviewRemoteDataSource>(
      () => AddReviewRemoteDataSourceImpl(apiServices: getIt()),
    );

    // Repositories
    getIt.registerLazySingleton<DoctorDetailsRepo>(
      () => DoctorDetailsRepoImpl(remoteDataSource: getIt()),
    );

    getIt.registerLazySingleton<BookingRepo>(
      () => BookingRepoImpl(remoteDataSource: getIt()),
    );

    getIt.registerLazySingleton<AddReviewRepo>(
      () => AddReviewRepoImpl(remoteDataSource: getIt()),
    );

    // Use Cases
    getIt.registerLazySingleton<GetDoctorDetailsUseCase>(
      () => GetDoctorDetailsUseCase(getIt()),
    );

    getIt.registerLazySingleton<CreateBookingUseCase>(
      () => CreateBookingUseCase(getIt()),
    );

    getIt.registerLazySingleton<AddReviewUseCase>(
      () => AddReviewUseCase(getIt()),
    );

    // Cubits
    getIt.registerFactory<DoctorDetailsCubit>(
      () => DoctorDetailsCubit(getDoctorDetailsUseCase: getIt()),
    );

    getIt.registerFactory<AppointmentCubit>(
      () => AppointmentCubit(),
    );

    getIt.registerFactory<BookingCubit>(
      () => BookingCubit(createBookingUseCase: getIt()),
    );

    getIt.registerFactory<AddReviewCubit>(
      () => AddReviewCubit(addReviewUseCase: getIt()),
    );
  }
}
