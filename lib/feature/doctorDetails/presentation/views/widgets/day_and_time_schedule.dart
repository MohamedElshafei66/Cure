import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:svg_image/svg_image.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_images.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../cubit/appointment_cubit.dart';

class DayAndTimeSchedule extends StatelessWidget {
  const DayAndTimeSchedule({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppointmentCubit, AppointmentState>(
      builder: (context, state) {
        if (state.selectedDate == null || state.selectedTime == null) {
          return const SizedBox.shrink();
        }

        final dateFormat = DateFormat('EEEE, MMMM d');
        final formattedDate = dateFormat.format(state.selectedDate!);

        return Row(
          children: [
            SvgImage(
              AppImages.calendarDoneImage,
              type: PathType.assets,
            ),
            const SizedBox(width: 8),
            Text(
              "$formattedDate - ${state.selectedTime}",
              style: AppStyle.styleMedium14(context)
                  .copyWith(color: AppColors.textPrimary),
            ),
            const Spacer(),
            InkWell(
              onTap: () {
                context.pop();
              },
              child: Text(
                AppStrings.reschedule,
                style: AppStyle.styleMedium14(context).copyWith(
                  color: AppColors.primary,
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
