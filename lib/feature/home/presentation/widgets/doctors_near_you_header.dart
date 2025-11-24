import 'package:flutter/material.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_styles.dart';

class DoctorsNearYouHeader extends StatelessWidget {
  final VoidCallback onViewAllTap;

  const DoctorsNearYouHeader({
    super.key,
    required this.onViewAllTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Doctors near you',
          style: AppStyle.styleRegular20(context),
        ),
        const Spacer(),
        TextButton(
          onPressed: onViewAllTap,
          child: Text(
            'View All',
            style: AppStyle.styleMedium14(context),
          ),
        ),
      ],
    );
  }
}

