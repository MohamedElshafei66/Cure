import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:round_7_mobile_cure_team3/core/constants/secure_storage_data.dart';
import 'package:round_7_mobile_cure_team3/core/routes/app_routes.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_colors.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_icons.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_styles.dart';
import 'package:round_7_mobile_cure_team3/core/widgets/chat_card.dart';
import '../../data/models/favourite_chat_model.dart';
import '../../data/data_sources/chat_remote_data_source.dart';
import '../../data/data_sources/unread_chat_remote_data_source.dart';
import '../../data/data_sources/favorite_chat_remote_data_source.dart';
import '../../data/repositories/ChatRepositoryImp.dart';
import '../../data/repositories/unread_chat_repository_impl.dart';
import '../../data/repositories/favorite_chat_repository_imp.dart';
import '../cubit/chats_cubit.dart';
import '../cubit/chats_state.dart';
import '../cubit/unread_chat_cubit.dart';
import '../cubit/unread_chat_state.dart';
import '../cubit/favourite_chat_cubit.dart';
import '../cubit/favourite_chat_state.dart';

class ChatsListScreen extends StatefulWidget {
  const ChatsListScreen({super.key});

  @override
  State<ChatsListScreen> createState() => _ChatsListScreenState();
}

class _ChatsListScreenState extends State<ChatsListScreen> {
  bool isSelectionMode = false;

  ChatCubit? chatCubit;
  UnreadChatCubit? unreadCubit;
  FavoriteChatCubit? favoriteCubit;

  List<String> chatTypes = ["All", "Unread", "Favorite"];
  int selectedIndex = 0;

  ChatDTO? selectedChat;

  @override
  void initState() {
    super.initState();

    final secureStorage = Provider.of<SecureStorageService>(
      context,
      listen: false,
    );
    final chatRemote = ChatRemoteDataSource();
    final unreadRemote = UnreadChatRemoteDataSource(
      secureStorage: secureStorage,
    );
    final favoriteRemote = FavoriteChatRemoteDataSource(

    );

    chatCubit = ChatCubit(ChatRepositoryImpl(chatRemote));
    unreadCubit = UnreadChatCubit(UnreadChatRepositoryImpl(unreadRemote));
    favoriteCubit = FavoriteChatCubit(
      FavoriteChatRepositoryImpl(favoriteRemote),
    );

    chatCubit!.fetchChats();
    favoriteCubit!.fetchFavoriteChats();
  }

  @override
  void dispose() {
    chatCubit?.close();
    unreadCubit?.close();
    favoriteCubit?.close();
    super.dispose();
  }

  void _addFavorite(ChatDTO chat) {
    final chatId = chat.id ?? '';
    favoriteCubit?.addToFavorite(chatId);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: chatCubit!),
        BlocProvider.value(value: unreadCubit!),
        BlocProvider.value(value: favoriteCubit!),
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
          title: isSelectionMode
              ? null
              : const Text(
                  "Chats",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                ),
          actions: [
            if (isSelectionMode)
              IconButton(
                onPressed: () {
                  if (selectedChat != null) {
                    _addFavorite(selectedChat!);
                  }
                },
                icon: const Icon(Icons.favorite_border_outlined),
              ),
            if (isSelectionMode)
              IconButton(icon: Image.asset(AppIcons.delete), onPressed: () {}),
            if (isSelectionMode)
              IconButton(onPressed: () {}, icon: Image.asset(AppIcons.pin)),
            if (isSelectionMode)
              IconButton(onPressed: () {}, icon: Image.asset(AppIcons.mute)),

            if (!isSelectionMode) const Icon(Icons.more_vert),
          ],
          leading: isSelectionMode
              ? GestureDetector(
                  onTap: () => setState(() => isSelectionMode = false),
                  child: const Icon(Icons.close),
                )
              : null,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // Tabs
              SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: chatTypes.length,
                  itemBuilder: (context, index) {
                    final isSelected = selectedIndex == index;
                    return GestureDetector(
                      onTap: () {
                        setState(() => selectedIndex = index);
                        if (index == 0) {
                          chatCubit?.fetchChats();
                        } else if (index == 1) {
                          unreadCubit?.fetchUnreadChats();
                        } else if (index == 2) {
                          favoriteCubit?.fetchFavoriteChats();
                        }
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.easeInOut,
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primary
                              : AppColors.lightGrey,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: AppColors.primary.withOpacity(0.4),
                                    blurRadius: 6,
                                    offset: const Offset(0, 3),
                                  ),
                                ]
                              : [],
                        ),
                        child: Center(
                          child: Text(
                            chatTypes[index],
                            style: AppStyle.styleRegular16(context).copyWith(
                              color: isSelected ? Colors.white : Colors.black,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 12),
              // Content
              Expanded(
                child: Builder(
                  builder: (context) {
                    if (selectedIndex == 0) {
                      return BlocBuilder<ChatCubit, ChatState>(
                        builder: (context, state) {
                          if (state is ChatLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (state is ChatLoaded) {
                            if (state.chats.isEmpty)
                              return const Center(
                                child: Text("No chats found"),
                              );
                            return ListView.builder(
                              itemCount: state.chats.length,
                              itemBuilder: (context, index) {
                                final chat = state.chats[index];
                                return GestureDetector(
                                  onLongPress: () =>
                                      setState(() => isSelectionMode = true),
                                  onTap: () {
                                    DoctorDTO(name: chat.name, img: chat.image);
                                    GoRouter.of(
                                      context,
                                    ).push(AppRoutes.chatScreen, extra: chat);
                                  },
                                  child: ChatCard(
                                    doctorDTO: DoctorDTO(
                                      name: chat.name,
                                      img: chat.image,
                                    ),
                                  ),
                                );
                              },
                            );
                          } else if (state is ChatError) {
                            return Center(
                              child: Text("Error: ${state.message}"),
                            );
                          } else {
                            return const SizedBox.shrink();
                          }
                        },
                      );
                    } else if (selectedIndex == 1) {
                      return BlocBuilder<UnreadChatCubit, UnreadChatState>(
                        builder: (context, state) {
                          if (state is UnreadChatLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (state is UnreadChatLoaded) {
                            if (state.doctors.isEmpty)
                              return const Center(
                                child: Text("No unread chats"),
                              );
                            return ListView.builder(
                              itemCount: state.doctors.length,
                              itemBuilder: (context, index) {
                                final chat = state.doctors[index];
                                return ChatCard(
                                  doctorDTO: DoctorDTO(
                                    name: chat.name,
                                    img: chat.img,
                                  ),
                                );
                              },
                            );
                          } else if (state is UnreadChatError) {
                            return Center(child: Text("Error: ${state.error}"));
                          } else {
                            return const SizedBox.shrink();
                          }
                        },
                      );
                    } else {
                      return BlocBuilder<FavoriteChatCubit, FavoriteChatState>(
                        builder: (context, state) {
                          if (state is FavoriteChatLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (state is FavoriteChatLoaded) {
                            if (state.doctors.isEmpty)
                              return const Center(
                                child: Text("No favorite chats"),
                              );
                            return ListView.separated(
                              itemCount: state.doctors.length,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 8),
                              itemBuilder: (context, index) {
                                final doctor = state.doctors[index];
                                return ChatCard(doctorDTO: doctor);
                              },
                            );
                          } else if (state is FavoriteChatError) {
                            return Center(child: Text("Error: ${state.error}"));
                          } else {
                            return const SizedBox.shrink();
                          }
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
