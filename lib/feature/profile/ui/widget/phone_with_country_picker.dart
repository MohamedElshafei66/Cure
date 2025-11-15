import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_colors.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_styles.dart';

class PhoneWithCountryPicker extends StatefulWidget {
  const PhoneWithCountryPicker({super.key});

  @override
  State<PhoneWithCountryPicker> createState() => _PhoneWithCountryPickerState();
}

class _PhoneWithCountryPickerState extends State<PhoneWithCountryPicker> {
  String countryCode = '+20';
  final TextEditingController phoneController = TextEditingController();
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
    Color hintColor = isFocused ? Colors.blue : Colors.grey;
    Color labelColor = isFocused ? Colors.blue : Colors.grey[700]!;

    return TextFormField(
      controller: phoneController,
      focusNode: focusNode,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return " number is required";
        } else if (value.length != 11) {
          return 'number must be 11 digits';
        }
        return null;
      },
      keyboardType: TextInputType.phone,

      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.lightGrey,
        labelText: 'Phone Number',
        labelStyle: AppStyle.styleMedium16(context).copyWith(color: labelColor),
        hintText: 'Enter phone number',
        hintStyle: AppStyle.styleMedium16(context).copyWith(color: hintColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.primary),
        ),
        prefixIcon: CountryCodePicker(
          onChanged: (code) {
            setState(() {
              countryCode = code.dialCode ?? '+20';
            });
          },
          initialSelection: 'EG',
          favorite: const ['+20', 'EG', '+1', '+44', '+91'],
          showCountryOnly: false,
          showOnlyCountryWhenClosed: false,
          alignLeft: false,
          padding: EdgeInsets.zero,
          textStyle: AppStyle.styleMedium16(context),
        ),
      ),
    );
  }
}
