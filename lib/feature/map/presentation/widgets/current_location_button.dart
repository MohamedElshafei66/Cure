import 'package:flutter/material.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_colors.dart';

class CurrentLocationButton extends StatelessWidget {
  final VoidCallback onPressed;

  const CurrentLocationButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomRight,
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 120),
      child: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: onPressed,
        child: const Icon(Icons.my_location, color: AppColors.primary),
      ),
    );
  }
}

