import 'package:go_router/go_router.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/views/doctor_details_view.dart';
import '../../feature/onboarding/presentation/onboarding_screen.dart';

abstract class AppRoutes{
  static String doctorDetailsScreen = "/doctorDetailsScreen";
 static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => DoctorDetailsScreen(),
      ),
      GoRoute(
        path:AppRoutes.doctorDetailsScreen,
        builder: (context, state) => DoctorDetailsScreen(),
      ),

    ],
  );
}