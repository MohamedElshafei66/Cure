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
import 'package:round_7_mobile_cure_team3/feature/favourites/presentation/cubits/favourties_cubit.dart';
import 'core/routes/app_routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider<SecureStorageService>(
      create: (_) => SecureStorageService(),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthProvider()),
        ],
        child: Builder(builder: (context) {
          final authProvider = context.read<AuthProvider>();
          final secure = context.read<SecureStorageService>();
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) => SignUpCubit(
                  registerRepo: RegisterRepoImpl(
                    ApiServices(authProvider: authProvider),
                  ),
                ),
              ),
              BlocProvider(
                create: (_) => SignInCubit(
                  loginRepo: LoginRepoImpl(
                    ApiServices(authProvider: authProvider),
                  ),
                ),
              ),
              BlocProvider(
                create: (_) => OtpCubit(
                  otpRepo: OtpRepoImpl(
                    apiServices: ApiServices(authProvider: authProvider),
                  ),
                ),
              ),
              BlocProvider(
                create: (_) {
                  final repo = NotificationRepositoryImpl(
                    secureStorage: secure,
                    authProvider: authProvider,
                  );
                  return NotificationCubit(repo);
                },
              ),
              BlocProvider(
                create: (_) => FavouritesCubit(authProvider: authProvider)
                  ..fetchFavourites(),
              ),
            ],
            child: MaterialApp.router(
              routerConfig: AppRoutes.router,
              debugShowCheckedModeBanner: false,
            ),
          );
        }),
      ),
    );
  }
}
