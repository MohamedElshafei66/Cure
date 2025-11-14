import 'package:flutter/material.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_images.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_styles.dart';

class EmptyBodyWidget extends StatelessWidget {
  const EmptyBodyWidget({
    required this.imagePath,
    required this.mainTitle,
    required this.subTitle,
    super.key,
  });
  final String imagePath;
  final String mainTitle;
  final String subTitle;
  @override
  Widget build(BuildContext context) {
    
    final size = MediaQuery.sizeOf(context);
    return Align(
      child: Column(
        children: [
          SizedBox(height: size.height * .2),
          Container(
            height: size.height * .2,
            width: size.width * .4,
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(imagePath)),
            ),
          ),
          Text(
            mainTitle,
            style: AppStyle.styleRegular24(context),
            ),

          Text(
            textAlign: TextAlign.center,
            subTitle,
            style: AppStyle.styleMedium16(context),
          ),
        ],
      ),
    );
  }
}