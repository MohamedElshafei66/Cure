import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:round_7_mobile_cure_team3/core/constants/shared_prefrences.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_colors.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_styles.dart';

class ConfirmLocationButton extends StatelessWidget {
  final Position? position;

  const ConfirmLocationButton({
    super.key,
    required this.position,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: () {
        SharedPrefs().saveLocation(position);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location saved successfully')),
        );
        context.pop(position);
      },
      child: Text(
        'Confirm Location',
        style: AppStyle.styleMedium16(
          context,
        ).copyWith(color: Colors.white),
      ),
    );
  }
}

