import '../../domain/entites/doctor_details_entity.dart';
import 'available_slot_model.dart';

class DoctorDetailsModel extends DoctorDetailsEntity {
 final int bookingCount;
 final int reviewCount;
 final List<String> reviewsList;
 final List<AvailableSlotModel> availableSlots;
  DoctorDetailsModel({
    required int doctorId,
    required String doctorName,
    required String doctorSpecialty,
    required String doctorLocation,
    required String doctorImage,
    required String doctorAbout,
    required num patients,
    required num experience,
    required num rating,
    required num reviews,
    required num doctorPrice,
    required this.bookingCount,
    required this.reviewCount,
    required this.availableSlots,
    required this.reviewsList
  }) : super(
    doctorId,
    doctorName,
    doctorSpecialty,
    doctorLocation,
    doctorImage,
    doctorAbout,
    patients,
    experience,
    rating,
    reviews,
    doctorPrice,
  );

  factory DoctorDetailsModel.fromJson(Map<String, dynamic> json) {
    try {
      print('Model: Parsing JSON');
      print('JSON keys: ${json.keys.toList()}');
      
      final doctorId = json['id'] is int ? json['id'] : (json['id'] is String ? int.tryParse(json['id']) ?? 0 : 0);
      final doctorName = _parseString(json['fullName']);
      
      // Handle specialities - could be List<String> or List<Map> or String
      String doctorSpecialty = '';
      if (json['specialities'] != null) {
        if (json['specialities'] is List && (json['specialities'] as List).isNotEmpty) {
          final firstItem = (json['specialities'] as List)[0];
          if (firstItem is String) {
            doctorSpecialty = firstItem;
          } else if (firstItem is Map) {
            // If it's a map, try to get 'name' or 'title' field
            doctorSpecialty = firstItem['name']?.toString() ?? 
                            firstItem['title']?.toString() ?? 
                            firstItem['speciality']?.toString() ?? '';
          }
        } else if (json['specialities'] is String) {
          doctorSpecialty = json['specialities'] as String;
        }
      }
      
      print('Model: doctorId=$doctorId, name=$doctorName, specialty=$doctorSpecialty');
      
      return DoctorDetailsModel(
        doctorId: doctorId,
        doctorName: doctorName,
        doctorSpecialty: doctorSpecialty,
        doctorLocation: _parseString(json['address']),
        doctorImage: _parseString(json['imgUrl']),
        doctorAbout: _parseString(json['about']),
        patients: _parseNum(json['bookingCount']),
        experience: _parseNum(json['experienceYears']),
        rating: _parseNum(json['rating']).toDouble(),
        reviews: _parseNum(json['reviewsCount']),
        doctorPrice: _parseNum(json['pricePerHour']),
        bookingCount: _parseNum(json['bookingCount']).toInt(),
        reviewCount: _parseNum(json['reviewsCount']).toInt(),
        availableSlots: _parseAvailableSlots(json['availableSlots']),
        reviewsList: _parseStringList(json['reviews']),
      );
    } catch (e, stackTrace) {
      print('Model: Error parsing JSON - $e');
      print('Stack trace: $stackTrace');
      rethrow;
    }
  }
  
  static String _parseString(dynamic value) {
    if (value == null) return '';
    if (value is String) return value;
    return value.toString();
  }
  
  static num _parseNum(dynamic value) {
    if (value == null) return 0;
    if (value is num) return value;
    if (value is String) {
      return num.tryParse(value) ?? 0;
    }
    return 0;
  }
  
  static List<String> _parseStringList(dynamic value) {
    if (value == null) return [];
    if (value is List) {
      return value.map((item) {
        if (item is String) return item;
        if (item is Map) {
          // If it's a map, try to get a string representation
          return item.toString();
        }
        return item.toString();
      }).toList().cast<String>();
    }
    return [];
  }
  
  static List<AvailableSlotModel> _parseAvailableSlots(dynamic value) {
    if (value == null) return [];
    if (value is List) {
      return value.map((item) {
        if (item is Map<String, dynamic>) {
          try {
            return AvailableSlotModel.fromJson(item);
          } catch (e) {
            print('Error parsing slot: $e');
            return null;
          }
        }
        return null;
      }).whereType<AvailableSlotModel>().toList();
    }
    return [];
  }
}
