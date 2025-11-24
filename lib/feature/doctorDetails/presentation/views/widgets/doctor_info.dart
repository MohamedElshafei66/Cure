import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:svg_image/svg_image.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_images.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../domain/entites/doctor_details_entity.dart';
import '../../../../doctors/data/models/doctor_model.dart';
import '../../../../favourites/presentation/cubits/favourties_cubit.dart';
import '../../../../favourites/presentation/cubits/favourties_state.dart';

class DoctorInfo extends StatefulWidget {
  final DoctorDetailsEntity? doctorDetails;
  final String? fallbackImageUrl;
  const DoctorInfo({super.key, this.doctorDetails, this.fallbackImageUrl});
  @override
  State<DoctorInfo> createState() => _DoctorInfoState();
}

class _DoctorInfoState extends State<DoctorInfo> {
  bool _useHomeFallbackImage = false;

  bool _getIsFavourite(FavouritesState state) {
    if (widget.doctorDetails == null) return false;
    
    if (state is FavouriteLoaded) {
      final doctorId = widget.doctorDetails!.doctorId;
      return state.doctors?.any((doctor) => doctor.id == doctorId) ?? false;
    }
    return false;
  }

  Future<void> _toggleFavourite(bool currentIsFavorite) async {
    if (widget.doctorDetails == null) return;

    try {
      // Check if FavouritesCubit is available
      final favouritesCubit = context.read<FavouritesCubit>();
      
      // Convert DoctorDetailsEntity to DoctorModel
      final doctorModel = DoctorModel(
        id: widget.doctorDetails!.doctorId,
        fullName: widget.doctorDetails!.doctorName,
        about: widget.doctorDetails!.doctorAbout,
        imgUrl: widget.doctorDetails!.doctorImage,
        specialityId: 0, // Not available in DoctorDetailsEntity
        specialistTitle: widget.doctorDetails!.doctorSpecialty,
        address: widget.doctorDetails!.doctorLocation,
        rating: widget.doctorDetails!.rating.toDouble(),
        isFavourite: !currentIsFavorite,
        price: widget.doctorDetails!.doctorPrice.toInt(),
      );

      await favouritesCubit.toggleDoctorFavourite(doctorModel);
      
      // Refresh favourites list to sync state
      await favouritesCubit.fetchFavourites();
    } catch (e) {
      // Show error message or do nothing if FavouritesCubit is not available
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to update favourite: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.doctorDetails == null) {
      return const SizedBox.shrink();
    }

    // Check if FavouritesCubit is available in the widget tree
    final favouritesCubit = _getFavouritesCubit(context);
    
    if (favouritesCubit != null) {
      // FavouritesCubit exists, use BlocBuilder
      return BlocBuilder<FavouritesCubit, FavouritesState>(
        builder: (context, state) {
          final isFavorite = _getIsFavourite(state);
          return _buildContent(isFavorite, true);
        },
      );
    } else {
      // FavouritesCubit is not available, show UI without favourite functionality
      return _buildContent(false, false);
    }
  }

  FavouritesCubit? _getFavouritesCubit(BuildContext context) {
    try {
      return context.read<FavouritesCubit>();
    } catch (e) {
      return null;
    }
  }

  Widget _buildContent(bool isFavorite, bool showFavouriteButton) {
    
    final size = MediaQuery.of(context).size;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildAvatar(size),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Text(
                widget.doctorDetails!.doctorName,
                style: AppStyle.styleRegular20(context).copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: Text(
                      widget.doctorDetails!.doctorSpecialty,
                      style: AppStyle.styleMedium14(context).copyWith(
                        fontWeight: FontWeight.w400,
                        color: AppColors.whiteColor79,
                      ),
                    ),
                  ),
                  if (showFavouriteButton)
                    Expanded(
                      child: GestureDetector(
                        onTap: () => _toggleFavourite(isFavorite),
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: AppColors.lightGrey,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? Colors.red : AppColors.textPrimary,
                          ),
                        ),
                      ),
                    )
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  SvgImage(
                    AppImages.locationImage,
                    type: PathType.assets,
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      widget.doctorDetails!.doctorLocation,
                      style: AppStyle.styleMedium14(context).copyWith(
                        fontWeight: FontWeight.w400,
                        color: AppColors.whiteColor79,
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

  Widget _buildAvatar(Size size) {
    final radius = size.width * 0.12;
    final diameter = radius * 2;
    final doctorImageUrl = _resolveDoctorImageUrl();
    final homeFallbackUrl = _resolveFallbackUrl();

    final bool shouldUseHomeFallback =
        _useHomeFallbackImage || doctorImageUrl == null;
    final String? imageUrl =
        shouldUseHomeFallback ? homeFallbackUrl : doctorImageUrl;

    if (imageUrl == null || imageUrl.isEmpty) {
      return CircleAvatar(
        radius: radius,
        backgroundImage: const AssetImage(AppImages.doctorImage),
      );
    }

    return CircleAvatar(
      radius: radius,
      backgroundColor: AppColors.lightGrey,
      child: ClipOval(
        child: Image.network(
          imageUrl,
          width: diameter,
          height: diameter,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) {
            if (!_useHomeFallbackImage &&
                doctorImageUrl != null &&
                homeFallbackUrl != null) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted) {
                  setState(() => _useHomeFallbackImage = true);
                }
              });
            }
            return Image.asset(
              AppImages.doctorImage,
              width: diameter,
              height: diameter,
              fit: BoxFit.cover,
            );
          },
        ),
      ),
    );
  }

  String? _resolveDoctorImageUrl() {
    final doctorImage = widget.doctorDetails?.doctorImage.trim();
    if (doctorImage == null || doctorImage.isEmpty) return null;
    return doctorImage.startsWith('http')
        ? doctorImage
        : 'https://cure-doctor-booking.runasp.net/$doctorImage';
  }

  String? _resolveFallbackUrl() {
    final fallbackUrl = widget.fallbackImageUrl?.trim();
    if (fallbackUrl == null || fallbackUrl.isEmpty) return null;
    return fallbackUrl;
  }
}

