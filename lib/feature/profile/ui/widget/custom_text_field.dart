// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_colors.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_styles.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String? prefixIcon;
  final String? suffixIcon;
  final String? label;
  final TextInputType keyboardType;
  final void Function()? onTap;
  final String? Function(String?) validator;
  CustomTextField({
    required this.controller,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    required this.keyboardType,
    this.onTap,
    this.label,
    required this.validator,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late FocusNode focusNode;
  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
    focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isFocused = focusNode.hasFocus;

    Color iconColor = isFocused ? Colors.blue : Colors.grey;
    Color hintColor = isFocused ? Colors.blue : Colors.grey;
    Color labelColor = isFocused ? Colors.blue : Colors.grey[700]!;

    return TextFormField(
      controller: widget.controller,

      keyboardType: widget.keyboardType,
      onTap: widget.onTap,
      focusNode: focusNode,
      validator: widget.validator,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9@._\-]')),
      ],

      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.lightGrey,
        hintText: widget.hintText,
        labelText: widget.label,
        labelStyle: AppStyle.styleMedium16(
          context,
        ).copyWith(color: Colors.grey).copyWith(color: labelColor),

        hintStyle: AppStyle.styleMedium16(
          context,
        ).copyWith(color: Colors.grey).copyWith(color: hintColor),
        suffixIcon: widget.suffixIcon == null
            ? null
            : Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Image.asset(widget.suffixIcon!, height: 20, width: 20),
              ),

        prefixIcon: widget.prefixIcon == null
            ? null
            : Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Image.asset(
                  widget.prefixIcon!,
                  color: iconColor,
                  height: 24,
                  width: 24,
                ),
              ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 18,
          horizontal: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primary),
        ),
      ),
    );
  }
}
