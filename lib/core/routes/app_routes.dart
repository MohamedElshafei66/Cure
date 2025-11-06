import 'package:go_router/go_router.dart';
import 'package:round_7_mobile_cure_team3/feature/booking/presentation/views/booking_view.dart';
import 'package:round_7_mobile_cure_team3/feature/booking/presentation/views/reschedule_view.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/views/add_review_view.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/views/confirm_appointment_view.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/views/doctor_details_view.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/views/pay_after_schedule.dart';
import 'package:round_7_mobile_cure_team3/feature/auth/Sign%20In/view/sign_in_screen.dart';
import 'package:round_7_mobile_cure_team3/feature/auth/otp/presentation/otp_screen.dart';
import 'package:round_7_mobile_cure_team3/feature/auth/sign%20up/sign_up_screen.dart';
import 'package:round_7_mobile_cure_team3/feature/chat/presentation/chat_screen.dart';
import 'package:round_7_mobile_cure_team3/feature/chat/presentation/chats_list_screen.dart';
import 'package:round_7_mobile_cure_team3/feature/notifications/presentation/view/notification_screen.dart';
import 'package:round_7_mobile_cure_team3/feature/onboarding/presentation/view/onboarding_screen.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/ui/faqs_screen.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/ui/payment_method_screen.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/ui/payment_method_second_screen.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/ui/payment_method_third_screen.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/ui/privacy_policy_screen.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/ui/profile_screen.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/ui/setting_screen.dart';
import 'package:round_7_mobile_cure_team3/feature/splash/splash_screen.dart';
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

  static final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => SplashScreen(),
        ),
        GoRoute(
          path:AppRoutes.doctorDetailsScreen,
          builder: (context, state) => DoctorDetailsScreen(),
        ),
        GoRoute(
          path:AppRoutes.bookingScreen,
          builder: (context, state) => BookingScreen(),
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
        GoRoute(
          path: paymentMethodThirdScreen,
          builder: (context, state) => PaymentMethodThirdScreen(),
        ),
        GoRoute(
          path: chatsListScreen,
          builder: (context, state) => ChatsListScreen(),
        ),
        GoRoute(
          path: chatScreen,
          builder: (context, state) => ChatScreen(),
        ),
        GoRoute(
          path: paymentMethodSecondScreen,
          builder: (context, state) => PaymentMethodSecondScreen(),
        ),
        GoRoute(
          path: paymentMethodScreen,
          builder: (context, state) => PaymentMethodScreen(),
        ),
        GoRoute(
          path: settingScreen,
          builder: (context, state) => SettingScreen(),
        ),
        GoRoute(
          path: profileScreen,
          builder: (context, state) => ProfileScreen(),
        ),
        GoRoute(
          path: privacyPolicyScreen,
          builder: (context, state) => PrivacyPolicyScreen(),
        ),
        GoRoute(
            path: faqsSreen,
            builder: (context, state) => FaqsScreen()
        ),
      ]
  );
}

