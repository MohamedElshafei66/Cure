import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:round_7_mobile_cure_team3/feature/auth/Sign%20In/view/sign_in_screen.dart';
import 'package:round_7_mobile_cure_team3/feature/auth/sign%20up/sign_up_screen.dart';
import 'package:round_7_mobile_cure_team3/feature/notifications/presentation/view/notification_screen.dart';
import 'package:round_7_mobile_cure_team3/feature/auth/otp/presentation/otp_screen.dart';
import 'package:round_7_mobile_cure_team3/feature/splash/splash_screen.dart';
import '../../feature/onboarding/presentation/view/onboarding_screen.dart';

abstract class AppRoutes{
 static String onBoarding_screen='/onboarding';
 static String sign_in_screen='/sign_in';
 static String sign_up_screen='/sign_up';
 static String otp_screen='/otp';
 static String notification_screen='/notification';
 static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => SplashScreen(),
      ),
      GoRoute(
        path: onBoarding_screen,
        builder: (context, state) => OnBoardingScreen(),
      ),
      GoRoute(
        path:sign_in_screen,
        builder: (context, state) => SignInScreen(),
      ),
      GoRoute(
        path: sign_up_screen,
        builder: (context, state) => SignUpScreen(),
      ),
      GoRoute(
        path: otp_screen,
        builder: (context, state) => OTPVerificationScreen(),
      ),
      GoRoute(
        path: notification_screen,
        builder: (context, state) => NotificationScreen(),
      ),

    ],
  );
}