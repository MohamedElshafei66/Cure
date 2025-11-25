import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_images.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_styles.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/data/payment_service.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/ui/widget/card_text_field.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/ui/widget/custom_text_field.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/ui/widget/profile_button.dart';
import '../../../core/constants/auth_provider.dart';

class AddCardScreen extends StatefulWidget {
  final String methodName;
  const AddCardScreen({super.key, required this.methodName});

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  final formKey = GlobalKey<FormState>();
  final cardholderNameController = TextEditingController();
  final cardNumberController = TextEditingController();
  final expiryMonthController = TextEditingController();
  final expiryYearController = TextEditingController();
  final cvvController = TextEditingController();

  bool isLoading = false;

  /// 🔹 Check if the expiration date is expired
  bool _isExpirationDateExpired(int month, int year) {
    final now = DateTime.now();
    final currentYear = now.year;
    final currentMonth = now.month;

    // Normalize year (handle 2-digit years)
    int normalizedYear = year;
    if (year < 100) {
      normalizedYear = 2000 + year;
    }

    // Card expires at the end of the expiration month
    // So if current date is past the expiration month, it's expired
    if (normalizedYear < currentYear) {
      return true; // Expired - year is in the past
    } else if (normalizedYear == currentYear) {
      // Same year - check if month has passed
      return month < currentMonth;
    } else {
      return false; // Future year - not expired
    }
  }

  /// 🔹 Validate expiration date (used by both month and year validators)
  String? _validateExpirationDate() {
    final monthText = expiryMonthController.text.trim();
    final yearText = expiryYearController.text.trim();

    // Both fields must be filled to check expiration
    if (monthText.isEmpty || yearText.isEmpty) {
      return null; // Let individual validators handle empty fields
    }

    final month = int.tryParse(monthText);
    final year = int.tryParse(yearText);

    if (month == null || year == null) {
      return null; // Let individual validators handle invalid format
    }

    if (_isExpirationDateExpired(month, year)) {
      return "Card has expired";
    }

    return null; // Valid expiration date
  }

  /// 🔹 Save the card after validation
  Future<void> _saveCard() async {
    if (!formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    try {
      final authProvider = context.read<AuthProvider>();
      final token = authProvider.accessToken;

      if (token == null || token.isEmpty) {
        throw Exception("User is not authenticated");
      }

      final service = PaymentService(authProvider: authProvider);

      // Parse and validate expiration date
      int month = int.parse(expiryMonthController.text);
      int year = int.parse(expiryYearController.text);
      if (year < 100) year += 2000;

      // Double-check expiration before sending to API
      if (_isExpirationDateExpired(month, year)) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("This card has expired. Please use a valid card."),
              backgroundColor: Colors.red,
            ),
          );
        }
        setState(() => isLoading = false);
        return;
      }

      // Debug: Log method name being saved
      print('💾 Saving card with methodName: ${widget.methodName}');

      final response = await service.addPaymentMethod(
        cardholderName: cardholderNameController.text.trim(),
        cardNumber: cardNumberController.text.trim(),
        expMonth: int.parse(expiryMonthController.text),
        expYear: year,
        cvv: cvvController.text.trim(),
        methodName: widget.methodName,
      );

      final success = response["success"] == true;
      final message = response["message"] ?? "Something went wrong";

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: success ? Colors.green : Colors.red,
          ),
        );

        if (success) Navigator.pop(context, "added");
      }
    } catch (e) {
      print("❌ Error saving card: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Failed to add card: $e"),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Add ${widget.methodName} Card",
          style: AppStyle.styleRegular24(context),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(AppImages.addCardImage),
                const Gap(20),

                Text('Cardholder Name', style: AppStyle.styleMedium16(context)),
                const Gap(10),
                CustomTextField(
                  controller: cardholderNameController,
                  hintText: "Cardholder Name",
                  keyboardType: TextInputType.text,
                  validator: (v) =>
                      v!.isEmpty ? "Cardholder name required" : null,
                ),

                const Gap(10),
                Text('Card Number', style: AppStyle.styleMedium16(context)),
                CardTextField(
                  controller: cardNumberController,
                  hintText: "Card Number",
                  validator: (v) =>
                      v!.length != 16 ? "Enter valid 16-digit card" : null,
                ),

                const Gap(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Expiry Date", style: AppStyle.styleMedium16(context)),
                    Text('CVV Code', style: AppStyle.styleMedium16(context)),
                  ],
                ),
                const Gap(10),

                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        controller: expiryMonthController,
                        hintText: "MM",
                        keyboardType: TextInputType.number,
                        validator: (v) {
                          if (v!.isEmpty) return "Required";
                          final month = int.tryParse(v);
                          if (month == null || month < 1 || month > 12) {
                            return "Invalid";
                          }
                          // Check expiration date when both fields are filled
                          return _validateExpirationDate();
                        },
                      ),
                    ),
                    const Gap(12),
                    Expanded(
                      child: CustomTextField(
                        controller: expiryYearController,
                        hintText: "YY",
                        keyboardType: TextInputType.number,
                        validator: (v) {
                          if (v!.isEmpty) return "Required";
                          // Validate year format (should be 2 digits, typically 00-99)
                          final year = int.tryParse(v);
                          if (year == null) {
                            return "Invalid";
                          }
                          // Check if year is reasonable (not negative, not too large)
                          if (year < 0 || year > 99) {
                            return "Invalid";
                          }
                          // Check expiration date when both fields are filled
                          return _validateExpirationDate();
                        },
                      ),
                    ),
                    const Gap(12),
                    Expanded(
                      child: CustomTextField(
                        controller: cvvController,
                        hintText: "CVV",
                        keyboardType: TextInputType.number,
                        validator: (v) => v!.length != 3 ? "3 digits" : null,
                      ),
                    ),
                  ],
                ),

                const Gap(40),
                isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ProfileButton(
                        title: "Save",
                        showicon: false,
                        onTap: _saveCard,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
