import 'package:flutter/material.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_icons.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_styles.dart';

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SearchAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Text('Search', style: AppStyle.styleRegular20(context)),
      centerTitle: true,
      leading: InkWell(
        onTap: () => Navigator.pop(context),
        child: Image.asset(AppIcons.arrowBackPng),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

