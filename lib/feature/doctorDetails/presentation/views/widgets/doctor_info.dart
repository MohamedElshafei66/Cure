import 'package:flutter/material.dart';
import 'package:svg_image/svg_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_images.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/utils/app_styles.dart';

class DoctorInfo extends StatefulWidget {
  const DoctorInfo({super.key});
  @override
  State<DoctorInfo> createState() => _DoctorInfoState();
}

class _DoctorInfoState extends State<DoctorInfo> {
  bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: size.width * 0.12,
          backgroundImage:CachedNetworkImageProvider('https://images.unsplash.com/photo-1550831107-1553da8c8464'),
        ),
        const SizedBox(
            width: 16
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height:8,
              ),
              Text(
                  AppStrings.doctorName,
                  style:AppStyle.styleRegular20(context).copyWith(
                      color:AppColors.textPrimary
                  )
              ),
              const SizedBox(
                  height:4
              ),
             Row(
               children:[
                 Expanded(
                   flex:5,
                   child: Text(
                     AppStrings.doctorSpeciality,
                     style:AppStyle.styleMedium14(context).copyWith(
                         fontWeight:FontWeight.w400,
                         color:AppColors.whiteColor79
                     ),
                   ),
                 ),
                 Expanded(
                   child:GestureDetector(
                     onTap: () {
                       setState(() {
                         isFavorite = !isFavorite;
                       });
                     },
                     child:Container(
                       padding:const EdgeInsets.all(6),
                       decoration:BoxDecoration(
                         color:AppColors.lightGrey,
                         shape: BoxShape.circle,
                       ),
                       child: Icon(
                         isFavorite ? Icons.favorite : Icons.favorite_border,
                         color: isFavorite ? Colors.red :AppColors.textPrimary,
                       ),
                     ),
                   ),
                 )
               ],
             ),
              const SizedBox(
                  height:4
              ),
              Row(
                children:  [
                  SvgImage(
                      AppImages.locationImage,
                      type:PathType.assets
                  ),
                  SizedBox(
                      width: 4
                  ),
                  Expanded(
                    child: Text(
                      AppStrings.doctorLocation,
                      style:AppStyle.styleMedium14(context).copyWith(
                          fontWeight:FontWeight.w400,
                          color:AppColors.whiteColor79
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

