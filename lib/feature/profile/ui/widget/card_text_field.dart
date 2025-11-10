import 'package:flutter/material.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_colors.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_styles.dart';

class CardTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;

  const CardTextField({
    Key? key,
    required this.controller,
    required this.hintText,
  }) : super(key: key);

  @override
  State<CardTextField> createState() => _CardTextFieldState();
}

class _CardTextFieldState extends State<CardTextField> {
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: TextInputType.number,
      obscureText: !isVisible,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.lightGrey,
        hintText: widget.hintText,
        hintStyle: AppStyle.styleMedium16(context).copyWith(color: Colors.grey),
        suffixIcon: IconButton(
          icon: Icon(
            isVisible ? Icons.visibility : Icons.visibility_off,
            color: Colors.grey.shade700,
          ),
          onPressed: () {
            setState(() {
              isVisible = !isVisible;
            });
          },
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
