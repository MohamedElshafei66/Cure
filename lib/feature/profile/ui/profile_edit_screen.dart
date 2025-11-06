import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_icons.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_images.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_styles.dart';
import 'package:round_7_mobile_cure_team3/core/widgets/custom_button.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/ui/widget/birthday_picker.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/ui/widget/custom_text_field.dart';

class ProfileEditScreen extends StatefulWidget {
  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  int selectedDay = 29;
  String selectedMonth = 'July';
  int selectedYear = 2024;

  final List<int> days = List.generate(31, (i) => i + 1);
  final List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];
  final List<int> years = List.generate(60, (i) => DateTime.now().year - i);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(55),
              Center(
                child: Column(
                  children: [
                    Image.asset(AppImages.profileImage, height: 100),
                    const Gap(10),
                    Text(
                      "Seif Mohamed",
                      style: AppStyle.styleRegular20(context),
                    ),
                    const Gap(8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(AppIcons.location, height: 16),
                        const Gap(5),

                        Text(
                          "129, El-Nasr Street, Cairo",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: AppStyle.styleRegular14(context),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const Gap(30),

              CustomTextField(
                controller: nameController,
                prefixIcon: AppIcons.personf,
                hintText: "enter name",
                keyboardType: TextInputType.text,
              ),
              const Gap(20),

              CustomTextField(
                controller: emailController,
                prefixIcon: AppIcons.email,
                hintText: "enter your email",
                keyboardType: TextInputType.emailAddress,
              ),
              const Gap(20),

              CustomTextField(
                controller: phoneController,
                prefixIcon: AppIcons.flag,
                hintText: "enter your number",
                keyboardType: const TextInputType.numberWithOptions(),
              ),
              const Gap(20),

              Text(
                "Select your birthday",
                style: AppStyle.styleRegular16(context),
              ),
              const Gap(10),

              BirthdayPicker(
                selectedDay: selectedDay,
                selectedMonth: selectedMonth,
                selectedYear: selectedYear,
                days: days,
                months: months,
                years: years,
                onDayChanged: (value) {
                  setState(() => selectedDay = value!);
                },
                onMonthChanged: (value) {
                  setState(() => selectedMonth = value!);
                },
                onYearChanged: (value) {
                  setState(() => selectedYear = value!);
                },
              ),

              const Gap(40),

              CustomButton(
                text: 'Edit Profile',
                onPressed: () {
                  context.pop();
                },
              ),
              const Gap(30),
            ],
          ),
        ),
      ),
    );
  }
}
