import 'package:flutter/material.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_colors.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_icons.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_styles.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({
    super.key,
    required this.controller,
    this.onSubmitted,
    this.onChanged,
    this.onReset,
    this.showIcons = false,
  });

  final TextEditingController controller;
  final void Function(String value)? onSubmitted;
  final void Function(String value)? onChanged;
  final VoidCallback? onReset;
  final bool showIcons;

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextChanged);
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final hasText = widget.controller.text.isNotEmpty;
    final shouldShowIcons = hasText || widget.showIcons;

    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: SearchBar(
        onSubmitted: widget.onSubmitted,
        onChanged: widget.onChanged,
        elevation: WidgetStateProperty.all<double>(1),
        backgroundColor: WidgetStateProperty.all<Color>(AppColors.lightGrey),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
        leading: Image.asset(AppIcons.search),
        controller: widget.controller,
        hintText: 'Search for specialty, doctor',
        hintStyle: WidgetStateProperty.all<TextStyle>(
          TextStyle(
            fontSize: getResponsive(context, fontSize: 14),
            fontWeight: FontWeight.w400,
            fontFamily: 'Montserrat',
            color: Color(0xff6D7379),
          ),
        ),
        trailing: [
          if (shouldShowIcons)
            IconButton(
              icon: Image.asset(AppIcons.delete),
              onPressed: () {
                widget.controller.clear();
                widget.onReset?.call();
              },
              iconSize: 20,
            ),
          if (shouldShowIcons && hasText)
            IconButton(
              icon: Image.asset(AppIcons.search),
              onPressed: () {
                final value = widget.controller.text.trim();
                if (value.isNotEmpty) {
                  widget.onSubmitted?.call(value);
                }
              },
              iconSize: 20,
            ),
        ],
      ),
    );
  }
}
