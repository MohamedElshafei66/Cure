import 'package:flutter/material.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_colors.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_images.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_strings.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_styles.dart';
import 'package:svg_image/svg_image.dart';
class SelectPaymentMethod extends StatefulWidget {
  const SelectPaymentMethod({super.key});
  @override
  State<SelectPaymentMethod> createState() => _SelectPaymentMethodState();
}

class _SelectPaymentMethodState extends State<SelectPaymentMethod> {
  late String selectedMethod;
  final List<Map<String, dynamic>> methods = [
    {
      'name': AppStrings.creditCard,
      'image': AppImages.visaImage,
    },
    {
      'name': AppStrings.paypal,
      'image': AppImages.paypalImage,
    },
    {
      'name':  AppStrings.applePay,
      'image': AppImages.applePayImage,
    },
  ];
  @override
  void initState() {
    super.initState();
    selectedMethod = methods.first['name'];
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: methods.map((method) {
        final bool isSelected = selectedMethod == method['name'];
        return Container(
          margin: const EdgeInsets.symmetric(vertical:8),
          decoration: BoxDecoration(
            color: isSelected
                ? Colors.green.withOpacity(0.1)
                : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected
                  ? Colors.transparent
                  : Colors.transparent
            ),
          ),
          child: ListTile(
            onTap:(){
              setState(() {
                selectedMethod = method['name'];
              });
            },
            contentPadding: const EdgeInsets.symmetric(horizontal:12, vertical:2),
            leading: Icon(
              isSelected ? Icons.check_circle : Icons.circle_outlined,
              color: isSelected ? Colors.green : Colors.grey,
            ),
            title: Text(
              method['name'],
              style: AppStyle.styleMedium16(context).copyWith(
                color: isSelected ? AppColors.green : AppColors.whiteColor79,
              ),
            ),
            trailing: SvgImage(
              method['image'],
              type: PathType.assets,
            ),
          ),
        );

      }).toList(),
    );
  }
}
