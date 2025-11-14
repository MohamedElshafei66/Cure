class SearchChatModel {
  final bool success;
  final String message;
  final SearchChatData data;

  SearchChatModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory SearchChatModel.fromJson(Map<String, dynamic> json) {
    return SearchChatModel(
      success: json['success'],
      message: json['message'],
      data: SearchChatData.fromJson(json['data']),
    );
  }
}

class SearchChatData {
  final List<DoctorModel> doctorsListDTO;
  final int unReadMessagesCount;
  final bool isPatientView;

  SearchChatData({
    required this.doctorsListDTO,
    required this.unReadMessagesCount,
    required this.isPatientView,
  });

  factory SearchChatData.fromJson(Map<String, dynamic> json) {
    return SearchChatData(
      doctorsListDTO: (json['doctorsListDTO'] as List)
          .map((e) => DoctorModel.fromJson(e))
          .toList(),
      unReadMessagesCount: json['unReadMessagesCount'],
      isPatientView: json['isPatientView'],
    );
  }
}

class DoctorModel {
  final String id;
  final String name;
  final String img;

  DoctorModel({
    required this.id,
    required this.name,
    required this.img,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      id: json['id'],
      name: json['name'],
      img: json['img'],
    );
  }
}
