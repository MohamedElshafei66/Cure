import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:round_7_mobile_cure_team3/core/constants/auth_provider.dart';
import 'package:round_7_mobile_cure_team3/core/constants/secure_storage_data.dart';
import 'package:round_7_mobile_cure_team3/feature/auth/Sign%20In/presentation/view/sign_in_screen.dart';
import 'package:round_7_mobile_cure_team3/main_layout.dart';
import 'package:round_7_mobile_cure_team3/feature/onboarding/presentation/view/onboarding_screen.dart';
import 'package:round_7_mobile_cure_team3/feature/splash/splash_screen.dart';

class AppStartupLogic extends StatefulWidget {
  const AppStartupLogic({super.key});

  @override
  State<AppStartupLogic> createState() => _AppStartupLogicState();
}

class _AppStartupLogicState extends State<AppStartupLogic> {
  late SecureStorageService secureStorage;
  Widget? _startScreen;

  @override
  void initState() {
    super.initState();
    secureStorage = Provider.of<SecureStorageService>(context, listen: false);
    _determineStartScreen();
  }

  Future<void> _determineStartScreen() async {
    final isFirstTime = await secureStorage.read(key: 'isFirstTime');
    final token = await secureStorage.read(key: 'accessToken');
    final refreshToken = await secureStorage.read(key: 'refreshToken');

    if (token != null && refreshToken != null) {
      context.read<AuthProvider>().setTokens(
        accessToken: token,
        refreshToken: refreshToken,
      );
    }

    Widget screen;

    if (isFirstTime == null) {
      await secureStorage.write(key: 'isFirstTime', value: 'false');
      screen = const OnBoardingScreen();
    } else if (token != null && token.isNotEmpty) {
      screen = const MainLayout();
    } else {
      screen = const SignInScreen();
    }

    if (!mounted) return;
    setState(() {
      _startScreen = screen;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_startScreen == null) {
      return SplashScreen();
    }
    return _startScreen!;
  }
}
