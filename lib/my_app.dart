import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:round_7_mobile_cure_team3/core/constants/auth_provider.dart';
import 'package:round_7_mobile_cure_team3/core/constants/secure_storage_data.dart';
import 'package:round_7_mobile_cure_team3/core/network/api_services.dart';
import 'package:round_7_mobile_cure_team3/feature/auth/Sign%20In/domain/login_repo_impl.dart';
import 'package:round_7_mobile_cure_team3/feature/auth/Sign%20In/presentation/mange/cubit/sign_in_cubit.dart';
import 'package:round_7_mobile_cure_team3/feature/auth/otp/domain/repo_impl/otp_repo_impl.dart';
import 'package:round_7_mobile_cure_team3/feature/auth/otp/presentation/mange/cubit/otp_cubit.dart';
import 'package:round_7_mobile_cure_team3/feature/auth/sign%20up/domain/register_repo_impl.dart';
import 'package:round_7_mobile_cure_team3/feature/auth/sign%20up/presentation/mange/cubit/sign_up_cubit.dart';
import 'package:round_7_mobile_cure_team3/feature/notifications/data/notification_repo_impl.dart';
import 'package:round_7_mobile_cure_team3/feature/notifications/presentation/manage/cubit/notification_cubit.dart';
import 'core/routes/app_routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider<SecureStorageService>(
      create: (_) => SecureStorageService(),
      child: MultiBlocProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthProvider()),
          BlocProvider(
            create: (context) => SignUpCubit(
              registerRepo: RegisterRepoImpl(
                ApiServices(
                  secureStorage: context.read<SecureStorageService>(),
                ),
              ),
            ),
          ),
          BlocProvider(
            create: (context) => SignInCubit(
              loginRepo: LoginRepoImpl(
                ApiServices(
                  secureStorage: context.read<SecureStorageService>(),
                ),
              ),
            ),
          ),
          BlocProvider(
            create: (context) => OtpCubit(
              otpRepo: OtpRepoImpl(
                apiServices: ApiServices(
                  secureStorage: context.read<SecureStorageService>(),
                ),
              ),
            ),
          ),
          BlocProvider(
            create: (context) {
              final secure = context.read<SecureStorageService>();

              final repo = NotificationRepositoryImpl(secureStorage: secure);
              return NotificationCubit(repo);
            },
          ),
        ],
        child: MaterialApp.router(
          routerConfig: AppRoutes.router,
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
