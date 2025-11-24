import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_styles.dart';
import 'package:round_7_mobile_cure_team3/feature/favourites/presentation/cubits/favourties_cubit.dart';

class FavouritesErrorView extends StatelessWidget {
  final String errorMessage;

  const FavouritesErrorView({
    super.key,
    required this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              errorMessage,
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
      ),
    );
  }
}

