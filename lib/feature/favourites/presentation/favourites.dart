import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_icons.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_styles.dart';
import 'package:round_7_mobile_cure_team3/feature/favourites/presentation/cubits/favourties_cubit.dart';
import 'package:round_7_mobile_cure_team3/feature/favourites/presentation/cubits/favourties_state.dart';
import 'package:round_7_mobile_cure_team3/feature/favourites/presentation/widgets/favourites_empty_view.dart';
import 'package:round_7_mobile_cure_team3/feature/favourites/presentation/widgets/favourites_error_view.dart';
import 'package:round_7_mobile_cure_team3/feature/favourites/presentation/widgets/favourites_list_view.dart';
import 'package:skeletonizer/skeletonizer.dart';

class Favourites extends StatelessWidget {
  const Favourites({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.mounted) {
        context.read<FavouritesCubit>().fetchFavourites();
      }
    });

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Image.asset(AppIcons.arrowBackPng),
        ),
        title: Text('Your Favorite', style: AppStyle.styleRegular20(context)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: BlocBuilder<FavouritesCubit, FavouritesState>(
          builder: (context, state) {
            final loading = state is FavouriteLoading;
            return Skeletonizer(
              enableSwitchAnimation: true,
              enabled: loading,
              child: Builder(
                builder: (context) {
                  if (state is FavouriteLoaded) {
                    if (state.doctors?.isEmpty ?? true) {
                      return const Center(child: FavouritesEmptyView());
                    }
                    return FavouritesListView(doctors: state.doctors!);
                  }

                  if (state is FavouriteEmpty) {
                    return const Center(child: FavouritesEmptyView());
                  }

                  if (state is FavouriteError) {
                    final errorMessage = state.error.toLowerCase();

                    if (errorMessage.contains('404') ||
                        errorMessage.contains('not found') ||
                        errorMessage.contains('no favourites')) {
                      return const Center(child: FavouritesEmptyView());
                    }

                    return FavouritesErrorView(errorMessage: state.error);
                  }

                  if (loading) {
                    return ListView.builder(
                      itemCount: 4,
                      itemBuilder: (_, index) {
                        return Container(
                          margin: const EdgeInsets.only(top: 16),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: Colors.grey.shade300,
                              width: 1.4,
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Skeleton Image
                              Container(
                                width: 82,
                                height: 82,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              const SizedBox(width: 10),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      height: 16,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade300,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    // Specialty
                                    Container(
                                      width: 120,
                                      height: 14,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade300,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    // Location
                                    Container(
                                      width: 100,
                                      height: 12,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade300,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    // Rating and Price row
                                    Row(
                                      children: [
                                        Container(
                                          width: 60,
                                          height: 12,
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade300,
                                            borderRadius: BorderRadius.circular(
                                              4,
                                            ),
                                          ),
                                        ),
                                        const Spacer(),
                                        Container(
                                          width: 50,
                                          height: 14,
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade300,
                                            borderRadius: BorderRadius.circular(
                                              4,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 10),

                              // Skeleton Heart Icon
                              Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
