import 'package:flutter/material.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_icons.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_images.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_styles.dart';
import 'package:round_7_mobile_cure_team3/feature/home/presentation/widgets/doctor_card.dart';

class Favourites extends StatelessWidget {
  const Favourites({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> favourites = [
      DoctorCard(isFavourite: true),
      DoctorCard(isFavourite: true),
      DoctorCard(isFavourite: true),
      DoctorCard(isFavourite: true),
    ];
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
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: favourites.isEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(AppImages.yourFavDoctorsImage),
                    Text(
                      'Your favorite!',
                      style: AppStyle.styleRegular20(context),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Add your favorite to find it easily',
                      style: AppStyle.styleMedium12(context),
                    ),
                  ],
                )
              : ListView.builder(
                  itemBuilder: (context, index) {
                    return favourites[index];
                  },
                  itemCount: favourites.length,
                ),
        ),
      ),
    );
  }
}
