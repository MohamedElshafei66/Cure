import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:round_7_mobile_cure_team3/core/routes/app_routes.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_colors.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_icons.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_images.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_styles.dart';
import 'package:round_7_mobile_cure_team3/feature/doctors/data/models/doctor_model.dart';
import 'package:round_7_mobile_cure_team3/feature/favourites/presentation/cubits/favourties_cubit.dart';
import 'package:round_7_mobile_cure_team3/feature/favourites/presentation/cubits/favourties_state.dart';

class DoctorCard extends StatefulWidget {
  final DoctorModel doctor;

  const DoctorCard({super.key, required this.doctor});

  @override
  State<DoctorCard> createState() => _DoctorCardState();
}

class _DoctorCardState extends State<DoctorCard> {
  bool _getIsFavourite(FavouritesState state) {
    if (state is FavouriteLoaded) {
      return state.doctors?.any((doctor) => doctor.id == widget.doctor.id) ?? false;
    }
    return widget.doctor.isFavourite;
  }

  Future<void> _toggleFavourite(bool currentIsFavorite) async {
    try {
      await context.read<FavouritesCubit>().toggleDoctorFavourite(
        widget.doctor,
      );
      // Refresh favourites list to sync state
      await context.read<FavouritesCubit>().fetchFavourites();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update favourite: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    const double heartSize = 24;

    return BlocBuilder<FavouritesCubit, FavouritesState>(
      builder: (context, state) {
        final isFavourite = _getIsFavourite(state);
        return InkWell(
          onTap: () => context.push(
            AppRoutes.doctorDetailsScreen,
            extra: widget.doctor.id,
          ),
          child: Container(
            margin: const EdgeInsets.only(top: 16),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.grey, width: 1.4),
            ),
            child: Row(
              children: [
                Flexible(
                  child: Image.network(
                    widget.doctor.imgUrl,
                    errorBuilder: (context, error, stackTrace) =>
                        Image.asset(AppImages.doctorImage),
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const Center(child: CircularProgressIndicator());
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.doctor.fullName,
                      style: AppStyle.styleRegular16(context),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          '${widget.doctor.specialistTitle} |',
                          style: AppStyle.styleMedium12(context),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          widget.doctor.address,
                          style: AppStyle.styleMedium12(context),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Image.asset(AppIcons.star),
                        const SizedBox(width: 4),
                        Text(
                          widget.doctor.rating.toString(),
                          style: AppStyle.styleRegular12(context),
                        ),
                        const SizedBox(width: 4),
                        Image.asset(AppIcons.clock),
                        const SizedBox(width: 4),
                        Text(
                          widget.doctor.startDate ?? '9:00 AM',
                          style: AppStyle.styleRegular12(context),
                        ),
                        const SizedBox(width: 4),
                        Text('-', style: AppStyle.styleRegular12(context)),
                        const SizedBox(width: 4),
                        Text(
                          widget.doctor.endDate ?? '5:00 PM',
                          style: AppStyle.styleRegular12(context),
                        ),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                InkWell(
                  onTap: () => _toggleFavourite(isFavourite),
                  child: SizedBox(
                    height: heartSize,
                    width: heartSize,
                    child: isFavourite
                        ? Icon(
                      CupertinoIcons.heart_fill,
                      color: Colors.red,
                      size: heartSize,
                    )
                        : Image.asset(
                      AppIcons.heartPng,
                      color: Colors.black,
                      height: heartSize,
                      width: heartSize,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}