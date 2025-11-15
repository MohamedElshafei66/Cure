import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_colors.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_icons.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_styles.dart';
import 'package:round_7_mobile_cure_team3/feature/chat/domain/repositories/ChatRepository.dart';
import '../cubit/conversation_cubit.dart';
import '../cubit/conversation_state.dart';

class ChatScreen extends StatefulWidget {
  final String? doctorName;
  final String? doctorImage;
  final String? chatId;
  final String? receiverId;
  final ChatRepository? chatRepository;

  const ChatScreen({
    super.key,
     this.doctorName,
     this.doctorImage,
     this.chatId,
     this.receiverId,
     this.chatRepository,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool isTextingMood = false;
  final TextEditingController messageController = TextEditingController();
  final ImagePicker picker = ImagePicker();

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  void sendMessage() {
    final message = messageController.text.trim();
    if (message.isEmpty) return;

    context.read<ConversationCubit>().sendMessage(
      widget.chatId??"",
      widget.receiverId??"",
      message,
    );

    messageController.clear();
    setState(() {
      isTextingMood = false;
    });
  }

  Future<void> pickImage() async {
    var status = await Permission.photos.request();
    if (status.isGranted) {
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Selected image: ${image.name}')),
        );
      }
    }
  }

  Future<void> pickFile() async {
    var status = await Permission.storage.request();
    if (status.isGranted) {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result != null) {
        File file = File(result.files.single.path!);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Selected file: ${file.path.split('/').last}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.chatRepository == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(child: Text('Chat repository not available')),
      );
    }
    
    return BlocProvider(
      create: (_) => ConversationCubit(widget.chatRepository!),
      child: BlocListener<ConversationCubit, ConversationState>(
        listener: (context, state) {
          if (state is ConversationError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            iconTheme: const IconThemeData(color: Colors.black),
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios_new),
            ),
            title: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(widget.doctorImage??""),
                ),
                const SizedBox(width: 10),
                Text(widget.doctorName??"", style: AppStyle.styleMedium16(context)),
              ],
            ),
            actions: const [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.video_call),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.call),
              ),
              Icon(Icons.more_vert),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(child: Container()),
                Padding(
                  padding:
                  const EdgeInsets.only(bottom: 20, right: 30, left: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: messageController,
                          onTap: () => setState(() => isTextingMood = true),
                          onChanged: (_) => setState(() {}),
                          onTapOutside: (event) =>
                              FocusScope.of(context).unfocus(),
                          decoration: InputDecoration(
                            suffixIcon: SizedBox(
                              width: 100,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: pickFile,
                                    child: Image.asset(AppIcons.sendDocumentChat),
                                  ),
                                  const SizedBox(width: 10),
                                  GestureDetector(
                                    onTap: pickImage,
                                    child: Image.asset(AppIcons.camera),
                                  ),
                                ],
                              ),
                            ),
                            hintText: "Type a message...",
                            fillColor: AppColors.lightGrey,
                            filled: true,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: messageController.text.trim().isNotEmpty
                            ? sendMessage
                            : null,
                        child: CircleAvatar(
                          backgroundColor: AppColors.primary,
                          child: Icon(
                            messageController.text.trim().isNotEmpty
                                ? Icons.send
                                : Icons.mic_none_rounded,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
