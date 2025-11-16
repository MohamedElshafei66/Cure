import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_colors.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_styles.dart';

class PhoneWithCountryPicker extends StatefulWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onCountryChanged;

  const PhoneWithCountryPicker({
    super.key,
    required this.controller,
    this.onCountryChanged,
  });

  @override
  State<PhoneWithCountryPicker> createState() => _PhoneWithCountryPickerState();
}

class _PhoneWithCountryPickerState extends State<PhoneWithCountryPicker> {
  String countryCode = '+20';
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
    final isFocused = focusNode.hasFocus;
    final hintColor = isFocused ? Colors.blue : Colors.grey;
    final labelColor = isFocused ? Colors.blue : Colors.grey[700]!;

    return TextFormField(
      controller: widget.controller,
      focusNode: focusNode,
      validator: (value) {
        if (value == null || value.isEmpty) return "number is required";
        // optional: validate length after concatenation at submit time
        return null;
      },
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.lightGrey,
        labelText: 'Phone Number',
        labelStyle: AppStyle.styleMedium16(context).copyWith(color: labelColor),
        hintText: 'Enter phone number (without country code)',
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
            final dial = code.dialCode ?? '+20';
            countryCode = dial;
            if (widget.onCountryChanged != null) widget.onCountryChanged!(dial);
            setState(() {});
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

