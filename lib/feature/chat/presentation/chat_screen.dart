import 'package:flutter/material.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_colors.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_icons.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_images.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_strings.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_styles.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool isTextingMood = false;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        leading: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios_new),
            ),
          ],
        ),
        title: Row(
          children: [
            Image.asset(AppImages.doctorImage),
            Text(AppStrings.doctorName, style: AppStyle.styleMedium16(context)),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(AppIcons.videoCamera),
          ),
          Image.asset(AppIcons.call),
          Icon(Icons.more_vert),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Align(
              alignment: AlignmentGeometry.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(9),
                      topRight: Radius.circular(9),
                      topLeft: Radius.circular(9),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Hi seif it’s been a while",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: AlignmentGeometry.topRight,
              child: Container(
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.chatRecieve,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Hi seif it’s been a while",
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
              ),
            ),
            Align(
              alignment: AlignmentGeometry.topLeft,
              child: Container(
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Hi seif it’s been a while",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ),
            Align(
              alignment: AlignmentGeometry.topRight,
              child: Container(
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.chatRecieve,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Hi seif it’s been a while",
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 20, right: 30, left: 10),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      onTapOutside: (event) => FocusScope.of(context).unfocus(),
                      onTap: () {
                        setState(() {
                          isTextingMood = true;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: AppStrings.message,
                        hintStyle: AppStyle.styleRegular16(context),
                        fillColor: AppColors.lightGrey,
                        filled: true,
                        suffixIcon: SizedBox(
                          width: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              isTextingMood
                                  ? Image.asset(AppIcons.sendDocumentChat)
                                  : Row(
                                      children: [
                                        Image.asset(AppIcons.sendDocumentChat),
                                        SizedBox(width: 2),
                                        Image.asset(AppIcons.camera),
                                      ],
                                    ),
                            ],
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: isTextingMood
                        ? Image.asset(AppIcons.sendChat)
                        : Image.asset(AppIcons.microphone),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
