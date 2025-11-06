import 'package:go_router/go_router.dart';
import 'package:round_7_mobile_cure_team3/feature/doctors_nearby/presentation/doctors_nearby.dart';
import 'package:round_7_mobile_cure_team3/feature/favourites/presentation/favourites.dart';
import 'package:round_7_mobile_cure_team3/feature/home/presentation/home.dart';
import 'package:round_7_mobile_cure_team3/feature/map/presentation/map.dart';
import 'package:round_7_mobile_cure_team3/feature/search/presentation/search_screen.dart';

import '../../feature/onboarding/presentation/onboarding_screen.dart';

abstract class AppRoutes {
  static const String favourites = '/favourites';
  static const String doctorsNearby = '/doctorsNearby';
  static const String search = '/search';
  static const String map = '/map';

  static final router = GoRouter(
    routes: [
      GoRoute(
        path: 'onboarding',
        builder: (context, state) => OnboardingScreen(),
      ),
      GoRoute(path: '/', builder: (context, state) => Home()),
      GoRoute(path: favourites, builder: (context, state) => Favourites()),
      GoRoute(
        path: doctorsNearby,
        builder: (context, state) => DoctorsNearby(),
      ),
      GoRoute(path: search, builder: (context, state) => SearchScreen()),
      GoRoute(path: map, builder: (context, state) => MapScreen()),
    ],
  );
}
