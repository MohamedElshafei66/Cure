import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:svg_image/svg_image.dart';
import '../../../../../core/utils/app_images.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../cubit/add_review_cubit.dart';

class ReviewRate extends StatelessWidget {
  const ReviewRate({super.key});
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddReviewCubit, AddReviewState>(
      builder: (context, state) {
        final cubit = context.read<AddReviewCubit>();
        final rating = cubit.rating;
        
        return Row(
          children: [
            ...List.generate(5, (index) {
              final starIndex = index + 1;
              final isFullStar = rating >= starIndex;
              final isHalfStar = rating > index && rating < starIndex;
              
              return GestureDetector(
                onTap: () {
                  cubit.setRating(starIndex.toDouble());
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: SizedBox(
                    height: 30,
                    width: 30,
                    child: Stack(
                      children: [

                        SvgImage(
                          AppImages.ratingStarImage,
                          type: PathType.assets,
                          height: 30,
                          width: 30,
                        ),

                        if (isFullStar)
                          SvgImage(
                            AppImages.ratingStarImage,
                            type: PathType.assets,
                            height: 30,
                            width: 30,
                          )
                        else if (isHalfStar)

                          ClipRect(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              widthFactor: rating - index,
                              child: SvgImage(
                                AppImages.ratingStarImage,
                                type: PathType.assets,
                                height: 30,
                                width: 30,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              );
            }),
            const Spacer(),
            Text(
              rating > 0 ? '${rating.toStringAsFixed(1)}/5' : '0/5',
              style: AppStyle.styleRegular40(context),
            ),
          ],
        );
      },
    );
  }
}
