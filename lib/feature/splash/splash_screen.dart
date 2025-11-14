import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:round_7_mobile_cure_team3/core/constants/secure_storage_data.dart';
import 'package:round_7_mobile_cure_team3/core/routes/app_routes.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_colors.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_images.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int activeIndex = 0;
  Timer? _timer;

  final SecureStorageService _storage = SecureStorageService();

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      setState(() {
        activeIndex = (activeIndex + 1) % 4;
      });
    });


    Future.delayed(const Duration(seconds: 2), () async {
      if (!mounted) return;

      final token = await _storage.read(key: 'accessToken');

      if (token != null && token.isNotEmpty) {
        context.go(AppRoutes.home);
      } else {
        context.go(AppRoutes.onBoarding_screen); 
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: Image.asset(
              AppImages.logoImage,
              width: size.width * 0.18,
              height: size.width * 0.18,
              color: Colors.white,
            ),
          ),
          Positioned(
            bottom: size.height * 0.08,
            child: AnimatedSmoothIndicator(
              activeIndex: activeIndex,
              count: 4,
              effect: ScaleEffect(
                activeDotColor: Colors.white,
                dotColor: Colors.white.withOpacity(0.6),
                dotWidth: size.width * 0.025,
                dotHeight: size.width * 0.025,
                radius: size.width * 0.025,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
