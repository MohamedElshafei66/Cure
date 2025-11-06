import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_colors.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_icons.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_images.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_styles.dart';
import 'package:round_7_mobile_cure_team3/feature/map/helpers/location_helper.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Position? position;
  final Completer<GoogleMapController> _mapController = Completer();

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  Future<void> getCurrentLocation() async {
    try {
      final pos = await LocationHelper.getCurrentLocation();
      setState(() => position = pos);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  Widget buildMap() {
    final currentCameraPosition = CameraPosition(
      target: LatLng(position!.latitude, position!.longitude),
      zoom: 15,
    );

    return GoogleMap(
      initialCameraPosition: currentCameraPosition,
      mapType: MapType.normal,
      myLocationEnabled: true,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      onMapCreated: (controller) => _mapController.complete(controller),
    );
  }

  Future<void> goToMyCurrentLocation() async {
    final GoogleMapController controller = await _mapController.future;
    final currentPosition = CameraPosition(
      target: LatLng(position!.latitude, position!.longitude),
      zoom: 15,
    );
    controller.animateCamera(CameraUpdate.newCameraPosition(currentPosition));
  }

  Widget loadingIndicator() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 90,
            width: 90,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey.shade300, width: 2),
              image: DecorationImage(
                image: AssetImage(AppImages.profileImage),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "Fetching your location...",
            style: AppStyle.styleMedium14(
              context,
            ).copyWith(color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          position != null ? buildMap() : loadingIndicator(),
          Positioned(
            top: 60,
            left: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: AppColors.lightGrey,
                        shape: BoxShape.rectangle,
                      ),
                      child: Icon(Icons.arrow_back_ios),
                    ),
                  ),
                  const Spacer(),

                  // 📍 Location Info (Centered)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Current location',
                        style: AppStyle.styleMedium16(
                          context,
                        ).copyWith(color: Colors.black),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Image.asset(
                            AppIcons.location,
                            height: 16,
                            color: AppColors.primary,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '129, El-Nasr Street, Cairo',
                            style: AppStyle.styleMedium14(context).copyWith(
                              color: AppColors.primary,
                              decoration: TextDecoration.underline,
                              decorationColor: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const Spacer(),

                  InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(50),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.lightGrey,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(CupertinoIcons.search),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 52,
            left: 16,
            right: 16,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(AppColors.primary),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              onPressed: () {},
              child: Text(
                'Confirm Location',
                style: AppStyle.styleMedium16(
                  context,
                ).copyWith(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Container(
        alignment: Alignment.bottomRight,
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 120),
        child: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: goToMyCurrentLocation,
          child: const Icon(Icons.my_location, color: AppColors.primary),
        ),
      ),
    );
  }
}
