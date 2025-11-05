import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:svg_image/svg_image.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_images.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/utils/app_styles.dart';
class ReviewCard extends StatelessWidget {
  const ReviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics:NeverScrollableScrollPhysics(),
        shrinkWrap:true,
        itemCount:2,
        itemBuilder:(context,i){
          return  Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color:Colors.white70,
                borderRadius: BorderRadius.circular(16),
              ),
              child:Column(
                children:[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CircleAvatar(
                        radius:30,
                        backgroundImage: CachedNetworkImageProvider(
                            'https://images.unsplash.com/photo-1550831107-1553da8c8464'
                        ),
                      ),
                      const SizedBox(
                          width: 12
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                "Nabila Reyna",
                                style:AppStyle.styleRegular16(context).copyWith(
                                    color:AppColors.textPrimary
                                )
                            ),
                            const SizedBox(
                                height: 4
                            ),
                            Text(
                                "30 min ago",
                                style:AppStyle.styleMedium14(context).copyWith(
                                    color:AppColors.textHint
                                )
                            ),
                            const SizedBox(height: 8),
                          ],
                        ),
                      ),
                      Container(
                        padding:EdgeInsets.all(5),
                        decoration:BoxDecoration(
                            color:Colors.yellow.shade50,
                            borderRadius:BorderRadius.circular(5)
                        ),
                        child: Row(
                          children:[
                            SvgImage(
                                AppImages.ratingStarImage,
                                type:PathType.assets
                            ),
                            SizedBox(
                                width: 8
                            ),
                            Text(
                                "4.5",
                                style:AppStyle.styleMedium14(context).copyWith(
                                    color:AppColors.yellow,
                                    fontWeight:FontWeight.w900
                                )
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                  SizedBox(
                    height:9,
                  ),
                  Text(
                      AppStrings.reviewText,
                      style:AppStyle.styleMedium14(context).copyWith(
                          color:AppColors.whiteColor79
                      )
                  ),
                ],
              )
          );
        }
    );
  }
}
