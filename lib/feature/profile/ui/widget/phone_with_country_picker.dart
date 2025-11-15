import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_colors.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_styles.dart';

class PhoneWithCountryPicker extends StatefulWidget {
  final TextEditingController? controller;
  final String? initialValue;
  final String? initialCountryCode;
  
  const PhoneWithCountryPicker({
    super.key,
    this.controller,
    this.initialValue,
    this.initialCountryCode,
  });

  @override
  State<PhoneWithCountryPicker> createState() => _PhoneWithCountryPickerState();
}

class _PhoneWithCountryPickerState extends State<PhoneWithCountryPicker> {
  late String countryCode;
  late TextEditingController phoneController;
  late FocusNode focusNode;
  
  @override
  void initState() {
    super.initState();
    countryCode = widget.initialCountryCode ?? '+20';
    phoneController = widget.controller ?? TextEditingController();
    if (widget.initialValue != null) {
      phoneController.text = widget.initialValue!;
    }
    focusNode = FocusNode();
    focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    focusNode.dispose();
    // Only dispose controller if we created it
    if (widget.controller == null) {
      phoneController.dispose();
    }
    super.dispose();
  }
  
  String get fullPhoneNumber => '$countryCode${phoneController.text}';

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
