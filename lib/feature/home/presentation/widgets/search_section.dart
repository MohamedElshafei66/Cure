import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:round_7_mobile_cure_team3/core/routes/app_routes.dart';
import 'package:round_7_mobile_cure_team3/core/widgets/custom_search_bar.dart';

class SearchSection extends StatelessWidget {
  final TextEditingController controller;

  const SearchSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.push(AppRoutes.search),
      child: AbsorbPointer(child: CustomSearchBar(controller: controller)),
    );
  }
}
