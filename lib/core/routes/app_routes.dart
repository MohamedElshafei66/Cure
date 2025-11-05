import 'package:go_router/go_router.dart';
import 'package:round_7_mobile_cure_team3/feature/chat/presentation/chat_screen.dart';
import 'package:round_7_mobile_cure_team3/feature/chat/presentation/chats_list_screen.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/ui/faqs_screen.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/ui/payment_method_screen.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/ui/payment_method_second_screen.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/ui/payment_method_third_screen.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/ui/privacy_policy_screen.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/ui/profile_screen.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/ui/setting_screen.dart';
import '../../feature/onboarding/presentation/onboarding_screen.dart';

abstract class AppRoutes {
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
    initialLocation: profileScreen,
    routes: [
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
      GoRoute(path: faqsSreen, builder: (context, state) => FaqsScreen()),

      GoRoute(path: '/', builder: (context, state) => OnboardingScreen()),
    ],
  );
}
