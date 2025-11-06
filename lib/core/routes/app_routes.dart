import 'package:go_router/go_router.dart';
import 'package:round_7_mobile_cure_team3/feature/booking/presentation/views/booking_view.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/views/add_review_view.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/views/confirm_appointment_view.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/views/doctor_details_view.dart';
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/views/pay_after_schedule.dart';

abstract class AppRoutes{
  static String doctorDetailsScreen = "/doctorDetailsScreen";
  static String confirmAppointmentScreen = "/confirmAppointment";
  static String payAfterScheduleScreen = "/payAfterScheduleScreen";
  static String addReviewScreen = "/addReviewScreen";
  static String bookingScreen = "/bookingScreen";
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => BookingScreen(),
      ),
      GoRoute(
        path:AppRoutes.confirmAppointmentScreen,
        builder: (context, state) => ConfirmAppointmentScreen(),
      ),
      GoRoute(
        path:AppRoutes.payAfterScheduleScreen,
        builder: (context, state) => PayAfterScheduleScreen(),
      ),
      GoRoute(
        path:AppRoutes.addReviewScreen,
        builder: (context, state) => AddReviewScreen(),
      ),
      GoRoute(
        path:AppRoutes.bookingScreen,
        builder: (context, state) => BookingScreen(),
      ),

    ],
  );
}