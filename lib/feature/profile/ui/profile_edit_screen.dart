import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gap/gap.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_icons.dart';
import 'package:round_7_mobile_cure_team3/core/widgets/custom_button.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/ui/widget/birthday_picker.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/ui/widget/custom_text_field.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/ui/widget/phone_with_country_picker.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/ui/widget/profile_header.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  int selectedDay = 29;
  String selectedMonth = 'July';
  int selectedYear = DateTime.now().year;

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
  final List<int> years = List.generate(100, (i) => DateTime.now().year - i);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 55),
        children: [
          const ProfileHeader(),
          const Gap(30),

          /// Form Start
          Form(
            key: _formKey,
            child: Column(
              children: [
                // Name
                CustomTextField(
                  controller: nameController,
                  prefixIcon: AppIcons.personf,
                  hintText: "Enter name",
                  label: "Full Name",
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Name is required";
                    }
                    if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
                      return "Only English letters allowed";
                    }
                    return null;
                  },
                ),
                const Gap(20),

                // Email
                CustomTextField(
                  controller: emailController,
                  prefixIcon: AppIcons.email,
                  hintText: "Enter your email",
                  label: "Email",
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Email is required";
                    }
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                        .hasMatch(value)) {
                      return "Enter a valid email";
                    }
                    return null;
                  },
                ),
                const Gap(20),

                // Phone
                const PhoneWithCountryPicker(),
                const Gap(20),

                // Birthday
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Select your birthday",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
                const Gap(10),
                BirthdayPicker(
                  selectedDay: selectedDay,
                  selectedMonth: selectedMonth,
                  selectedYear: selectedYear,
                  days: days,
                  months: months,
                  years: years,
                  onDayChanged: (value) => setState(() => selectedDay = value!),
                  onMonthChanged: (value) => setState(() => selectedMonth = value!),
                  onYearChanged: (value) {
                    if (value! <= DateTime.now().year) {
                      setState(() => selectedYear = value);
                    }
                  },
                ),
                const Gap(40),

                // Save Button
                CustomButton(
                  text: 'Edit Profile',
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    if (_formKey.currentState!.validate()) {
                      context.pop();
                    }
                  },
                ),
                const Gap(30),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

