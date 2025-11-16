import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_colors.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_styles.dart';

class PhoneWithCountryPicker extends StatefulWidget {
<<<<<<< HEAD
  final TextEditingController? controller;
  final String? initialValue;
  final String? initialCountryCode;
  
  const PhoneWithCountryPicker({
    super.key,
    this.controller,
    this.initialValue,
    this.initialCountryCode,
=======
  final TextEditingController controller;
  final ValueChanged<String>? onCountryChanged;

  const PhoneWithCountryPicker({
    super.key,
    required this.controller,
    this.onCountryChanged,
>>>>>>> 8fc1234635d783872ebafe8a5be92910c4f6d3ab
  });

  @override
  State<PhoneWithCountryPicker> createState() => _PhoneWithCountryPickerState();
}

class _PhoneWithCountryPickerState extends State<PhoneWithCountryPicker> {
<<<<<<< HEAD
  late String countryCode;
  late TextEditingController phoneController;
  late FocusNode focusNode;
  
=======
  String countryCode = '+20';
  late FocusNode focusNode;

>>>>>>> 8fc1234635d783872ebafe8a5be92910c4f6d3ab
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

