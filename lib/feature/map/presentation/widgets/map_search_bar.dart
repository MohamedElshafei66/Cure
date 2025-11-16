import 'package:flutter/material.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_colors.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_icons.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_styles.dart';

class MapSearchBar extends StatelessWidget {
  final bool isSearching;
  final TextEditingController searchController;
  final String currentAddress;
  final bool isLoadingAddress;
  final VoidCallback onBackPressed;
  final VoidCallback onSearchToggle;

  const MapSearchBar({
    super.key,
    required this.isSearching,
    required this.searchController,
    required this.currentAddress,
    this.isLoadingAddress = false,
    required this.onBackPressed,
    required this.onSearchToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
            onTap: onBackPressed,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: AppColors.lightGrey,
              ),
              child: const Icon(Icons.arrow_back_ios),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: isSearching
                ? TextField(
                    controller: searchController,
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: 'Search location...',
                      hintStyle: AppStyle.styleMedium14(
                        context,
                      ).copyWith(color: Colors.grey),
                      border: InputBorder.none,
                      isDense: true,
                    ),
                    style: AppStyle.styleMedium14(context),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
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
                          Expanded(
                            child: isLoadingAddress
                                ? Text(
                                    'Loading address...',
                                    style: AppStyle.styleMedium14(
                                      context,
                                    ).copyWith(color: Colors.grey),
                                    overflow: TextOverflow.ellipsis,
                                  )
                                : Text(
                                    currentAddress,
                                    style: AppStyle.styleMedium14(context)
                                        .copyWith(
                                          color: AppColors.primary,
                                          decoration: TextDecoration.underline,
                                          decorationColor: AppColors.primary,
                                        ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                          ),
                        ],
                      ),
                    ],
                  ),
          ),
          const SizedBox(width: 12),
          InkWell(
            onTap: onSearchToggle,
            borderRadius: BorderRadius.circular(50),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.lightGrey,
                shape: BoxShape.circle,
              ),
              child: Icon(isSearching ? Icons.close : Icons.search),
            ),
          ),
        ],
      ),
    );
  }
}
