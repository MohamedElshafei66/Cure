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


      
      final response = await apiServices.post(endPoint: endpoint, body: body);


      Map<String, dynamic> jsonData;
      if (response is Map<String, dynamic>) {
        
        if (response.containsKey('data') && response['data'] != null) {
          jsonData = response['data'] as Map<String, dynamic>;

        } else {

          throw ServerException('No data in response');
        }
      } else {

        throw ServerException('Invalid response format');
      }


      final bookingModel = BookingModel.fromJson(jsonData);

      return bookingModel;
    } on DioException catch (e) {

      throw ServerException.fromDioError(e);
    } on ServerException catch (e) {

      rethrow;
    } catch (e, stackTrace) {

      throw ServerException('Unexpected error: ${e.toString()}');
    }
  }
}

