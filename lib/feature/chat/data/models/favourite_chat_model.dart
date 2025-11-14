class FavouriteChatModel {
  final bool success;
  final String message;
  final FavouriteChatData data;

  FavouriteChatModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory FavouriteChatModel.fromJson(Map<String, dynamic> json) {
    return FavouriteChatModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: FavouriteChatData.fromJson(json['data'] ?? {}),
    );
  }
}

class FavouriteChatData {
  final List<ChatDTO> chatListDTOs;
  final List<DoctorDTO> doctorsListDTO;
  final int unReadMessagesCount;
  final bool isPatientView;

  FavouriteChatData({
    required this.chatListDTOs,
    required this.doctorsListDTO,
    required this.unReadMessagesCount,
    required this.isPatientView,
  });

  factory FavouriteChatData.fromJson(Map<String, dynamic> json) {
    return FavouriteChatData(
      chatListDTOs: (json['chatListDTOs'] as List<dynamic>? ?? [])
          .map((e) => ChatDTO.fromJson(e))
          .toList(),
      doctorsListDTO: (json['doctorsListDTO'] as List<dynamic>? ?? [])
          .map((e) => DoctorDTO.fromJson(e))
          .toList(),
      unReadMessagesCount: json['unReadMessagesCount'] ?? 0,
      isPatientView: json['isPatientView'] ?? false,
    );
  }
}

class ChatDTO {
  final String? id;
  final String? name;
  final String? lastMessage;

  ChatDTO({
    this.id,
    this.name,
    this.lastMessage,
  });

  factory ChatDTO.fromJson(Map<String, dynamic> json) {
    return ChatDTO(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      lastMessage: json['lastMessage'] ?? '',
    );
  }
}

class DoctorDTO {
  final String? id;
  final String? name;
  final String? img;

  DoctorDTO({
    this.id,
    this.name,
    this.img,
  });

  factory DoctorDTO.fromJson(Map<String, dynamic> json) {
    return DoctorDTO(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      img: json['img'] ?? '',
    );
  }
}
