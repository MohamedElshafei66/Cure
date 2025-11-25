class ChatModel {
  final bool success;
  final String message;
  final ChatData? data;

  ChatModel({required this.success, required this.message, required this.data});

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null ? ChatData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {"success": success, "message": message, "data": data?.toJson()};
  }
}

/// Pagination model
class PaginationModel {
  final int pageNumber;
  final int pageSize;
  final int totalRecords;
  final int totalPages;

  PaginationModel({
    required this.pageNumber,
    required this.pageSize,
    required this.totalRecords,
    required this.totalPages,
  });

  factory PaginationModel.fromJson(Map<String, dynamic> json) {
    return PaginationModel(
      pageNumber: json['pageNumber'] ?? 1,
      pageSize: json['pageSize'] ?? 10,
      totalRecords: json['totalRecords'] ?? 0,
      totalPages: json['totalPages'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "pageNumber": pageNumber,
      "pageSize": pageSize,
      "totalRecords": totalRecords,
      "totalPages": totalPages,
    };
  }
}

/// Model for chat list response (matches API structure)
class ChatListModel {
  final bool success;
  final String message;
  final List<ChatData> chatListDTOS;
  final List<ChatData> doctorsListDTO;
  final PaginationModel pagination;
  final int unReadMessagesCount;
  final bool isPatientView;

  ChatListModel({
    required this.success,
    required this.message,
    required this.chatListDTOS,
    required this.doctorsListDTO,
    required this.pagination,
    required this.unReadMessagesCount,
    required this.isPatientView,
  });

  factory ChatListModel.fromJson(Map<String, dynamic> json) {
    print('📥 Parsing ChatListModel from JSON');
    print('  JSON keys: ${json.keys.toList()}');

    // Parse the data object
    Map<String, dynamic> dataObj = {};
    if (json['data'] != null && json['data'] is Map) {
      dataObj = json['data'] as Map<String, dynamic>;
      print('  Data keys: ${dataObj.keys.toList()}');
    }

    // Parse chatListDTOS
    List<ChatData> chatList = [];
    if (dataObj['chatListDTOS'] != null && dataObj['chatListDTOS'] is List) {
      chatList = (dataObj['chatListDTOS'] as List<dynamic>)
          .map((e) {
            try {
              return ChatData.fromJson(e as Map<String, dynamic>);
            } catch (err) {
              print('  ⚠️ Error parsing chat item: $err');
              return null;
            }
          })
          .whereType<ChatData>()
          .toList();
      print('  ✅ Parsed ${chatList.length} chats from chatListDTOS');
    }

    // Parse doctorsListDTO
    List<ChatData> doctorsList = [];
    if (dataObj['doctorsListDTO'] != null &&
        dataObj['doctorsListDTO'] is List) {
      doctorsList = (dataObj['doctorsListDTO'] as List<dynamic>)
          .map((e) {
            try {
              return ChatData.fromJson(e as Map<String, dynamic>);
            } catch (err) {
              print('  ⚠️ Error parsing doctor item: $err');
              return null;
            }
          })
          .whereType<ChatData>()
          .toList();
      print('  ✅ Parsed ${doctorsList.length} doctors from doctorsListDTO');
    }

    // Parse pagination
    PaginationModel pagination = PaginationModel(
      pageNumber: 1,
      pageSize: 10,
      totalRecords: 0,
      totalPages: 0,
    );
    if (dataObj['pagination'] != null && dataObj['pagination'] is Map) {
      pagination = PaginationModel.fromJson(
        dataObj['pagination'] as Map<String, dynamic>,
      );
    }

    return ChatListModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      chatListDTOS: chatList,
      doctorsListDTO: doctorsList,
      pagination: pagination,
      unReadMessagesCount: dataObj['unReadMessagesCount'] ?? 0,
      isPatientView: dataObj['isPatientView'] ?? true,
    );
  }

  // Getter for backward compatibility (returns chatListDTOS)
  List<ChatData> get data => chatListDTOS;

  Map<String, dynamic> toJson() {
    return {
      "success": success,
      "message": message,
      "data": {
        "chatListDTOS": chatListDTOS.map((e) => e.toJson()).toList(),
        "doctorsListDTO": doctorsListDTO.map((e) => e.toJson()).toList(),
        "pagination": pagination.toJson(),
        "unReadMessagesCount": unReadMessagesCount,
        "isPatientView": isPatientView,
      },
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
    print('📥 Parsing ChatData from JSON:');
    print('  Raw JSON: $json');

    final chatData = ChatData(
      id: json['id'] ?? 0,
      image: json['image'] ?? '',
      name: json['name'] ?? '',
      senderId: json['senderId'] ?? '',
      receiverId: json['receiverId'] ?? '',
      messageList:
          (json['messageListDTO'] as List<dynamic>?)
              ?.map((e) => MessageDTO.fromJson(e))
              .toList() ??
          [],
    );

    print('  ✅ Parsed: id=${chatData.id}, receiverId=${chatData.receiverId}');
    return chatData;
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

  MessageDTO({this.message = '', this.senderId = '', this.receiverId = ''});

  factory MessageDTO.fromJson(Map<String, dynamic> json) {
    return MessageDTO(
      message: json['message'] ?? '',
      senderId: json['senderId'] ?? '',
      receiverId: json['receiverId'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {"message": message, "senderId": senderId, "receiverId": receiverId};
  }
}
