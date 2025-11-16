import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_colors.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_styles.dart';

class DeleteAndLogoutDialog extends StatelessWidget {
  final String title;
  final String message;
  final String cancelText;
  final String confirmText;
  final VoidCallback onConfirm;

  const DeleteAndLogoutDialog({
    super.key,
    required this.title,
    required this.message,
    this.cancelText = "Cancel",
    required this.confirmText,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 50,
              height: 5,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: AppStyle.styleRegular24(context),
            ),
            const Gap(12),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppStyle.styleMedium16(context)
                  .copyWith(color: Colors.black87),
            ),
            const Gap(24),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: AppColors.chatRecieve,
                      foregroundColor: Colors.black87,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () => Navigator.of(context,rootNavigator: true).pop(),
                    child: Text(
                      cancelText,
                      style: AppStyle
                          .styleMedium14(context)
                          .copyWith(color: Colors.black),
                    ),
                  ),
                ),
                const Gap(12),
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      onConfirm();
                    },
                    child: Text(
                      confirmText,
                      style: AppStyle
                          .styleMedium14(context)
                          .copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}



