import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_colors.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_icons.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_images.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_styles.dart';
import 'package:round_7_mobile_cure_team3/core/utils/google_meet_utils.dart';
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
  ConversationCubit? _conversationCubit;

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  void sendMessage() {
    final message = messageController.text.trim();
    if (message.isEmpty) return;

    _conversationCubit?.sendMessage(
      widget.chatId ?? "",
      widget.receiverId ?? "",
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
          SnackBar(
            content: Text('Selected file: ${file.path.split('/').last}'),
          ),
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
      create: (_) {
        _conversationCubit = ConversationCubit(widget.chatRepository!)
          ..loadMessages(widget.chatId ?? '', widget.receiverId ?? '');
        return _conversationCubit!;
      },
      child: BlocListener<ConversationCubit, ConversationState>(
        listener: (context, state) {
          if (state is ConversationError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
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
                  radius: 20,
                  backgroundColor: AppColors.lightGrey,
                  backgroundImage: AssetImage(AppImages.doctorImage),

                  //(widget.doctorImage != null &&
                  //                  widget.doctorImage!.isNotEmpty)
                  //     ? CachedNetworkImageProvider(
                  //         widget.doctorImage!.startsWith('http')
                  //             ? widget.doctorImage!
                  //             : 'https://cure-doctor-booking.runasp.net/${widget.doctorImage!}',
                  //       )
                  //     : null,
                  // child: (widget.doctorImage == null ||
                  //        widget.doctorImage!.isEmpty)
                  //     ? Icon(Icons.person, color: AppColors.primary)
                  //     : null,
                ),
                const SizedBox(width: 10),
                Text(
                  widget.doctorName != null && widget.doctorName!.isNotEmpty
                      ? widget.doctorName!
                      : "Deo",
                  style: AppStyle.styleMedium16(context),
                ),
              ],
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.video_call),
                onPressed: () async {
                  final launched = await GoogleMeetUtils.openMeetLink();
                  if (!launched) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Unable to open Google Meet. Please check your connection.',
                          ),
                        ),
                      );
                    }
                  }
                },
                tooltip: 'Join Video Call',
              ),
              IconButton(
                icon: const Icon(Icons.call),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Voice call feature coming soon'),
                    ),
                  );
                },
                tooltip: 'Voice Call',
              ),
              const Icon(Icons.more_vert),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                  child: BlocBuilder<ConversationCubit, ConversationState>(
                    builder: (context, state) {
                      if (state is ConversationLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      List<dynamic> messages = [];

                      if (state is ConversationLoaded) {
                        messages = state.messages;
                      } else if (state is ConversationSending) {
                        messages = state.messages;
                      } else if (state is ConversationSent) {
                        messages = state.messages;
                      } else if (state is ConversationError) {
                        messages = state.messages;
                      }

                      if (messages.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.chat_bubble_outline,
                                size: 64,
                                color: Colors.grey.shade400,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'No messages yet',
                                style: AppStyle.styleMedium16(
                                  context,
                                ).copyWith(color: Colors.grey.shade600),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Start a conversation',
                                style: AppStyle.styleRegular14(
                                  context,
                                ).copyWith(color: Colors.grey.shade500),
                              ),
                            ],
                          ),
                        );
                      }

                      return ListView.builder(
                        reverse: false,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 16,
                        ),
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          final message = messages[index];
                          final isMe = message.senderId != widget.receiverId;

                          return Align(
                            alignment: isMe
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 10,
                              ),
                              constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.of(context).size.width * 0.7,
                              ),
                              decoration: BoxDecoration(
                                color: isMe
                                    ? AppColors.primary
                                    : AppColors.lightGrey,
                                borderRadius: BorderRadius.only(
                                  topLeft: const Radius.circular(16),
                                  topRight: const Radius.circular(16),
                                  bottomLeft: Radius.circular(isMe ? 16 : 4),
                                  bottomRight: Radius.circular(isMe ? 4 : 16),
                                ),
                              ),
                              child: Text(
                                message.message ?? '',
                                style: AppStyle.styleRegular14(context)
                                    .copyWith(
                                      color: isMe ? Colors.white : Colors.black,
                                    ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 20,
                    right: 30,
                    left: 10,
                  ),
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
                                    child: Image.asset(
                                      AppIcons.sendDocumentChat,
                                    ),
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
