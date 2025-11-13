import '../../domain/entites/booking_entity.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/api_services.dart';
import '../models/booking_model.dart';
import 'package:dio/dio.dart';

abstract class BookingRemoteDataSource {
  Future<BookingEntity> createBooking({
    required int doctorId,
    required int slotId,
    required double amount,
    required int payment,
    required int status,
    required DateTime appointmentAt,
  });
}

class BookingRemoteDataSourceImpl implements BookingRemoteDataSource {
  final ApiServices apiServices;

  BookingRemoteDataSourceImpl({required this.apiServices});

  @override
  Future<BookingEntity> createBooking({
    required int doctorId,
    required int slotId,
    required double amount,
    required int payment,
    required int status,
    required DateTime appointmentAt,
  }) async {
    try {
      final endpoint = 'Customer/Booking/CreateBooking';
      
      final body = {
        'DoctorId': doctorId,
        'SlotId': slotId,
        'Amount': amount,
        'Payment': payment,
        'Status': status,
        'AppointmentAt': appointmentAt.toIso8601String(),
      };

      print('========================================');
      print('BOOKING API REQUEST - DATA SOURCE');
      print('========================================');
      print('Endpoint: $endpoint');
      print('Full Endpoint Path: Customer/Booking/CreateBooking');
      print('Request Body (Map):');
      print('  - DoctorId: ${body['DoctorId']} (${body['DoctorId'].runtimeType})');
      print('  - SlotId: ${body['SlotId']} (${body['SlotId'].runtimeType})');
      print('  - Amount: ${body['Amount']} (${body['Amount'].runtimeType})');
      print('  - Payment: ${body['Payment']} (${body['Payment'].runtimeType})');
      print('  - Status: ${body['Status']} (${body['Status'].runtimeType})');
      print('  - AppointmentAt: ${body['AppointmentAt']} (${body['AppointmentAt'].runtimeType})');
      print('Full Body JSON: $body');
      print('========================================');
      print('CALLING API SERVICES.POST...');
      print('========================================');
      
      final response = await apiServices.post(endPoint: endpoint, body: body);
      
      print('========================================');
      print('API SERVICES.POST RETURNED');
      print('========================================');
      
      print('========================================');
      print('BOOKING API RESPONSE');
      print('========================================');
      print('Full Response: $response');
      print('Response Type: ${response.runtimeType}');
      print('========================================');

      Map<String, dynamic> jsonData;
      if (response is Map<String, dynamic>) {
        print('Response is Map<String, dynamic>');
        print('Response keys: ${response.keys.toList()}');
        
        if (response.containsKey('data') && response['data'] != null) {
          jsonData = response['data'] as Map<String, dynamic>;
          print('========================================');
          print('EXTRACTED DATA FROM RESPONSE:');
          print('========================================');
          print('Booking Data:');
          print('  - id: ${jsonData['id']}');
          print('  - doctorId: ${jsonData['doctorId']}');
          print('  - doctorName: ${jsonData['doctorName']}');
          print('  - doctorSpeciality: ${jsonData['doctorSpeciality']}');
          print('  - patientId: ${jsonData['patientId']}');
          print('  - patientName: ${jsonData['patientName']}');
          print('  - payment: ${jsonData['payment']}');
          print('  - status: ${jsonData['status']}');
          print('  - paymentUrl: ${jsonData['paymentUrl']}');
          print('  - appointmentAt: ${jsonData['appointmentAt']}');
          print('========================================');
        } else {
          print('ERROR: No data key in response');
          throw ServerException('No data in response');
        }
      } else {
        print('ERROR: Invalid response format - not a Map');
        throw ServerException('Invalid response format');
      }

      print('Parsing Booking JSON to model...');
      final bookingModel = BookingModel.fromJson(jsonData);
      print('Booking model created successfully with ID: ${bookingModel.id}');
      print('========================================');
      return bookingModel;
    } on DioException catch (e) {
      print('DioException: ${e.message}');
      print('Response: ${e.response?.data}');
      print('Status Code: ${e.response?.statusCode}');
      throw ServerException.fromDioError(e);
    } on ServerException catch (e) {
      print('ServerException: ${e.message}');
      rethrow;
    } catch (e, stackTrace) {
      print('Unexpected error: $e');
      print('Stack trace: $stackTrace');
      throw ServerException('Unexpected error: ${e.toString()}');
    }
  }
}

