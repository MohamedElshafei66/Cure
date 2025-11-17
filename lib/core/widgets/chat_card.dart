import 'package:flutter/material.dart';
import '../../feature/chat/data/models/favourite_chat_model.dart';
import '../../feature/chat/data/models/chat_model.dart';
import '../utils/app_colors.dart';
import '../utils/app_styles.dart';

class ChatCard extends StatelessWidget {
  final DoctorDTO? doctorDTO;
  final ChatDTO? chatDTO;
  final VoidCallback? onTap;

  const ChatCard({
    super.key,
    this.doctorDTO,
    this.chatDTO,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final String name =
    doctorDTO?.name?.isNotEmpty == true
        ? doctorDTO!.name!
        : chatDTO?.name?.isNotEmpty == true
        ? chatDTO!.name!
        : "Deo";


    final String? image =
        doctorDTO?.img ??
            "";

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(8),
          height: 80,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: AppColors.lightGrey,
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: (image != null && image.isNotEmpty)
                    ? Image.network(
                  image,
                  height: 60,
                  width: 60,
                  fit: BoxFit.cover,
                )
                    : Image.asset(
                  'assets/images/doctor_image.png',
                  height: 60,
                  width: 60,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      name,
                      style: AppStyle.styleMedium16(context),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "It’s been around six.....",
                      style: AppStyle.styleRegular14(context),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: Text(
                  "9:30",
                  style: AppStyle.styleRegular14(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
