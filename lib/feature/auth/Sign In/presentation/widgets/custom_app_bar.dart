import 'package:flutter/material.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_icons.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Image.asset(AppIcons.arrowLeft, height: 24, width: 24),
        ),
      );
  }
}