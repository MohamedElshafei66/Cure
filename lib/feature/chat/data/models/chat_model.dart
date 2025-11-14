class ChatModel {
  final bool success;
  final String message;
  final ChatData? data;

  ChatModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null ? ChatData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "success": success,
      "message": message,
      "data": data?.toJson(),
    };
  }
}

class ChatData {
  final int id;
  final String image;
  final String name;
  final String senderId;
  final String receiverId;
  final List<MessageDTO> messageList;

  ChatData({
    required this.id,
    required this.image,
    required this.name,
    required this.senderId,
    required this.receiverId,
    required this.messageList,
  });

  factory ChatData.fromJson(Map<String, dynamic> json) {
    return ChatData(
      id: json['id'] ?? 0,
      image: json['image'] ?? '',
      name: json['name'] ?? '',
      senderId: json['senderId'] ?? '',
      receiverId: json['receiverId'] ?? '',
      messageList: (json['messageListDTO'] as List<dynamic>?)
          ?.map((e) => MessageDTO.fromJson(e))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "image": image,
      "name": name,
      "senderId": senderId,
      "receiverId": receiverId,
      "messageListDTO": messageList.map((e) => e.toJson()).toList(),
    };
  }
}

class MessageDTO {
  final String message;
  final String senderId;
  final String receiverId;

  MessageDTO({
    this.message = '',
    this.senderId = '',
    this.receiverId = '',
  });

  factory MessageDTO.fromJson(Map<String, dynamic> json) {
    return MessageDTO(
      message: json['message'] ?? '',
      senderId: json['senderId'] ?? '',
      receiverId: json['receiverId'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "message": message,
      "senderId": senderId,
      "receiverId": receiverId,
    };
  }
}
