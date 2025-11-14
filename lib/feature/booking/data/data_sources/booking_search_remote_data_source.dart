import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/api_services.dart';
import '../models/booking_search_model.dart';
import 'package:dio/dio.dart';

abstract class BookingSearchRemoteDataSource {
  Future<List<BookingSearchModel>> searchBookings(String fromDate);
  Future<BookingSearchModel> cancelBooking(String bookingId);
  Future<BookingSearchModel> rescheduleBooking(String bookingId, String newDateTime);
}

class BookingSearchRemoteDataSourceImpl implements BookingSearchRemoteDataSource {
  final ApiServices apiServices;

  BookingSearchRemoteDataSourceImpl({required this.apiServices});

  @override
  Future<List<BookingSearchModel>> searchBookings(String fromDate) async {
    try {
      final endpoint = 'Customer/Booking/BookingSearch?FromDate=$fromDate';
      final response = await apiServices.get(endPoint: endpoint);
      if (response is Map<String, dynamic>) {
        final success = response['success'] ?? false;
        if (success) {
          final data = response['data'] as List<dynamic>?;
          if (data != null) {
            return data
                .map((json) => BookingSearchModel.fromJson(json as Map<String, dynamic>))
                .toList();
          } else {
            return [];
          }
        } else {
          final message = response['message'] ?? 'Failed to fetch bookings';
          throw ServerException(message);
        }
      }
      
      throw ServerException('Invalid response format');
    } on DioException catch (e) {
      throw ServerException.fromDioError(e);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<BookingSearchModel> cancelBooking(String bookingId) async {
    try {
      final endpoint = 'Customer/Booking/CancelBooking/$bookingId';
      
      final response = await apiServices.put(endPoint: endpoint);


      if (response is Map<String, dynamic>) {
        final success = response['success'] ?? false;
        if (success) {
          final data = response['data'] as Map<String, dynamic>?;
          if (data != null) {
            return BookingSearchModel.fromJson(data);
          } else {
            throw ServerException('No data in response');
          }
        } else {
          final message = response['message'] ?? 'Failed to cancel booking';
          throw ServerException(message);
        }
      }
      
      throw ServerException('Invalid response format');
    } on DioException catch (e) {

      throw ServerException.fromDioError(e);
    } catch (e) {

      throw ServerException(e.toString());
    }
  }

  @override
  Future<BookingSearchModel> rescheduleBooking(String bookingId, String newDateTime) async {
    try {
      final endpoint = 'Customer/Booking/RescheduleBooking/$bookingId';
      

      
      // The API expects the body to be a JSON string with the date
      final response = await apiServices.put(
        endPoint: endpoint,
        body: newDateTime, // The API expects just the date string as body
      );


      if (response is Map<String, dynamic>) {
        final success = response['success'] ?? false;
        if (success) {
          final data = response['data'] as Map<String, dynamic>?;
          if (data != null) {
            return BookingSearchModel.fromJson(data);
          } else {
            throw ServerException('No data in response');
          }
        } else {
          final message = response['message'] ?? 'Failed to reschedule booking';
          throw ServerException(message);
        }
      }
      
      throw ServerException('Invalid response format');
    } on DioException catch (e) {

      throw ServerException.fromDioError(e);
    } catch (e) {

      throw ServerException(e.toString());
    }
  }
}

