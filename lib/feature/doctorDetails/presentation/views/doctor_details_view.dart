import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:round_7_mobile_cure_team3/core/constants/auth_provider.dart';
import 'package:round_7_mobile_cure_team3/core/network/api_services.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_strings.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/data/data_sources/doctor_details_remote_data_source.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/data/repositories/doctor_details_repo_impl.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/domain/use_cases/get_doctor_details_use_case.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/cubit/appointment_cubit.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/cubit/doctor_details_cubit.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/views/widgets/doctor_details_app_bar.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/views/widgets/doctor_details_body.dart';
import 'package:round_7_mobile_cure_team3/feature/favourites/presentation/cubits/favourties_cubit.dart';

class DoctorDetailsScreen extends StatelessWidget {
  final int? doctorId;
  const DoctorDetailsScreen({super.key, this.doctorId});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.read<AuthProvider>();

    return MultiBlocProvider(
      providers: [
        BlocProvider<DoctorDetailsCubit>(
          create: (context) => DoctorDetailsCubit(
            getDoctorDetailsUseCase: GetDoctorDetailsUseCase(
              DoctorDetailsRepoImpl(
                remoteDataSource: DoctorDetailsRemoteDataSourceImpl(
                  apiServices: ApiServices(authProvider: authProvider),
                ),
              ),
            ),
          )..fetchDoctorDetails(doctorId ?? 2),
        ),
        BlocProvider<AppointmentCubit>(
          create: (context) => AppointmentCubit(),
        ),
        BlocProvider<FavouritesCubit>(
          create: (context) => FavouritesCubit(authProvider: authProvider)
            ..fetchFavourites(),
        ),
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: DoctorDetailsAppbar(
          showActions: true,
          text: AppStrings.doctorDetailsTitle,
        ),
        body: const DoctorDetailsBody(),
      ),
    );
  }
}

