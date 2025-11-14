class UnreadChatModel {
  final bool success;
  final String message;
  final UnreadData? data;

  UnreadChatModel({required this.success, required this.message, this.data});

  factory UnreadChatModel.fromJson(Map<String, dynamic> json) {
    return UnreadChatModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null ? UnreadData.fromJson(json['data']) : null,
    );
  }
}

class UnreadData {
  final List<DoctorDTO> doctorsListDTO;

  UnreadData({required this.doctorsListDTO});

  factory UnreadData.fromJson(Map<String, dynamic> json) {
    return UnreadData(
      doctorsListDTO: (json['doctorsListDTO'] as List<dynamic>?)
          ?.map((e) => DoctorDTO.fromJson(e))
          .toList() ??
          [],
    );
  }
}

class DoctorDTO {
  final String id;
  final String name;
  final String img;

  DoctorDTO({required this.id, required this.name, required this.img});

  factory DoctorDTO.fromJson(Map<String, dynamic> json) {
    return DoctorDTO(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      img: json['img'] ?? '',
    );
  }
}
