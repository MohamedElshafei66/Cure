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
import 'package:round_7_mobile_cure_team3/feature/doctorDetails/presentation/models/doctor_details_args.dart';
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
      return state.doctors?.any((doctor) => doctor.id == widget.doctor.id) ??
          false;
    }
    return widget.doctor.isFavourite;
  }

  bool _isProcessing = false;

  Future<void> _toggleFavourite(bool isFavourite) async {
    if (_isProcessing) return;

    setState(() => _isProcessing = true);

    try {
      await context.read<FavouritesCubit>().toggleDoctorFavourite(
        widget.doctor,
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to update favourite')));
      }
    } finally {
      if (mounted) {
        setState(() => _isProcessing = false);
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
            extra: DoctorDetailsArgs(
              doctorId: widget.doctor.id,
              fallbackImageUrl: widget.doctor.imgUrl,
            ),
          ),
          child: Container(
            margin: const EdgeInsets.only(top: 16),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.grey, width: 1.4),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // FIX: Fixed width image (no overflow!)
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    widget.doctor.imgUrl,
                    width: 82,
                    height: 82,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Image.asset(
                      AppImages.doctorImage,
                      width: 82,
                      height: 82,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Name row
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              widget.doctor.fullName,
                              style: AppStyle.styleRegular16(context),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),

                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              '${widget.doctor.specialistTitle} | ${widget.doctor.address}',
                              style: AppStyle.styleMedium12(context),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 5),

                      // Rating & Time
                      Row(
                        children: [
                          Image.asset(AppIcons.star, height: 14),
                          const SizedBox(width: 4),
                          Text(
                            widget.doctor.rating.toString(),
                            style: AppStyle.styleRegular12(context),
                          ),
                          const SizedBox(width: 10),
                          Image.asset(AppIcons.clock, height: 14),
                          const SizedBox(width: 4),
                          Flexible(
                            child: Text(
                              '${widget.doctor.startDate ?? '9:00 AM'} - ${widget.doctor.endDate ?? '5:00 PM'}',
                              style: AppStyle.styleRegular12(context),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 6),

                // Heart (does not overflow)
                GestureDetector(
                  onTap: () => _toggleFavourite(isFavourite),
                  child: SizedBox(
                    width: heartSize,
                    height: heartSize,
                    child: _isProcessing
                        ? const Center(
                            child: SizedBox(
                              height: 16,
                              width: 16,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          )
                        : isFavourite
                        ? Icon(
                            CupertinoIcons.heart_fill,
                            color: Colors.red,
                            size: heartSize,
                          )
                        : Image.asset(
                            AppIcons.heartPng,
                            height: heartSize,
                            width: heartSize,
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
