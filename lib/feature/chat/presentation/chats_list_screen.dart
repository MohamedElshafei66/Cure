import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:round_7_mobile_cure_team3/core/routes/app_routes.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_colors.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_icons.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_images.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_strings.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_styles.dart';
import 'package:round_7_mobile_cure_team3/core/widgets/chat_card.dart';

class ChatsListScreen extends StatefulWidget {
   ChatsListScreen({super.key});

  @override
  State<ChatsListScreen> createState() => _ChatsListScreenState();
}

class _ChatsListScreenState extends State<ChatsListScreen> {
  List<String> chatTypes=[
    "All",
    "Unread",
    "Favorite"
  ];

  bool isSelectionMode =false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: isSelectionMode?null:Text(
          AppStrings.chatTitle,
          style: AppStyle.styleRegular24(context),
        ),
        actions:isSelectionMode?[
          IconButton(onPressed: (){}, icon: Image.asset(AppIcons.trashBin)),
          IconButton(onPressed: (){}, icon: Image.asset(AppIcons.pin)),
          IconButton(onPressed: (){}, icon: Image.asset(AppIcons.mute)),
          IconButton(onPressed: (){}, icon: Icon(Icons.more_vert)),
        ]: [Icon(Icons.more_vert)],
        leading: isSelectionMode?GestureDetector(
            onTap: () {
              setState(() {
                isSelectionMode=false;
              });
            },
            child: Icon(Icons.close,)):null,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                fillColor: AppColors.lightGrey,
                filled: true,
                hintText: AppStrings.searchChat,
                prefixIcon: Image.asset(AppIcons.search),
                hintStyle: AppStyle.styleRegular14(context),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide(color: Colors.transparent),
                ),

              ),
            ),
            SizedBox(
              height: 60,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(chatTypes[index],style: AppStyle.styleRegular16(context),),
                  );
                },
                itemCount: 3,

              ),
            ),
            Expanded(
              child: ListView.builder(

                  itemCount: 3,
                  itemBuilder:(context, index) {
                    return GestureDetector(
                        onLongPress: () {
                          setState(() {
                            isSelectionMode=true;
                          });
                        },
                        onTap: () {
                          GoRouter.of(context).push(AppRoutes.chatScreen);
                        // context.go(AppRoutes.chatScreen);
                        },
                        child: ChatCard(doctorName: AppStrings.doctorName,doctorImage: AppImages.doctorImage,));
                  }, ),
            )
          ],
        ),
      ),
    );
  }
}
