import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_icons.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_styles.dart';
import 'package:round_7_mobile_cure_team3/feature/favourites/presentation/cubits/favourties_cubit.dart';
import 'package:round_7_mobile_cure_team3/feature/favourites/presentation/cubits/favourties_state.dart';
import 'package:round_7_mobile_cure_team3/feature/favourites/presentation/widgets/favourites_empty_view.dart';
import 'package:round_7_mobile_cure_team3/feature/favourites/presentation/widgets/favourites_error_view.dart';
import 'package:round_7_mobile_cure_team3/feature/favourites/presentation/widgets/favourites_list_view.dart';

class Favourites extends StatelessWidget {
  const Favourites({super.key});

  @override
  Widget build(BuildContext context) {
    // Refresh favourites list when screen opens
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
            if (state is FavouriteLoading) {
              return const Center(child: CircularProgressIndicator());
            }

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
              // Check if error is 404 or "no favourites" related
              final errorMessage = state.error.toLowerCase();
              if (errorMessage.contains('404') ||
                  errorMessage.contains('not found') ||
                  errorMessage.contains('no favourites')) {
                return const Center(child: FavouritesEmptyView());
              }

              // For other errors, show error message with retry button
              return FavouritesErrorView(errorMessage: state.error);
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
