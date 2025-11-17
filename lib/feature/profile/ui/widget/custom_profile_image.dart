import 'package:flutter/material.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_icons.dart';

class CustomProfileImage extends StatelessWidget {
  final String imageAsset;
  final bool isNetwork;

  const CustomProfileImage({
    super.key,
    required this.imageAsset,
    required this.isNetwork,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 35,
      backgroundColor: Colors.grey.shade200,
      child: Image.asset(
        AppIcons.person,
        width: 40,
        height: 40,
      ),
    );
  }
}
