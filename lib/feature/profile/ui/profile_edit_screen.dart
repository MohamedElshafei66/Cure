import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_icons.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_styles.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/data/model/profile_model.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/logic/Cubit/profile_cubit.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/ui/widget/custom_text_field.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/ui/widget/birthday_picker.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/ui/widget/phone_with_country_picker.dart';
import 'package:round_7_mobile_cure_team3/feature/profile/ui/widget/profile_button.dart';

class ProfileEditScreen extends StatefulWidget {
  final ProfileModel profile;
  const ProfileEditScreen({super.key, required this.profile});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final picker = ImagePicker();
  File? imageFile;

  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;

  String countryCode = "+20";

  int selectedDay = 1;
  String selectedMonth = 'January';
  int selectedYear = DateTime.now().year;

  static const List<String> _months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December',
  ];

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(text: widget.profile.fullName);
    emailController = TextEditingController(text: widget.profile.email);

    String phone = widget.profile.phoneNumber.replaceAll("+", "").trim();
    if (phone.startsWith("20")) phone = phone.substring(2);
    if (phone.startsWith("0")) phone = phone.substring(1);
    phoneController = TextEditingController(text: phone);

    if (widget.profile.birthDate.isNotEmpty &&
        widget.profile.birthDate != "0001-01-01T00:00:00") {
      final date = DateTime.parse(widget.profile.birthDate);
      selectedDay = date.day;
      selectedMonth = _months[date.month - 1];
      selectedYear = date.year;
    }
  }

  Future<void> pickImage() async {
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null && mounted) {
      setState(() => imageFile = File(picked.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text("Edit Profile", style: TextStyle(color: Colors.black)),
      ),

      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ProfileUpdateSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green,
              ),
            );

            Future.delayed(const Duration(milliseconds: 500), () {
              if (mounted) Navigator.pop(context, true);
            });
          } else if (state is ProfileUpdateError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },

        builder: (context, state) {
          return Stack(
            children: [
              ListView(
                padding: const EdgeInsets.all(18),
                children: [
                  /// Profile Image
                  Center(
                    child: GestureDetector(
                      onTap: _showImagePicker,
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            radius: 55,
                            backgroundImage: imageFile != null
                                ? FileImage(imageFile!)
                                : (widget.profile.imgUrl.isNotEmpty
                                    ? NetworkImage(
                                        widget.profile.imgUrl.startsWith("http")
                                            ? widget.profile.imgUrl
                                            : "https://cure-doctor-booking.runasp.net${widget.profile.imgUrl}",
                                      )
                                    : const AssetImage(
                                        "assets/images/profile_image.png",
                                      )) as ImageProvider,
                          ),
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Image.asset(
                              AppIcons.camera,
                              width: 20,
                              height: 20,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const Gap(15),
                  Center(
                    child: Text(
                      nameController.text.isEmpty
                          ? "No Name"
                          : nameController.text,
                      style: AppStyle.styleRegular24(context),
                    ),
                  ),
                  const Gap(8),
                  Center(
                    child: Text(
                      widget.profile.address.isNotEmpty
                          ? widget.profile.address
                          : "No Address",
                      style: AppStyle.styleRegular14(context),
                    ),
                  ),

                  const Gap(30),

                  /// Form Fields
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          controller: nameController,
                          hintText: "Full Name",
                          label: "Full Name",
                          prefixIcon: AppIcons.personf,
                          keyboardType: TextInputType.name,
                          validator: (v) => v!.isEmpty ? "Required" : null,
                        ),
                        const Gap(20),

                        CustomTextField(
                          controller: emailController,
                          hintText: "Email",
                          label: "Email",
                          prefixIcon: AppIcons.email,
                          keyboardType: TextInputType.emailAddress,
                          validator: (v) => v!.isEmpty ? "Required" : null,
                        ),
                        const Gap(20),

                        PhoneWithCountryPicker(
                          controller: phoneController,
                          onCountryChanged: (code) => countryCode = code,
                        ),
                        const Gap(20),

                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Select your birthday",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        const Gap(8),

                        BirthdayPicker(
                          selectedDay: selectedDay,
                          selectedMonth: selectedMonth,
                          selectedYear: selectedYear,
                          days: List.generate(31, (i) => i + 1),
                          months: _months,
                          years: List.generate(
                            100,
                            (i) => DateTime.now().year - i,
                          ),
                          onDayChanged: (v) => setState(() => selectedDay = v!),
                          onMonthChanged: (v) =>
                              setState(() => selectedMonth = v!),
                          onYearChanged: (v) =>
                              setState(() => selectedYear = v!),
                        ),

                        const Gap(50),

                        ProfileButton(
                          title: "Edit Profile",
                          showicon: false,
                          onTap: _onSaveProfile,
                        ),
                        const Gap(40),
                      ],
                    ),
                  ),
                ],
              ),

              if (state is ProfileUpdateLoading)
                Container(
                  color: Colors.black26,
                  child: const Center(child: CircularProgressIndicator()),
                ),
            ],
          );
        },
      ),
    );
  }

  void _onSaveProfile() {
    if (!_formKey.currentState!.validate()) return;

    final monthIndex = _months.indexOf(selectedMonth);
    final birthDate = "$selectedYear-${monthIndex + 1}-$selectedDay";

    String rawPhone = phoneController.text.trim()
        .replaceAll("+", "")
        .replaceAll(" ", "");

    if (rawPhone.startsWith("20")) rawPhone = rawPhone.substring(2);
    if (rawPhone.startsWith("0")) rawPhone = rawPhone.substring(1);

    final finalPhone = "$countryCode$rawPhone";

    final address = widget.profile.address.isNotEmpty
        ? widget.profile.address
        : "Cairo";

    context.read<ProfileCubit>().updateProfile(
      fullName: nameController.text.trim(),
      email: emailController.text.trim(),
      phone: finalPhone,
      address: address,
      birthDate: birthDate,
      imageFile: imageFile,
    );
  }

  void _showImagePicker() {
    showModalBottomSheet(
      context: context,
      builder: (_) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text("Choose from Gallery"),
              onTap: () async {
                Navigator.pop(context);
                final picked = await picker.pickImage(source: ImageSource.gallery);
                if (picked != null) {
                  setState(() => imageFile = File(picked.path));
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text("Take a Photo"),
              onTap: () async {
                Navigator.pop(context);
                final picked = await picker.pickImage(source: ImageSource.camera);
                if (picked != null) {
                  setState(() => imageFile = File(picked.path));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
