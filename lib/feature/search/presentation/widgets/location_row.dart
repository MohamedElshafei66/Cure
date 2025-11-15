import 'package:flutter/material.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_styles.dart';

class LocationRow extends StatelessWidget {
  final VoidCallback onLocationPressed;

  const LocationRow({super.key, required this.onLocationPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Text(
            'Search by your location',
            style: AppStyle.styleRegular16(context),
          ),
        ),
        FittedBox(
          fit: BoxFit.fill,
          child: TextButton(
            onPressed: onLocationPressed,
            child: Text(
              '129, El-Nasr Street, Cairo',
              style: AppStyle.styleMedium14(context),
            ),
          ),
        ),
      ],
    );
  }
}
