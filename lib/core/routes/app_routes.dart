import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:round_7_mobile_cure_team3/core/network/api_services.dart';
import 'package:round_7_mobile_cure_team3/feature/auth/Sign%20In/presentation/view/sign_in_screen.dart';
import 'package:round_7_mobile_cure_team3/feature/auth/app_startup_logic.dart';
import 'package:round_7_mobile_cure_team3/feature/auth/otp/presentation/otp_screen.dart';
import 'package:round_7_mobile_cure_team3/feature/auth/sign%20up/presentation/view/sign_up_screen.dart';
import 'package:round_7_mobile_cure_team3/feature/booking/presentation/views/booking_view.dart';
import 'package:round_7_mobile_cure_team3/feature/booking/presentation/views/reschedule_view.dart';
import 'package:round_7_mobile_cure_team3/feature/chat/presentation/view/chat_screen.dart';
import 'package:round_7_mobile_cure_team3/feature/chat/presentation/view/chats_list_screen.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/views/add_review_view.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/views/confirm_appointment_view.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/views/doctor_details_view.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/views/pay_after_schedule.dart';
import 'package:round_7_mobile_cure_team3/feature/doctors/presentation/all_doctors.dart';
import 'package:round_7_mobile_cure_team3/feature/favourites/presentation/favourites.dart';
import 'package:round_7_mobile_cure_team3/feature/home/presentation/home.dart';
import 'package:round_7_mobile_cure_team3/feature/map/presentation/map.dart';
import 'package:round_7_mobile_cure_team3/feature/notifications/presentation/view/notification_screen.dart';
import 'package:round_7_mobile_cure_team3/feature/onboarding/presentation/view/onboarding_screen.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/data/ProfileRemoteDataSource.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/data/model/profile_model.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/data/repo/profile_repository.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/logic/Cubit/profile_cubit.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/ui/add_card_screen.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/ui/faqs_screen.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/ui/payment_method_screen.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/ui/payment_method_second_screen.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/ui/payment_method_third_screen.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/ui/privacy_policy_screen.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/ui/profile_edit_screen.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/ui/profile_screen.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/ui/setting_screen.dart';
import 'package:round_7_mobile_cure_team3/feature/search/presentation/search_screen.dart';
import 'package:round_7_mobile_cure_team3/main_layout.dart';

abstract class AppRoutes {
  static String doctorDetailsScreen = "/doctorDetailsScreen";
  static String confirmAppointmentScreen = "/confirmAppointment";
  static String payAfterScheduleScreen = "/payAfterScheduleScreen";
  static String addReviewScreen = "/addReviewScreen";
  static String bookingScreen = "/bookingScreen";
  static String rescheduleScreen = "/rescheduleScreen";
  static String onBoarding_screen = '/onboarding';
  static String sign_in_screen = '/sign_in';
  static String sign_up_screen = '/sign_up';
  static String otp_screen = '/otp';
  static String notification_screen = '/notification';
  static String faqsSreen = "/faqsSreen";
  static String privacyPolicyScreen = "/privacyPolicyScreen";
  static String profileScreen = "/profileScreen";
  static String settingScreen = "/settingScreen";
  static String paymentMethodScreen = "/paymentMethodScreen";
  static String paymentMethodSecondScreen = "/paymentMethodSecondScreen";
  static String paymentMethodThirdScreen = "/paymentMethodThirdScreen";
  static String chatsListScreen = "/chats_list_screen";
  static String chatScreen = "/chatScreen";
  static String allDoctorsScreen = '/doctors';
  static String search = '/search';
  static String favourites = '/favourites';
  static String map = '/map';
  static String home = '/home';
  static String mainLayout = '/main_layout';
  static String passwordManagement = '/manage_password';
  static String profileEdit = '/profile_edit';
  static String addCard = '/addCard';

  static final router = GoRouter(
    initialLocation: profileScreen,
    routes: [
      GoRoute(
        path: profileEdit,
        builder: (context, state) {
          final profile = state.extra as ProfileModel;

          return BlocProvider<ProfileCubit>(
            create: (context) => ProfileCubit(
              ProfileRepository(ProfileRemoteDataSource(ApiServices())),
            ),

            child: Builder(
              builder: (context) {
                return ProfileEditScreen(profile: profile);
              },
            ),
          );
        },
      ),

      GoRoute(path: mainLayout, builder: (context, state) => MainLayout()),
      GoRoute(path: home, builder: (context, state) => Home()),
      GoRoute(path: search, builder: (context, state) => SearchScreen()),
      GoRoute(path: favourites, builder: (context, state) => Favourites()),
      GoRoute(path: map, builder: (context, state) => MapScreen()),
      GoRoute(path: '/', builder: (context, state) => AppStartupLogic()),
      GoRoute(
        path: allDoctorsScreen,
        builder: (context, state) => AllDoctorsScreen(),
      ),
      GoRoute(
        path: onBoarding_screen,
        builder: (context, state) => OnBoardingScreen(),
      ),
      GoRoute(
        path: sign_in_screen,
        builder: (context, state) => SignInScreen(),
      ),
      GoRoute(
        path: sign_up_screen,
        builder: (context, state) => SignUpScreen(),
      ),
      GoRoute(
        path: otp_screen,
        builder: (context, state) {
          final phoneNumber = state.extra as String;
          return OTPVerificationScreen(phoneNumber: phoneNumber);
        },
      ),
      GoRoute(
        path: notification_screen,
        builder: (context, state) => NotificationScreen(),
      ),
      GoRoute(
        path: paymentMethodThirdScreen,
        builder: (context, state) => PaymentMethodThirdScreen(),
      ),
      GoRoute(
        path: chatsListScreen,
        builder: (context, state) => ChatsListScreen(),
      ),
      GoRoute(path: chatScreen, builder: (context, state) => ChatScreen()),
      GoRoute(
        path: AppRoutes.paymentMethodSecondScreen,
        builder: (context, state) {
          final method = state.extra as String;
          return PaymentMethodSecondScreen(methodName: method);
        },
      ),

      GoRoute(
        path: paymentMethodScreen,
        builder: (context, state) => PaymentMethodScreen(),
      ),

      GoRoute(
        path: AppRoutes.addCard,
        builder: (context, state) {
          final method = state.extra as String;
          return AddCardScreen(methodName: method);
        },
      ),

      GoRoute(
        path: settingScreen,
        builder: (context, state) => SettingScreen(),
      ),
      GoRoute(
        path: profileScreen,
        builder: (context, state) {
          return BlocProvider(
            create: (context) => ProfileCubit(
              ProfileRepository(ProfileRemoteDataSource(ApiServices())),
            )..getProfile(),
            child: ProfileScreen(),
          );
        },
      ),

      GoRoute(
        path: privacyPolicyScreen,
        builder: (context, state) => PrivacyPolicyScreen(),
      ),
      GoRoute(path: faqsSreen, builder: (context, state) => FaqsScreen()),
      GoRoute(
        path: AppRoutes.doctorDetailsScreen,
        builder: (context, state) => DoctorDetailsScreen(),
      ),
      GoRoute(
        path: AppRoutes.confirmAppointmentScreen,
        builder: (context, state) => ConfirmAppointmentScreen(),
      ),
      GoRoute(
        path: AppRoutes.payAfterScheduleScreen,
        builder: (context, state) => PayAfterScheduleScreen(),
      ),
      GoRoute(
        path: AppRoutes.addReviewScreen,
        builder: (context, state) => AddReviewScreen(),
      ),
      GoRoute(
        path: AppRoutes.bookingScreen,
        builder: (context, state) => BookingScreen(),
      ),
      GoRoute(
        path: AppRoutes.rescheduleScreen,
        builder: (context, state) => RescheduleView(),
      ),
    ],
  );
}
