import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/services.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_colors.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_styles.dart';
import 'package:country_code_picker/country_code_picker.dart';

class CustomPhoneField extends StatelessWidget {
  const CustomPhoneField({
    super.key,
    this.controller,
    this.hintText,
    this.validator,
    this.onCountryChange,
  });

  final TextEditingController? controller;
  final String? hintText;
  final String? Function(String?)? validator;
  final Function(CountryCode)? onCountryChange;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: TextFormField(
        controller: controller,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(11),
        
        ],

        keyboardType: TextInputType.phone,
        validator: validator,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.lightGrey,
          hintText: hintText,
          hintStyle: AppStyle.styleMedium16(context),
          prefixIcon: CountryCodePicker(
            onChanged: onCountryChange,
            initialSelection: 'EG',
            favorite: const ['+20', 'EG'],
            showFlag: true,
            showFlagDialog: true,
            showCountryOnly: true,
            showOnlyCountryWhenClosed: false,
            alignLeft: false,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),
      ),
    );
  }
}
