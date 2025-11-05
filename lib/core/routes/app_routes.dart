import 'package:go_router/go_router.dart';
import 'package:round_7_mobile_cure_team3/feature/chat/presentation/chat_screen.dart';
import 'package:round_7_mobile_cure_team3/feature/chat/presentation/chats_list_screen.dart';
import '../../feature/onboarding/presentation/onboarding_screen.dart';

abstract class AppRoutes{
  static String chatsListScreen="/";
  static String chatScreen="/chat_screen";
 static final router = GoRouter(
    routes: [
      // GoRoute(
      //   path: '/',
      //   builder: (context, state) => OnboardingScreen(),
      // ),
      GoRoute(
        path: '/',
        builder: (context, state) => ChatsListScreen(),
      ),

      GoRoute(
        path: chatScreen,
        builder: (context, state) => ChatScreen(),
      ),

    ],
  );
}