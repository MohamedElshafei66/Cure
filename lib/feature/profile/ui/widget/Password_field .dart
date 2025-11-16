import 'package:flutter/material.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_colors.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_icons.dart';
class PasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
   final String? Function(String?) validator;

  const PasswordField({
    required this.controller,
    required this.hintText,
    required this.validator
  });

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool isHidden = true;
  

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,

      obscureText: isHidden,
      
      decoration: InputDecoration(
        hintText: widget.hintText,
        filled: true,
        fillColor: AppColors.lightGrey,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              isHidden = !isHidden;
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Image.asset(
              isHidden ? AppIcons.eye : AppIcons.eyelash,
              width: 22,
              height: 22,
            ),
          ),
        ),
      ),
    );
  }
}
