import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_icons.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_images.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_styles.dart';
import 'package:round_7_mobile_cure_team3/feature/favourites/presentation/cubits/favourties_cubit.dart';
import 'package:round_7_mobile_cure_team3/feature/favourites/presentation/cubits/favourties_state.dart';
import 'package:round_7_mobile_cure_team3/feature/home/presentation/widgets/doctor_card.dart';

import '../../../core/constants/auth_provider.dart';

class Favourites extends StatelessWidget {
  const Favourites({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context){
        final authProvider = context.read<AuthProvider>();
        return FavouritesCubit(authProvider: authProvider)..fetchFavourites();
      },
      child: Scaffold(
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
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<FavouritesCubit, FavouritesState>(
            builder: (context, state) {
              if (state is FavouriteLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is FavouriteLoaded) {
                if (state.doctors?.isEmpty ?? true) {
                  return Center(child: _buildEmptyView(context));
                }
                return ListView.builder(
                  itemCount: state.doctors!.length,
                  itemBuilder: (context, index) =>
                      DoctorCard(doctor: state.doctors![index]),
                );
              } else if (state is FavouriteEmpty) {
                return Center(child: _buildEmptyView(context));
              } else if (state is FavouriteError) {
                // Check if error is 404 or "no favourites" related
                final errorMessage = state.error.toLowerCase();
                if (errorMessage.contains('404') || 
                    errorMessage.contains('not found') ||
                    errorMessage.contains('no favourites')) {
                  return Center(child: _buildEmptyView(context));
                }
                // For other errors, show error message
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        state.error,
                        style: AppStyle.styleMedium14(context),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          context.read<FavouritesCubit>().fetchFavourites();
                        },
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyView(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(AppImages.yourFavDoctorsImage),
        const SizedBox(height: 12),
        Text(
          'No favorite doctors yet',
          style: AppStyle.styleRegular20(context),
        ),
        const SizedBox(height: 8),
        Text(
          'Add your favorite doctors to find them easily',
          style: AppStyle.styleMedium12(context),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}